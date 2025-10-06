section .text
global ft_read

extern __errno_location

; -------------------------------------------------------
; ssize_t ft_read(int fd, void *buf, size_t count)
; -------------------------------------------------------
; 引数:
;   rdi = fd
;   rsi = buf
;   rdx = count
;
; 戻り値:
;   rax = bytes read  (成功時)
;   rax = -1          (失敗時, errno 設定)
; -------------------------------------------------------

ft_read:
    test    rsi, rsi             ; buf == NULL ?
    jz      .fault_error         ; yes → errno = EFAULT

    ; --- システムコール read ---
    mov     rax, 0               ; syscall number (read = 0)
    syscall
    cmp     rax, 0
    jl      .error               ; if (rax < 0) → error
    ret

; -------------------------------------------------------
; 汎用エラーハンドラ (rax = -errno)
; -------------------------------------------------------
.error:
    neg     rax                  ; rax = errno (positive)
    mov     edi, eax             ; edi = errno (int)
    call    __errno_location     ; → rax = &errno
    mov     [rax], edi           ; *errno = edi
    mov     rax, -1              ; return -1  *1
    ret

; -------------------------------------------------------
; buf == NULL の場合 (EFAULT)
; -------------------------------------------------------
.fault_error:
    mov     edi, 14              ; EFAULT = 14
    call    __errno_location
    mov     [rax], edi
    mov     rax, -1              ; *1
    ret


; *1: x86-64 では メモリに書き込んだ値とレジスタの値は独立
