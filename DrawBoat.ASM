        org 100h

EntryPoint:
        mov     ax, $0013
        int     10h

        push    $A000
        pop     es

        mov     ax,$0C03
        xor     di,di
        mov     cx,320*200
        rep     stosb

WaterLines:
        mov     di,320*170+20
        mov     cx,20
        mov     bx,40
.loop1:
        push    di
        push    cx
        call    waterline

        pop     cx
        pop     di
        add     di,270
        dec     bx
        jnz     .loop1

leftslash:      ;\
        mov     dx,180
        mov     cx,80
        mov     bx,160
        call    leftLN

rightslash:     ;/
        mov     dx,180
        mov     cx,240
        mov     bx,160
        call    rightLN

boardsL:        ;boardline
        mov     di,320*160+60
        mov     cx,201
.loop1:
        push    di
        push    cx
        call    colorline

        pop     cx
        pop     di
        sub     cx,2
        add     di,321
        cmp     cx,145 ;163
        jae     .loop1

straightline:   ;|
        call    straiL

;rightslash1:    ;/
        ;mov     dx,90
        ;mov     cx,110
        ;mov     bx,40
        ;call    rightLN

;leftslash2:     ;\
        ;mov     dx,140
        ;mov     cx,160
        ;mov     bx,90
        ;call    leftLN

sail:
        ;upperpart
        mov     ax,$0C0C
        mov     di,320*41+159
        mov     cx,2
        call    uppart

        ;lowerpart
        mov     ax,$0C0C
        mov     di,320*91+111
        mov     cx,50
        call    lopart

Exit:
        mov     ax,$0C08
        int     21h
        test    al,al
        jnz     @F
        mov     ah,$08
        int     21h
@@:
        ret

;///////////////////////
waterline:
        mov     ax,$0C01
        rep     stosb
ret

colorline:
        mov     ax,$0C0E
        rep     stosb
ret

leftLN:
.loop1:
        mov     ax,$0C0E
        int     10h

        dec     dx
        dec     cx
        cmp     dx,bx
        jne     .loop1
ret

rightLN:
.loop1:
        mov     ax,$0C0E
        int     10h

        dec     dx
        inc     cx
        cmp     dx,bx
        jne     .loop1
ret

straiL:
        mov     cx,160
        mov     dx,160
.loop1:
        mov     ax,$0C0E
        int     10h

        dec     dx
        cmp     dx,139
        jne     .loop1
ret

uppart:
.loop1:
        push    cx
        push    di
        rep     stosb

        pop     di
        pop     cx
        add     di,319
        inc     cx
        cmp     cx,51
        jbe     .loop1
ret

lopart:
.loop2:
        push    cx
        push    di
        rep     stosb

        pop     di
        pop     cx
        add     di,321
        dec     cx
        cmp     cx,2
        jae     .loop2
ret