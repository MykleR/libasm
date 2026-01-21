#include <stdlib.h>
#include <stdio.h>
#include "headers/libasm_bonus.h"
#include <time.h>

#define IS_DIGIT(C) (C >= '0' && C <= '9')
#define IS_EMPTY(C) ((C >= '\t' && C <= '\r') || C == ' ')
#define IS_SIGN(C) (C == '-' || C == '+')
#define SIGN(C) ((C != '-') - (C == '-'))

#define LOT_INDEX(C) (lot[C >> 3])
#define LOT_MASK(C) (1 << (C & 7))
#define LOT_SET(C) LOT_INDEX(C) |= LOT_MASK(C)
#define LOT_CHECK(C) (LOT_INDEX(C) & LOT_MASK(C))

static inline int check_base(const char *base)
{
	unsigned char lot[16] = {0};
	*(unsigned long*)lot = 0x280100003e00;
	const char *start = base--;
	while (*++base > 0 && !LOT_CHECK(*base))
		LOT_SET(*base);
	int len = base - start;
	return (len > 1 && !(*base)) ? len : 0;
}

static inline int find_base(const char *base, char c)
{
	const char *start = base;
	while (*base && *base != c) base++;
	return (*base) ? base - start : -1;
}

int	ft_atoi_base_2(char *str, char *base)
{
	int len = check_base(base);
	if (!len) return 0;
	while (IS_EMPTY(*str))
		str++;
	int	res = 0;
	int sign = SIGN(*str);
	str += IS_SIGN(*str);
	int i = find_base(base, *str++);
	while (i != -1) {
		res = res * len + i;
		i = find_base(base, *str++);
	}
	return (res * sign);
}

double	benchmark(int (*func)(char *, char *), char *str, char *base, int iterations)
{
	clock_t start_time = clock();
	for (int i = 0; i < iterations; i++)
		func(str, base);
	clock_t end_time = clock();
	return (double)(end_time - start_time) / CLOCKS_PER_SEC;
}

int main(int argc, char *argv[])
{
	if (argc < 2) return 0;
	printf("ft_atoi_base regular C: %lf\n", benchmark(ft_atoi_base_2, argv[1], argv[2], 10000000));
	printf("ft_atoi_base asm:      %lf\n", benchmark(ft_atoi_base, argv[1], argv[2], 10000000));
	return EXIT_SUCCESS;
}
