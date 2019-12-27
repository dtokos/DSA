#include <stdio.h>
#include <string.h>
#include "table.hpp"

int main(void) {
	char **a = NULL, buf[100];
	int n = 0, len = 0;
	
	while (scanf("%s", buf) > 0) {
		if (n == len) {
			len = len + len + (len == 0);
			a = (char**)realloc(a, len * sizeof(char*));
		}
		
		a[n++] = strdup(buf);
	}
	
	printf("Pocet duplikatov: %d\n", vyhadzovac(a, n));
	
	return 0;
}
