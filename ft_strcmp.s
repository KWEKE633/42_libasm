section .text
global ft_strcmp

; -------------------------------------------------------
; int ft_strcmp(const char *s1, const char *s2)
; -------------------------------------------------------
; 引数:
;   rdi = s1
;   rsi = s2
; 戻り値:
;   rax = (unsigned char)*s1 - (unsigned char)*s2
;   rax = 0  (どちらかがNULLの場合)
; -------------------------------------------------------

ft_strcmp:
    ; --- NULLチェック ---
    test    rdi, rdi             ; s1 == NULL ?
    jz      .null_return
    test    rsi, rsi             ; s2 == NULL ?
    jz      .null_return

    cld                          ; 方向フラグクリア（前進）

.loop:
    mov     al, [rdi]            ; al = *s1
    mov     dl, [rsi]            ; dl = *s2
    cmp     al, dl               ; *s1 == *s2 ?
    jne     .return_diff         ; 違えば差を返す
    test    al, al               ; 終端文字か？
    je      .return_diff         ; どちらも '\0' なら等しい（差0でOK）
    inc     rdi
    inc     rsi
    jmp     .loop

.return_diff:
    movzx   eax, al              ; zero-extend (unsigned char)
    movzx   edx, dl				 ; x86-64 のハードウェア設計では、movzx は 32bit までしか拡張できないのでraxではなくeax
    sub     eax, edx             ; eax = s1[i] - s2[i] つまり引き算記号
    ret

.null_return:
    xor     eax, eax             ; return 0
    ret
