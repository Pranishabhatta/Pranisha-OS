# Lab 2: C Programming Basics

Operating Systems lab (ST5003CMD).

## Objectives

* Compile and run a C program with GCC.
* Understand the four stages of C compilation.
* Examine the preprocessed, assembly and object files.

## GCC Compilation Stages

| Stage         | Command                       | Output     |
| ------------- | ----------------------------- | ---------- |
| Preprocessing | `gcc -E mycode.c -o mycode.i` | `mycode.i` |
| Compilation   | `gcc -S mycode.i -o mycode.s` | `mycode.s` |
| Assembly      | `gcc -c mycode.s -o mycode.o` | `mycode.o` |
| Linking       | `gcc mycode.o -o mycode`      | `mycode`   |

## Files Included

* `mycode.c`: C source code
* `mycode.i`: preprocessed output
* `mycode.s`: assembly output

## Tools Used

Ubuntu Linux, GCC, Bash terminal
