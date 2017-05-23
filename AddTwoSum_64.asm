; Phillip Benoit
; CIS250
; Assignment 1 - Ex6 from pg94
; AddTwoSum_64.asm - 64-bit version of the add program
; part of: Benoit - CIS250 - Assignment 1.zip

ExitProcess proto
.data
sum qword 0
.code
main proc
   mov  rax,5
   add  rax,6
   mov  sum,rax

   mov  ecx,0
   call ExitProcess
main endp
end