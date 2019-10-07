#include "memory.hpp"
#include <stdio.h>

typedef struct MemoryBlock {
	MemoryBlock *next;
	unsigned size;
} MemoryBlock;

static MemoryBlock *memory;

void memory_init(void *ptr, unsigned size) {
	MemoryBlock *m = (MemoryBlock *)ptr;
	m->next = m;
	m->size = (size - sizeof(MemoryBlock)) / sizeof(MemoryBlock);
	
	memory = m;
}

void *memory_alloc(unsigned size) {
	MemoryBlock *block, *previousBlock = memory;
	unsigned blockSize = (size + sizeof(MemoryBlock) - 1) / sizeof(MemoryBlock) + 1;
	
	for (block = previousBlock->next; ; previousBlock = block, block = block->next) {
		if (block->size >= blockSize) {
			if (block->size == blockSize)
				previousBlock->next = block->next;
			else {
				block->size -= blockSize;
				block += block->size;
				block->size = blockSize;
			}
			
			memory = previousBlock;
			
			return (void *)(block + 1);
		}
		
		if (block == memory)
			return NULL;
	}
	
	return NULL;
}
