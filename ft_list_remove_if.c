#include "headers/libasm_bonus.h"
#include <stdlib.h>
#include <stdio.h>


void ft_list_push_front(t_list **begin_list, void *data)
{
	if (!begin_list) return;
	t_list *node = malloc(sizeof(t_list));
	node->data = data;
	node->next = *begin_list;
	*begin_list = node;
}

void ft_list_remove_if(t_list **head, void *data_ref,
		int (*cmp)(), void (*free_fct)(void *))
{
	if (!head || !cmp) return;
	while (*head) {
		if (!cmp((*head)->data, data_ref)) {
			t_list	*tmp = *head;
			*head = (*head)->next;
			if (free_fct) free_fct(tmp->data);
			free(tmp);
		}
		else head = &(*head)->next;
	}
}


int is_mod(void *x, void *r) {
	return (*(int *)x) % (*(int *)r);
}

int main(int argc, char *argv[])
{
	t_list	*list = NULL;
	ft_list_push_front(&list, &(int){5});
	ft_list_push_front(&list, &(int){4});
	ft_list_push_front(&list, &(int){2});
	ft_list_push_front(&list, &(int){3});
	ft_list_push_front(&list, &(int){8});
	
	for (t_list *n=list; n; n=n->next)
		printf("%d -> ", *(int *)n->data);
	printf("\n");

	ft_list_remove_if(&list, &(int){2}, is_mod, NULL);

	for (t_list *n=list; n; n=n->next)
		printf("%d -> ", *(int *)n->data);
	printf("\n");


	for (t_list	*n=list, *tmp=list; n; free(n), n=tmp)
		tmp = n->next;
	return EXIT_SUCCESS;
}
