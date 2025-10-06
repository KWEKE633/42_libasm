section .text
global ft_strcpy

; ---------------------------------------------
; char *ft_strcpy(char *dst, const char *src)
; ---------------------------------------------
; 引数:
;   rdi = dst
;   rsi = src
; 戻り値:
;   rax = dst (成功)
;   rax = 0   (NULL入力)
; ---------------------------------------------

ft_strcpy:
    ; --- NULLチェック ---
    test rdi, rdi          ; dst == 0 ?
    jz .null               ; yes → NULL return
    test rsi, rsi          ; src == 0 ?
    jz .null               ; yes → NULL return

    mov rax, rdi           ; return value = dst

.copy_loop:
    mov dl, [rsi]          ; dl = *src
    mov [rdi], dl          ; *dst = dl
    inc rsi
    inc rdi
    test dl, dl            ; 文字が '\0' か？
    jnz .copy_loop         ; まだ続くならループ

    ret

.null:
    xor rax, rax           ; return 0
    ret					   ; rax == rax --> xor rax, rax == 0
