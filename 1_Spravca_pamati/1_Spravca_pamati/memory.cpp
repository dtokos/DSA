#include "memory.hpp"
#include <stdio.h>

struct _block {
	struct _block *next;
	unsigned size;
} __attribute__((packed));
typedef struct _block Block;

typedef struct Memory {
	Block *firstFreeBlock;
	void *firstPtr;
	void *lastPtr;
} __attribute__((packed)) Memory;

static Memory memory;

void advanceBlock(Block **block, unsigned bytes);
Block* adjacendBlock(Block *block);

void memory_init(void *ptr, unsigned size) {
	Block *b = (Block *)ptr;
	b->next = b;
	b->size = size - sizeof(Block);
	memory.firstFreeBlock = b;
	memory.firstPtr = ptr;
	memory.lastPtr = (char *)ptr + size - 1;
}

void *memory_alloc(unsigned size) {
	Block *block, *previousBlock = memory.firstFreeBlock;
	
	for (block = previousBlock->next; ; previousBlock = block, block = block->next) {
		if (block->size == size) {
			previousBlock->next = block->next;
			
			memory.firstFreeBlock = previousBlock;
			return (void *)(block + 1);
		} else if (block->size >= size + sizeof(Block)) {
			block->size -= size + sizeof(Block);
			advanceBlock(&block, block->size + sizeof(Block));
			block->size = size;
			
			memory.firstFreeBlock = previousBlock;
			return (void *)(block + 1);
		}
		
		if (block == memory.firstFreeBlock)
			return NULL;
	}
	
	return NULL;
}

void advanceBlock(Block **block, unsigned bytes) {
	*(char **)block += bytes;
}

int memory_free(void *ptr) {
	Block *block, *freedBlock = (Block *)ptr - 1;
	
	for (block = memory.firstFreeBlock; !(freedBlock > block && freedBlock < block->next); block = block->next)
		if (block >= block->next && (freedBlock > block || freedBlock < block->next))
			break;
	
	if (adjacendBlock(freedBlock) == block->next) {
		freedBlock->size += block->next->size + sizeof(Block);
		freedBlock->next = block->next->next;
	} else
		freedBlock->next = block->next;
	
	if (adjacendBlock(block) == freedBlock) {
		block->size += freedBlock->size + sizeof(Block);
		block->next = freedBlock->next;
	} else
		block->next = freedBlock;
	
	memory.firstFreeBlock = block;
	
	return 0;
}

Block* adjacendBlock(Block *block) {
	return (Block*)((char *)block + block->size + sizeof(Block));
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
