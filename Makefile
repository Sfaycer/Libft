CC = gcc
CFLAGS = -Wall -Wextra -Werror
NAME = libft.a
SRCS = ft_tolower.c ft_toupper.c ft_isprint.c ft_isascii.c ft_isalpha.c ft_isdigit.c ft_isalnum.c ft_strlen.c ft_putchar_fd.c ft_putstr_fd.c ft_putendl_fd.c ft_putnbr_fd.c ft_atoi.c ft_strncmp.c ft_strnstr.c ft_strchr.c ft_strrchr.c ft_memset.c ft_bzero.c ft_memcpy.c ft_memccpy.c ft_memmove.c ft_memchr.c ft_memcmp.c ft_strlcpy.c ft_strlcat.c ft_calloc.c ft_strdup.c ft_substr.c ft_strjoin.c ft_strtrim.c ft_split.c ft_itoa.c ft_strmapi.c
BONUS_SRCS = ft_lstnew.c ft_lstadd_front.c ft_lstsize.c ft_lstlast.c ft_lstadd_back.c ft_lstdelone.c ft_lstclear.c ft_lstiter.c ft_lstmap.c
OBJ_DIR = obj
OBJS = $(addprefix $(OBJ_DIR)/, $(SRCS:.c=.o))
BONUS_OBJS = $(addprefix $(OBJ_DIR)/, $(BONUS_SRCS:.c=.o))

DEP_DIR := $(OBJ_DIR)/.deps
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEP_DIR)/$*.Td
COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS)
POSTCOMPILE = mv -f $(DEP_DIR)/$*.Td $(DEP_DIR)/$*.d && touch $@

ifdef WITH_BONUS
OBJS += $(BONUS_OBJS)
SRCS += $(BONUS_SRCS)
endif


DEF = \033[0m
RED = \033[1;31m
GREEN = \033[1;32m
LYELLOW = \033[0;33m
YELLOW = \033[1;33m
BLUE = \033[1;34m
MAGENTA = \033[1;35m
CYAN = \033[1;36m
WHITE = \033[1;37m

all:
		@$(MAKE) $(NAME)

$(NAME): $(OBJS)
		@echo "$(YELLOW)Object files were born!$(DEF)"
		@ar -rc $@ $?
		@ranlib $@
		@echo "$(GREEN)Library '$@' has been created.$(DEF)"

bonus:
		@echo "$(WHITE)Bonus rule initiated.$(DEF)"
		@$(MAKE) WITH_BONUS=1 $(NAME)

$(OBJ_DIR):
		@mkdir -p $@
		@echo "$(CYAN)Folder '$@' was created.$(DEF)"

$(OBJ_DIR)/%.o: %.c $(DEP_DIR)/%.d | $(DEP_DIR)
		@$(COMPILE.c) -c $< -o $@
		@$(POSTCOMPILE)
		@echo "$(LYELLOW).$(DEF)\c"

$(DEP_DIR):
		@mkdir -p $@
		@echo "$(CYAN)Folder "obj" was created.$(DEF)"

DEPFILES = $(SRCS:%.c=$(DEP_DIR)/%.d)
$(DEPFILES):

cleandep:
		@rm -rf $(DEP_DIR)

clean:
		@rm -rf $(OBJ_DIR)
		@echo "$(RED)Folder '$(OBJ_DIR)' and all files inside were deleted.$(DEF)"

fclean: clean
		@rm -f $(NAME)
		@echo "$(MAGENTA)Library '$(NAME)' was deleted.$(DEF)"

re: fclean all

include $(wildcard $(DEPFILES))

.PHONY: all clean fclean re bonus cleandep
