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
	Block *firstFreeBlock;
	void *firstPtr;
	void *lastPtr;
} __attribute__((packed)) Memory;

static Memory memory;

unsigned neededSizeFor(unsigned size);
unsigned blockMemorySize(Block *block);
void setBlockMemorySize(Block *block, unsigned size);
unsigned blockSegmentSize(Block *block);
void advanceBlock(Block **block, unsigned bytes);
Block* adjacendBlock(Block *block);
void* blockStart(Block *block);

void memory_init(void *ptr, unsigned size) {
	if (size - sizeof(Block) < CBLOCK_LIMIT) {
		Block *b = (Block *)ptr;
		b->next = b;
		b->sizeHeader = size - sizeof(Block);
		
		memory.firstFreeBlock = b;
	} else {
		UBlock *b = (UBlock *)ptr;
		b->next = (Block *)((char *)b + 4);
		b->sizeHeader = UBLOCK_SIZE;
		b->size = size - sizeof(UBlock);
		  
		memory.firstFreeBlock = b->next;
	}
	
	memory.firstPtr = ptr;
	memory.lastPtr = (char *)ptr + size - 1;
}

void *memory_alloc(unsigned size) {
	Block *block, *previousBlock = memory.firstFreeBlock;
	int blockSize, neededSize = neededSizeFor(size);
	
	for (block = previousBlock->next; ; previousBlock = block, block = block->next) {
		blockSize = blockMemorySize(block);
		
		if (blockSize == size) {
			previousBlock->next = block->next;
			
			memory.firstFreeBlock = previousBlock;
			return (void *)(block + 1);
		} else if (blockSize >= neededSize) {
			setBlockMemorySize(block, blockSize - neededSize);
			advanceBlock(&block, blockSize - neededSize + (neededSize - size));
			setBlockMemorySize(block, size);
			
			memory.firstFreeBlock = previousBlock;
			return (void *)(block + 1);
		}
		
		if (block == memory.firstFreeBlock)
			return NULL;
	}
	
	return NULL;
}

unsigned neededSizeFor(unsigned size) {
	return size < CBLOCK_LIMIT ? size + sizeof(Block) : size + sizeof(UBlock);
}

unsigned blockMemorySize(Block *block) {
	unsigned char sizeHeader = block->sizeHeader & SIZE_HEADER_MASK;
	
	return sizeHeader == CBLOCK_SIZE ? block->sizeHeader : convertToUBlock(block)->size;
}

void setBlockMemorySize(Block *block, unsigned size) {
	if (size < CBLOCK_LIMIT)
		block->sizeHeader = size;
	else {
		block->sizeHeader = UBLOCK_SIZE;
		convertToUBlock(block)->size = size;
	}
}

unsigned blockSegmentSize(Block *block) {
	unsigned char sizeHeader = block->sizeHeader & SIZE_HEADER_MASK;
	
	return sizeHeader == CBLOCK_SIZE ?
		block->sizeHeader + sizeof(Block) :
		convertToUBlock(block)->size + sizeof(UBlock);
}

void advanceBlock(Block **block, unsigned bytes) {
	*(char **)block += bytes;
}

int memory_free(void *ptr) {
	Block *block, *freedBlock = (Block *)ptr - 1;
	
	for (block = memory.firstFreeBlock; !(freedBlock > block && freedBlock < block->next); block = block->next)
		if (block >= block->next && (freedBlock > block || freedBlock < block->next))
			break;
	
	if (adjacendBlock(freedBlock) == blockStart(block->next)) {
		setBlockMemorySize(freedBlock, blockMemorySize(freedBlock) + blockSegmentSize(block->next));
		freedBlock->next = block->next->next;
	} else
		freedBlock->next = block->next;
	
	if (adjacendBlock(block) == blockStart(freedBlock)) {
		setBlockMemorySize(block, blockMemorySize(block) + blockSegmentSize(freedBlock));
		block->next = freedBlock->next;
	} else
		block->next = freedBlock;
	
	memory.firstFreeBlock = block;
	
	return 0;
}

Block* adjacendBlock(Block *block) {
	unsigned char sizeHeader = block->sizeHeader & SIZE_HEADER_MASK;
	
	return sizeHeader == CBLOCK_SIZE ?
		(Block*)((char *)block + block->sizeHeader + sizeof(Block)) :
		(Block*)((char *)block + convertToUBlock(block)->size + sizeof(Block));
}

int memory_check(void *ptr) {
	Block *checkedBlock = (Block *)ptr - 1;
	
	if (checkedBlock < memory.firstPtr || checkedBlock > memory.lastPtr)
		return 0;
	
	Block *block;
	for (block = memory.firstFreeBlock->next; ; block = block->next) {
		if (checkedBlock >= block && checkedBlock < adjacendBlock(block))
			return 0;
		
		if (block == memory.firstFreeBlock)
			break;
	}
	
	return 1;
}

void* blockStart(Block *block) {
	return (char *)block - (sizeof(int) * ((block->sizeHeader & SIZE_HEADER_MASK) == UBLOCK_SIZE));
}
