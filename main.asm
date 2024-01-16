section .data
  fname: db "inputfile.txt"   ; file name

section .bss
  stat:   resb 144          ; reserve 144 bytes for struct stat

section .text
  global _start

_start:
  mov rax, 2                ; open
  mov rdi, [rsp+8]          ; filename in argv[1]
  mov rsi, 0                ; mode
  mov rdx, 0666             ; permissions
  syscall

  mov rdi, rax
  mov rax, 5                ; fstat
  lea rsi, stat
  syscall

  mov rax, 60               ; exit
  mov rdi, 0
  syscall
