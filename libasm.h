#ifndef LIBASM_H
#define LIBASM_H

#include <unistd.h>

extern size_t ft_strlen(const char *str);
extern ssize_t ft_write(int fd, const char *str, size_t count);
extern ssize_t ft_read(int fd, char *str, size_t count);
extern char *ft_strcpy(char *dst, const char *src);
extern char *ft_strdup(char *src);
extern int ft_strcmp(const char *s1, const char *s2);

#endif
