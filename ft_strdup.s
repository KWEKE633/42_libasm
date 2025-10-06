section .text
global ft_strdup
extern __errno_location
extern ft_strlen
extern ft_strcpy
extern malloc

; -------------------------------------------------------
; char *ft_strdup(const char *s)
; -------------------------------------------------------
; 引数:
;   rdi = s (source string)
; 戻り値:
;   rax = strdup した文字列のポインタ (成功)
;   rax = NULL (失敗, errno 設定)
; -------------------------------------------------------

ft_strdup:
    ; --- NULL チェック ---
    test    rdi, rdi
    jz      .fault_error       ; 引数 NULL → errno = EINVAL

    ; --- 文字列の長さを取得 ---
    mov     rsi, rdi           ; ft_strlen の引数に rdi を渡す
    call    ft_strlen          ; rax = strlen(s)
    inc     rax                ; +1 for terminating '\0'

    push    rdi                ; 後でコピー元として使用するため保存

    ; --- メモリ確保 ---
    mov     rdi, rax           ; malloc の引数 = size
    call    malloc
    test    rax, rax
    je      .error             ; malloc 失敗 → NULL + errno 設定

    ; --- 文字列コピー ---
    pop     rsi                ; コピー元文字列を取り出す
    mov     rdi, rax           ; コピー先 = malloc で確保したメモリ
    call    ft_strcpy          ; RAX にコピー先ポインタが返る
    ret

; -------------------------------------------------------
; malloc 失敗時
; -------------------------------------------------------
.error:
    mov     edi, 12           ; errno = ENOMEM
    call    __errno_location  ; rax = &errno
    mov     [rax], edi        ; errno に 12
    xor     rax, rax          ; 関数の戻り値 = NULL
    ret

; -------------------------------------------------------
; 引数 NULL の場合  せっかくなので、errnoの設定までした。
; -------------------------------------------------------
.fault_error:
    mov     edi, 22            ; EINVAL = 22　不正な引数
    call    __errno_location
    mov     [rax], edi
	xor     rax, rax           ; return NULL
    ret
