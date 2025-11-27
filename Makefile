NAME 			:= libasm.a

DIR_SOURCES		:= sources
DIR_OBJECTS		:= .objs

SOURCES			:= $(DIR_SOURCES)/ft_read.s \
					$(DIR_SOURCES)/ft_strcmp.s \
					$(DIR_SOURCES)/ft_strcpy.s \
					$(DIR_SOURCES)/ft_strdup.s \
					$(DIR_SOURCES)/ft_strlen.s \
					$(DIR_SOURCES)/ft_write.s
SOURCES_B		:=	$(DIR_SOURCES)/ft_atoi_base_bonus.s

OBJECTS			:= $(SOURCES:%.s=$(DIR_OBJECTS)/%.o)
OBJECTS_B		:= $(SOURCES_B:%.s=$(DIR_OBJECTS)/%.o)
DEPENDENCIES	:= $(OBJECTS:.o=.d)

AR				:= ar
CXX				:= nasm
CXXFLAGS		:= -f elf64

DIR_DUP			= mkdir -p $(@D)


all: $(NAME)

bonus:
	@$(MAKE) --no-print-directory BONUS=1

-include $(DEPENDENCIES)

$(NAME): $(OBJECTS) $(if $(BONUS), $(OBJECTS_B))
	@$(AR) rcs $@ $^
	@printf " $(MSG_COMPILED)"

$(DIR_OBJECTS)/%.o: %.s
	@$(DIR_DUP)
	@$(CXX) $(CXXFLAGS) $< -o $@
	@printf " $(MSG_COMPILING)"

clean:
	@rm -rf $(DIR_OBJECTS)
	@printf " $(MSG_DELETED)$(DIR_OBJECTS)$(RESET)\n"

fclean: clean
	@rm -rf $(NAME)
	@printf " $(MSG_DELETED)$(NAME)$(RESET)\n"

re: fclean $(NAME)

.PHONY: clean fclean re all


GREEN		=	\033[32m
BLUE		=	\033[34m
CYAN		=	\033[36m
GRAY		=	\033[90m
BOLD		=	\033[1m
ITALIC		=	\033[3m
RESET		=	\033[0m
MSG_COMPILING	= $(BLUE)$(BOLD)$(ITALIC)■$(RESET) compiling	$(GRAY)$(BOLD)$(ITALIC)$<$(RESET) \n
MSG_COMPILED	= $(CYAN)$(BOLD)$(ITALIC)■$(RESET) compiled	$(BOLD)$@$(RESET) $(CYAN)successfully ✅$(RESET)\n
MSG_DELETED		= $(GRAY)$(BOLD)$(ITALIC)■$(RESET) deleted 	$(GRAY)$(BOLD)$(ITALIC)
