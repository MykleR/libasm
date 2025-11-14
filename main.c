#include "headers/libasm.h"
#include <stdio.h>
#include <string.h>

int main(int ac, char **av)
{
	if (ac < 2) return 0;
	printf("ft_strlen	\"%s\"  => %lu\n", av[1], ft_strlen(av[1]));
	printf("strlen		\"%s\"  => %lu\n", av[1], strlen(av[1]));

	printf("\n");
	if (ac < 3) return 0;
	printf("ft_strcmp	\"%s\", \"%s\"  => %d\n", av[1], av[2], ft_strcmp(av[1], av[2]));
	printf("strcmp		\"%s\", \"%s\"  => %d\n", av[1], av[2], strcmp(av[1], av[2]));

	return 0;
}
