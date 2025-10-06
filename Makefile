ASM = nasm
ASMFLAGS = -f elf64
NAME = libasm.a

SRC = \
	ft_strlen.s \
	ft_strcpy.s \
	ft_strcmp.s \
	ft_write.s \
	ft_read.s \
	ft_strdup.s

OBJ = $(SRC:.s=.o)

TEST_SRC = main.c
TEST_BIN = a.out
CC = cc
CFLAGS = -Wall -Wextra -Werror

all: $(NAME)

$(NAME): $(OBJ)
	ar rcs $(NAME) $(OBJ)

%.o: %.s
	$(ASM) $(ASMFLAGS) $< -o $@

exec: $(TEST_SRC) $(NAME)
	$(CC) $(CFLAGS) $(TEST_SRC) $(NAME) -o $(TEST_BIN)

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME) $(TEST_BIN)

re: fclean all

.PHONY: all exec clean fclean re
