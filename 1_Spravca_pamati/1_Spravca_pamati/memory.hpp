#ifndef memory_hpp
#define memory_hpp

void memory_init(void *ptr, unsigned size);
void *memory_alloc(unsigned size);
int memory_free(void *valid_ptr);
int memory_check(void *ptr);

#endif
