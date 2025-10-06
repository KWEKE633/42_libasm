#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include "libasm.h"
#include <stdlib.h>

//　main関数読みやすくしないと...

int main() {
    printf("=== ft_strdup tests ===\n");

    // NULL 引数
    char *p = ft_strdup(NULL);
    if (!p) {
        printf("ft_strdup(NULL) failed as expected\n");
        printf("errno = %d (%s)\n", errno, strerror(errno));
    }

    // 空文字列
    p = ft_strdup("");
    if (p) {
        printf("ft_strdup(\"\") succeeded -> \"%s\"\n", p);
        free(p);
    }

    // 長い文字列
    char long_str[1024];
    for (int i = 0; i < 1023; i++) long_str[i] = 'A' + (i % 26);
    long_str[1023] = '\0';
    p = ft_strdup(long_str);
    if (p) {
        printf("ft_strdup(long_str) succeeded, first 50 chars: %.50s...\n", p);
        free(p);
    }

    printf("\n=== ft_read tests ===\n");

    char buf[16];

    // NULL バッファ
    ssize_t n = ft_read(0, NULL, 10);
    if (n == -1) {
        printf("ft_read(fd=0, buf=NULL) failed as expected\n");
        printf("errno = %d (%s)\n", errno, strerror(errno));
    }

    // count = 0
    n = ft_read(0, buf, 0);
    printf("ft_read(fd=0, count=0) returned %zd\n", n);

    // 標準入力から読み込み
    printf("Type something (up to 15 chars): ");
    n = ft_read(0, buf, 15);
    if (n >= 0) {
        buf[n] = '\0';
        printf("ft_read read %zd bytes: \"%s\"\n", n, buf);
    } else {
        printf("ft_read failed\n");
        printf("errno = %d (%s)\n", errno, strerror(errno));
    }

    printf("\n=== ft_write tests ===\n");

    // NULL バッファ
    n = ft_write(1, NULL, 10);
    if (n == -1) {
        printf("ft_write(fd=1, buf=NULL) failed as expected\n");
        printf("errno = %d (%s)\n", errno, strerror(errno));
    }

    // count = 0
    n = ft_write(1, "", 0);
    printf("ft_write(fd=1, count=0) returned %zd\n", n);

    // 長い文字列
    const char *long_msg = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\n";
    n = ft_write(1, long_msg, strlen(long_msg));
    if (n == -1) {
        printf("ft_write failed\n");
        printf("errno = %d (%s)\n", errno, strerror(errno));
    } else {
        printf("ft_write wrote %zd bytes\n", n);
    }

    printf("\n=== ft_strlen tests ===\n");

    // 空文字列
    size_t len = ft_strlen("");
    printf("ft_strlen(\"\") = %zu (expected 0)\n", len);

    // 通常文字列
    const char *str1 = "Hello, world!";
    len = ft_strlen(str1);
    printf("ft_strlen(\"%s\") = %zu (expected %zu)\n", str1, len, strlen(str1));

    // 長い文字列
    len = ft_strlen(long_str);
    printf("ft_strlen(long_str) = %zu (expected 1023)\n", len);

    printf("\n=== ft_strcmp tests ===\n");

    // 空文字列同士
    int cmp = ft_strcmp("", "");
    printf("ft_strcmp(\"\", \"\") = %d (expected 0)\n", cmp);

    // 一文字違い
    cmp = ft_strcmp("abc", "abd");
    printf("ft_strcmp(\"abc\", \"abd\") = %d (expected <0)\n", cmp);

    cmp = ft_strcmp("abd", "abc");
    printf("ft_strcmp(\"abd\", \"abc\") = %d (expected >0)\n", cmp);

    // 長い文字列同士
    char long_str2[1024];
    for (int i = 0; i < 1023; i++) long_str2[i] = 'A' + (i % 26);
    long_str2[1023] = '\0';
    cmp = ft_strcmp(long_str, long_str2);
    printf("ft_strcmp(long_str, long_str2) = %d (expected 0)\n", cmp);

    printf("\n=== ft_strcpy tests ===\n");

    char dest[2048];

    // 空文字列コピー
    ft_strcpy(dest, "");
    printf("ft_strcpy(dest, \"\") -> \"%s\" (expected empty string)\n", dest);

    // 通常文字列コピー
    ft_strcpy(dest, str1);
    printf("ft_strcpy(dest, \"%s\") -> \"%s\"\n", str1, dest);

    // 長い文字列コピー
    ft_strcpy(dest, long_str);
    printf("ft_strcpy(dest, long_str) -> first 50 chars: %.50s...\n", dest);

    return 0;
}


// 1. x86-64 レジスタのサイズ

// x86-64 では、同じレジスタ名でもサイズによってアクセス方法が違います。

// 64bit レジスタ	32bit 下位	16bit 下位	8bit 下位/上位
// rax	eax	ax	al (下位 8bit) / ah (上位 8bit)
// rbx	ebx	bx	bl / bh
// rcx	ecx	cx	cl / ch
// rdx	edx	dx	dl / dh
// rdi	edi	di	(下位 8bit は一般的に使わない)
// rsi	esi	si	(下位 8bit は一般的に使わない)
