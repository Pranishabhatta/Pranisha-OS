# LAB 4.1: Auditing of Text and Initialized Data Segments via Hardware Disassembly

Operating Systems, Security and Networks (ST5003CMD)

## Introduction

This lab examines how a compiled C program is arranged in memory. A small program is compiled with debugging symbols and inspected with the GNU Debugger (GDB). The runtime addresses of a function, a string literal and an initialized global variable are matched against the section ranges of the executable. The raw bytes of a stored value are also examined to find the byte order of the system.

## Objectives

* Identify the `.text`, `.rodata` and `.data` sections of an executable and the boundaries between them.
* Disassemble a compiled function into machine instructions.
* Use GDB to match runtime addresses to section ranges.
* Examine raw bytes in memory and determine whether the system is Little-Endian or Big-Endian.

## Environment

* Ubuntu Linux (aarch64) in VirtualBox on a MacBook Air (Apple M2)
* GCC and GNU GDB
* Source file: `demo2.c`

## Program

`demo2.c` contains:

| Item | Code | Expected section |
| ---- | ---- | ---------------- |
| Initialized global variable | `int data_global_var = 0x12345678;` | `.data` |
| String literal | `" Text_Segment_Verification"` | `.rodata` |
| Function | `check_execution()` | `.text` |

## Commands Used

Compile with debugging symbols and run:

    gcc -g demo2.c -o demo2
    ./demo2

Start GDB, stop at the breakpoint and inspect memory:

    gdb ./demo2
    (gdb) break 22
    (gdb) run
    (gdb) info files
    (gdb) disassemble check_execution
    (gdb) print &data_global_var
    (gdb) x/wx &data_global_var
    (gdb) x/4xb &data_global_var
    (gdb) print text_string_literal
    (gdb) x/s text_string_literal
    (gdb) print &text_string_literal
    (gdb) continue
    (gdb) quit

| Command | Purpose |
| ------- | ------- |
| `gcc -g` | Compile and keep debugging symbols |
| `break 22` | Set a breakpoint at line 22 (GDB moves it to line 23, the next line with code) |
| `info files` | List the executable sections and their address ranges |
| `disassemble` | Show the machine instructions of a function |
| `x/wx` | Examine one word of memory in hexadecimal |
| `x/4xb` | Examine four single bytes in hexadecimal |
| `x/s` | Examine memory as a string |

## Key Findings

* The function address lies inside `.text`, the string literal inside `.rodata` and the global variable inside `.data`.
* Line 22 is a comment, so GDB placed the breakpoint on line 23.
* The pointer `text_string_literal` is stored in `.data`, while the string it points to is stored in `.rodata`.
* The system is Little-Endian: the value `0x12345678` is stored as the bytes `78 56 34 12`.

All addresses, screenshots and answers to the lab questions are in the report.

## Files Included

* `demo2.c`: C source code
* Lab 4.1 report (PDF)
* `README.md`: this file

## Conclusion

The lab showed that code, constants and initialized data are kept in separate sections, and that GDB can be used to prove where each item lives and how its bytes are stored.
