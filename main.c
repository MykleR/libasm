#include "headers/libasm.h"
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

void test_write(int out, const char *src, size_t n)
{
	errno = 0;
	ssize_t r1 = ft_write(out, src, n);
	printf("ft_write => %lu (errno=%d)\n",r1, errno);

	errno = 0;
	ssize_t r2 = write(out, src, n);
	printf("write => %lu (errno=%d)\n",r2, errno);
	errno = 0;
}

int main(int ac, char **av)
{

	if (ac < 2) return 0;
	test_write(-1, "", 1);
	
	printf("\n");
	printf("ft_strlen	\"%s\"  => %lu\n", av[1], ft_strlen(av[1]));
	printf("strlen		\"%s\"  => %lu\n", av[1], strlen(av[1]));

	printf("\n");
	char dest[1024] = {0};
	printf("ft_strcpy	\"%s\", at %p => \"%s\"\n", av[1], ft_strcpy(dest, av[1]), dest);
	memset(dest, 0, 1024);
	printf("strcpy		\"%s\", at %p => \"%s\"\n", av[1], strcpy(dest, av[1]), dest);

	printf("\n");
	char *dup1 = ft_strdup(av[1]);
	printf("ft_strdup	\"%s\"  => \"%s\" (errno=%d)\n", av[1], dup1 ? dup1 : "NULL", errno);
	free(dup1);
	errno = 0;
	char *dup2 = strdup(av[1]);
	printf("strdup		\"%s\"  => \"%s\" (errno=%d)\n", av[1], dup2 ? dup2 : "NULL", errno);
	free(dup2);

	printf("\n");
	if (ac < 3) return 0;
	printf("ft_strcmp	\"%s\", \"%s\"  => %d\n", av[1], av[2], ft_strcmp(av[1], av[2]));
	printf("strcmp		\"%s\", \"%s\"  => %d\n", av[1], av[2], strcmp(av[1], av[2]));

	return 0;
}
