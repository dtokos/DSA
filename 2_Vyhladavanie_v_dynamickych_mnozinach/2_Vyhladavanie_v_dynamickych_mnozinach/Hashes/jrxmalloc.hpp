#ifndef jrxmalloc_hpp
#define jrxmalloc_hpp

#include <stdlib.h>

/* Prototypes for functions defined in xmalloc.c  */
void *xmalloc (size_t size);
void *xcalloc (size_t nmemb, size_t size);
void *xrealloc (void *ptr, size_t size);
char *xstrdup (const char *s);

#endif
