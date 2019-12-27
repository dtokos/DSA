#include <stdio.h>
#include "table.hpp"

int main(void) {
	int i, a[10], na, b[10], nb;
	scanf("%d", &na);
	for (i = 0; i < na; i++)
		scanf("%d", &a[i]);
	scanf("%d", &nb);
	for (i = 0; i < nb; i++)
		scanf("%d", &b[i]);
	if (is_subset(a, na, b, nb))
		printf("PODMNOZINA\n");
	else
		printf("NIE\n");
	return 0;
}
