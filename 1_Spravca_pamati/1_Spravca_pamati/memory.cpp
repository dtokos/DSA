#include "memory.hpp"
#include <stdio.h>

typedef struct Block {
	Block *next;
	unsigned size;
} __attribute__((packed)) Block;

typedef struct Memory {
	Block *firstFreeBlock;
} __attribute__((packed)) Memory;

static Memory *memory;

void advanceBlock(Block **block, unsigned bytes);
Block* adjacendBlock(Block *block);

void memory_init(void *ptr, unsigned size) {
	Memory *m = (Memory *)ptr;
	Block *b = (Block *)(m + 1);
	b->next = b;
	b->size = size - sizeof(Memory) - sizeof(Block);
	m->firstFreeBlock = b;
	
	memory = m;
}

void *memory_alloc(unsigned size) {
	Block *block, *previousBlock = memory->firstFreeBlock;
	
	for (block = previousBlock->next; ; previousBlock = block, block = block->next) {
		if (block->size == size){
			previousBlock->next = block->next;
			
			memory->firstFreeBlock = previousBlock;
			return (void *)(block + 1);
		} else if (block->size >= size + sizeof(Block)) {
			block->size -= size + sizeof(Block);
			advanceBlock(&block, block->size + sizeof(Block));
			block->size = size;
			
			memory->firstFreeBlock = previousBlock;
			return (void *)(block + 1);
		}
		
		if (block == memory->firstFreeBlock)
			return NULL;
	}
	
	return NULL;
}

void advanceBlock(Block **block, unsigned bytes) {
	*(char **)block += bytes;
}

int memory_free(void *ptr) {
	Block *block, *freedBlock = (Block *)ptr - 1;
	
	for (block = memory->firstFreeBlock; !(freedBlock > block && freedBlock < block->next); block = block->next)
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
	
	memory->firstFreeBlock = block;
	
	return 0;
}

Block* adjacendBlock(Block *block) {
	return (Block*)((char *)block + block->size + sizeof(Block));
}
