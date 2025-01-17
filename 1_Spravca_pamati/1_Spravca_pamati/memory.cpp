#include "memory.hpp"
#include <stdio.h>

#define SIZE_HEADER_MASK (unsigned char)~((unsigned char)(~0) >> 1)
#define CBLOCK_SIZE (unsigned char)~((unsigned char)(~0) >> 0)
#define CBLOCK_LIMIT (unsigned char)~((unsigned char)(~0) >> 1)
#define UBLOCK_SIZE (unsigned char)~((unsigned char)(~0) >> 1)
#define UBLOCK_LIMIT (unsigned int)~((unsigned int)(~0) >> 1)

#define convertToUBlock(block) (((UBlock *)((char *)block - sizeof(int))))

struct _block {
	struct _block *next;
	unsigned char sizeHeader;
} __attribute__((packed));
typedef struct _block Block;

struct _ublock {
	unsigned int size;
	struct _block *next;
	unsigned char sizeHeader;
} __attribute__((packed));
typedef struct _ublock UBlock;

typedef struct Memory {
	Block *freeBlock;
	void *firstPtr;
	void *lastPtr;
} __attribute__((packed)) Memory;

static Memory memory;

unsigned neededSizeFor(unsigned size);
unsigned blockMemorySize(Block *block);
Block* setBlockMemorySize(Block *block, unsigned size, unsigned char shouldMoveOnChange);
unsigned blockSegmentSize(Block *block);
void advanceBlock(Block **block, int bytes);
Block* adjacendBlock(Block *block);
void* blockStart(Block *block);

void memory_init(void *ptr, unsigned size) {
	if (size - sizeof(Block) < CBLOCK_LIMIT) {
		Block *b = (Block *)ptr;
		b->next = b;
		b->sizeHeader = size - sizeof(Block);
		
		memory.freeBlock = b;
	} else {
		UBlock *b = (UBlock *)ptr;
		b->next = (Block *)((char *)b + 4);
		b->sizeHeader = UBLOCK_SIZE;
		b->size = size - sizeof(UBlock);
		  
		memory.freeBlock = b->next;
	}
	
	memory.firstPtr = ptr;
	memory.lastPtr = (char *)ptr + size - 1;
}

void *memory_alloc(unsigned size) {
	Block *block, *previousBlock = memory.freeBlock;
	int blockSize, neededSize = neededSizeFor(size);
	
	for (block = previousBlock->next; ; previousBlock = block, block = block->next) {
		blockSize = blockMemorySize(block);
		
		if (blockSize == size) {
			previousBlock->next = block->next;
			
			memory.freeBlock = previousBlock;
			return (void *)(block + 1);
		} else if (blockSize > neededSize) {
			if (previousBlock == block)
				previousBlock = block = setBlockMemorySize(block, blockSize - neededSize, 1);
			else
				block = setBlockMemorySize(block, blockSize - neededSize, 1);
			previousBlock->next = block;
			blockSize = blockMemorySize(block);
			advanceBlock(&block, blockSize + (neededSize - size));
			setBlockMemorySize(block, size, 0);
			
			memory.freeBlock = previousBlock;
			return (void *)(block + 1);
		}
		
		if (block == memory.freeBlock)
			return NULL;
	}
	
	return NULL;
}

int memory_free(void *ptr) {
	Block *block, *previousBlock = memory.freeBlock, *freedBlock = (Block *)ptr - 1;
	
	for (block = previousBlock->next; !(freedBlock > block && freedBlock < block->next); previousBlock = block, block = block->next)
		if (block >= block->next && (freedBlock > block || freedBlock < block->next))
			break;
	
	if (adjacendBlock(freedBlock) == blockStart(block->next)) {
		freedBlock = setBlockMemorySize(freedBlock, blockMemorySize(freedBlock) + blockSegmentSize(block->next), 1);
		freedBlock->next = block->next->next;
	} else
		freedBlock->next = block->next;
	
	if (adjacendBlock(block) == blockStart(freedBlock)) {
		if (previousBlock == block) {
			previousBlock = block = setBlockMemorySize(block, blockMemorySize(block) + blockSegmentSize(freedBlock), 1);
			block->next = block;
		} else {
			block = setBlockMemorySize(block, blockMemorySize(block) + blockSegmentSize(freedBlock), 1);
			block->next = freedBlock->next;
		}
		previousBlock->next = block;
	} else
		block->next = freedBlock;
	
	memory.freeBlock = block;
	
	return 0;
}

int memory_check(void *ptr) {
	Block *checkedBlock = (Block *)ptr - 1;
	
	if ((void *)checkedBlock < memory.firstPtr || (void *)checkedBlock > memory.lastPtr)
		return 0;
	
	Block *block;
	for (block = memory.freeBlock->next; ; block = block->next) {
		if (checkedBlock >= block && checkedBlock < adjacendBlock(block))
			return 0;
		
		if (block == memory.freeBlock)
			break;
	}
	
	return 1;
}

unsigned neededSizeFor(unsigned size) {
	return size < CBLOCK_LIMIT ? size + sizeof(Block) : size + sizeof(UBlock);
}

unsigned blockMemorySize(Block *block) {
	unsigned char sizeHeader = block->sizeHeader & SIZE_HEADER_MASK;
	
	return sizeHeader == CBLOCK_SIZE ? block->sizeHeader : convertToUBlock(block)->size;
}

Block* setBlockMemorySize(Block *block, unsigned size, unsigned char shouldMoveOnChange) {
	if (!shouldMoveOnChange) {
		if (size < CBLOCK_LIMIT)
			block->sizeHeader = size;
		else {
			block->sizeHeader = UBLOCK_SIZE;
			convertToUBlock(block)->size = size;
		}
	} else {
		unsigned char sizeHeader = block->sizeHeader & SIZE_HEADER_MASK;
		
		if (sizeHeader == CBLOCK_SIZE) {
			if (size < CBLOCK_LIMIT) {
				block->sizeHeader = size;
			} else {
				advanceBlock(&block, sizeof(unsigned));
				block->sizeHeader = UBLOCK_SIZE;
				convertToUBlock(block)->size = size - sizeof(unsigned);
			}
		} else {
			if (size + sizeof(unsigned) < CBLOCK_LIMIT) {
				Block *next = block->next;
				advanceBlock(&block, (int)-sizeof(unsigned));
				block->next = next;
				block->sizeHeader = size + sizeof(unsigned);
			} else {
				block->sizeHeader = UBLOCK_SIZE;
				convertToUBlock(block)->size = size;
			}
		}
	}
	
	return block;
}

unsigned blockSegmentSize(Block *block) {
	unsigned char sizeHeader = block->sizeHeader & SIZE_HEADER_MASK;
	
	return sizeHeader == CBLOCK_SIZE ?
		block->sizeHeader + sizeof(Block) :
		convertToUBlock(block)->size + sizeof(UBlock);
}

void advanceBlock(Block **block, int bytes) {
	*(char **)block += bytes;
}

Block* adjacendBlock(Block *block) {
	unsigned char sizeHeader = block->sizeHeader & SIZE_HEADER_MASK;
	
	return sizeHeader == CBLOCK_SIZE ?
		(Block*)((char *)block + block->sizeHeader + sizeof(Block)) :
		(Block*)((char *)block + convertToUBlock(block)->size + sizeof(Block));
}

void* blockStart(Block *block) {
	return (char *)block - (sizeof(int) * ((block->sizeHeader & SIZE_HEADER_MASK) == UBLOCK_SIZE));
}
