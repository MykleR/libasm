#include <stdlib.h>
#include <stdio.h>
#include "headers/libasm.h"

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

int	ft_atoi_base(char *str, char *base)
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

int main(int argc, char *argv[])
{
	if (argc < 2) return 0;
	printf("%d\n",ft_atoi_base(argv[1], argv[2]));
	printf("base=\"01\" -> %d\n",ft_atoi_base(argv[1], "01"));
	printf("base=\"01+\" -> %d\n",ft_atoi_base(argv[1], "01+"));
	printf("base=\"01-\" -> %d\n",ft_atoi_base(argv[1], "01-"));
	printf("base=\"01 \" -> %d\n",ft_atoi_base(argv[1], "01 "));
	printf("base=\"01\\t\" -> %d\n",ft_atoi_base(argv[1], "01\t"));
	printf("base=\"01\\r\" -> %d\n",ft_atoi_base(argv[1], "01\r"));
	printf("base=\"01\\n\" -> %d\n",ft_atoi_base(argv[1], "01\n"));
	printf("base=\"01\\v\" -> %d\n",ft_atoi_base(argv[1], "01\v"));
	printf("base=\"01\\f\" -> %d\n",ft_atoi_base(argv[1], "01\f"));
	return EXIT_SUCCESS;
}
