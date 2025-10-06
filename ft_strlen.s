section .text
global ft_strlen

; -------------------------------------------------------
; size_t ft_strlen(const char *s)
; -------------------------------------------------------
; 引数:
;   rdi = s (文字列ポインタ)
;
; 戻り値:
;   rax = 文字数 (成功)
;   rax = 0       (s が NULL の場合)
; -------------------------------------------------------

ft_strlen:
    ; --- NULLチェック ---
    test	rdi, rdi          ; s == 0 ?
    jz      .null_return      ; yes -> return 0

    ; --- カウンタ初期化 ---
    xor     rax, rax          ; rax = 0 (i = 0)

.loop_start:
    cmp     byte [rdi + rax], 0  ; s[i] == '\0' ?
    je      .end                 ; yes -> return
    inc     rax                  ; i++
    jmp     .loop_start          ; continue

.end:
    ret

.null_return:
    xor     rax, rax             ; return 0
    ret
