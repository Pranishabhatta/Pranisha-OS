# LAB 4.2: Mapping Process Runtime Topography Using Low-Level Hardware Debugging Infrastructure

Operating Systems, Security and Networks (ST5003CMD)

## Introduction

This lab examines where the different kinds of variables live in a running process. A small C program is compiled with debugging symbols and inspected with the GNU Debugger (GDB). The BSS, Heap and Stack regions are located, their address ranges are read from the operating system memory map, and raw values are examined in stack and heap memory.

## Objectives

* Identify the BSS, Heap and Stack regions of a running process.
* Read the live memory map of a process with `info proc mappings`.
* Examine raw memory with the GDB `x` command, including the stack pointer `$sp` and a heap pointer.
* Show that the stack and the heap grow toward one another.
* Explain why two runs of the same program can show different addresses (virtual memory and ASLR).

## Environment

* Ubuntu Linux (aarch64) in VirtualBox on a MacBook Air (Apple M2)
* GCC and GNU GDB
* Source file: `demo.c`

## Program

`demo.c` contains:

| Item | Code | Region |
| ---- | ---- | ------ |
| Global variable without a value | `int bss_global_var;` | BSS |
| Local variable | `int stack_local_var = 42;` | Stack |
| Dynamically allocated integer | `malloc(sizeof(int))`, set to `99` | Heap |

## Commands Used

Compile with debugging symbols and run:

    gcc -g demo.c -o demo
    ./demo

Show the program headers:

    readelf -l demo

Inspect the process in GDB:

    gdb ./demo
    (gdb) break 23
    (gdb) run
    (gdb) info files
    (gdb) print &bss_global_var
    (gdb) info proc mappings
    (gdb) print stack_local_var
    (gdb) print &stack_local_var
    (gdb) x/4wx $sp
    (gdb) print heap_ptr
    (gdb) x/1wd heap_ptr
    (gdb) continue
    (gdb) quit

| Command | Purpose |
| ------- | ------- |
| `gcc -g` | Compile and keep debugging symbols |
| `break 23` | Set a breakpoint at line 23 (GDB moves it to line 24, the next line with code) |
| `info files` | List the executable sections and their address ranges |
| `readelf -l` | Show program headers and the section-to-segment mapping |
| `info proc mappings` | Show the live virtual memory map, including `[heap]` and `[stack]` |
| `x/4wx $sp` | Show four words in hexadecimal from the stack pointer |
| `x/1wd` | Show 1 word (4 bytes) as a signed decimal |

## Key Findings

* The global variable lies inside the `.bss` section, the local variable inside `[stack]` and the heap value inside `[heap]`.
* `x/1wd heap_ptr` shows `99`, the value stored in heap memory.
* The heap grows upward and the stack grows downward, so the gap between them shrinks as the process expands.
* Two normal runs show different addresses because each process has its own virtual address space and Linux uses ASLR. GDB turns ASLR off, so addresses inside GDB repeat.

All addresses, screenshots and answers to the lab questions are in the report.

## Files Included

* `demo.c`: C source code
* Lab 4.2 report (PDF)
* `README.md`: this file

## Conclusion

The lab showed how the BSS, heap and stack are arranged in a process and how GDB and the operating system memory map can be used to prove where each variable is stored.
