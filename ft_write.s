section .text
global ft_write
extern __errno_location

; -------------------------------------------------------
; ssize_t ft_write(int fd, const void *buf, size_t count)
; -------------------------------------------------------
; 引数:
;   rdi = fd
;   rsi = buf
;   rdx = count
; 戻り値:
;   rax = bytes written (成功)
;   rax = -1          (失敗, errno 設定)
; -------------------------------------------------------

ft_write:
    ; --- NULLチェック ---
    test    rsi, rsi             ; buf == NULL ?
    jz      .fault_error         ; yes → errno = EFAULT

    ; --- システムコール write ---
    mov     rax, 1               ; syscall number for write
    syscall
    cmp     rax, 0
    jl      .error               ; rax < 0 → エラー
    ret                          ; 成功 → rax に書き込んだバイト数

; -------------------------------------------------------
; syscall エラー処理 (-errno → errno に設定)
; -------------------------------------------------------
.error:
    neg     rax                  ; rax = errno (正の値)
    mov     rdi, rax             ; 第一引数として __errno_location に渡す
    call    __errno_location     ; rax = &errno
    mov     [rax], rdi           ; *(&errno) = errno
    mov     rax, -1              ; 関数の戻り値
    ret

; -------------------------------------------------------
; buf == NULL の場合 (EFAULT = 14)
; -------------------------------------------------------
.fault_error:
    mov     edi, 14              ; EFAULT
    call    __errno_location
    mov     [rax], edi           ; errno = EFAULT
    mov     rax, -1
    ret
