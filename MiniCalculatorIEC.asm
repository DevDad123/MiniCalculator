.model small
.stack 100h

.data
 str1 db 'Enter first number: $'
 str2 db 'Enter second number: $'
 str3 db 'Enter the operator (+, -, *, /): $'
 resultmes db 'The result is: $'
 num1 db 0
 num2 db 0
 operator db 0
 res db 0

.code
main:
 mov ax, @data
 mov ds, ax

 ; dong nay la goi cai bien str1 de in ra chu enter first number
 mov ah, 09h
 lea dx, str1
 int 21h
 call newline

 ; dong nay la de nhap vao mot bien vao thanh ghi al r tru di '0' de chuyen tu ascii thanh so va luu so dau tien vao num1
 mov ah, 01h
 int 21h
 sub al, '0'
 mov num1, al
 call newline

 ; dong nay la goi cai bien str2 de in ra chu enter second number
 mov ah, 09h
 lea dx, str2
 int 21h
 call newline
 
 ; tuong tu dong 25 de nhan gtri tu ban phim va bien tu ascii sang so tu nhien
 mov ah, 01h
 int 21h
 sub al, '0'
 mov num2, al
 call newline

 ; in ra cai dong enter operation de nguoi dung nhap vao toan tu muon dung
 mov ah, 09h
 lea dx, str3
 int 21h
 call newline
 
 ; dong nay de nguoi dung nhap toan tu cua nguoi dung muon thuc hien
 mov ah, 01h
 int 21h
 mov operator, al
 call newline
 
 ; luu gtri cua num1 , num2 vao thanh ghi al va bl
 mov al, num1
 mov bl, num2  ; ly do phai nhap num1, num2 vao bo nho la vi CPU chi cho phep mot toan hang là bo nho, toan hang con lai phai là thanh ghi hoac hang so.

 ; xem nguoi dung chon operator nao de jump den ham do
 cmp operator, '+'
 je add
 cmp operator, '-'
 je substract
 cmp operator, '*'
 je multiply
 cmp operator, '/'
 je divide

 jmp done

add:
 add al, bl
 mov res, al
 jmp coutres

substract:
 sub al, bl
 mov res, al
 jmp coutres

multiply:
 mul bl         
 mov res, al
 jmp coutres

divide:
 cmp bl, 0
 je done         
 div bl         
 mov res, al
 jmp coutres

coutres:
 mov ah, 09h
 lea dx, resultmes
 int 21h

 mov al, res
 add al, '0'     
 mov dl, al
 mov ah, 02h
 int 21h

done:
 mov ah, 4Ch
 int 21h

newline proc  ; ham nay dung de xuong dong sau moi lan nhap
 mov dl, 13 ; 13 trong ma ascii la /r dung de dua con tro ve dau dong
 mov ah, 02h  ; in cai minh muon in ra
 int 21h
 mov dl, 10 ; 10 trong ma ascii la /n tuong duong voi xuong dong
 mov ah, 02h ; se in ra xuong dong de xuong dong
 int 21h
 ret
newline endp

end main
