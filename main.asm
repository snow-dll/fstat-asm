section .data
  fname: db "inputfile.txt"   ; file name

section .bss
  buffer: resb 500          ; reserve 500 byte buffer
  stat:   resb 144          ; reserve 144 bytes for struct stat

section .text
  global _start

_start:
  mov rax, 2                ; syscall open()
  mov rdi, fname            ; file name
  mov rsi, 0                ; mode (read)
  mov rdx, 0666             ; permissions
  syscall                   ; returns file descriptor in rax

  mov rdi, rax              ; move fd into rdi
  mov rax, 5                ; syscall fstat()
  lea rsi, stat
  syscall

  ; set gdb breakpoint here
  mov rax, [stat+48]         ; move st_size offset into rax

  mov rax, 60               ; syscall exit()
  mov rdi, 0                ; exit code 0
  syscall
