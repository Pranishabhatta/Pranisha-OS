# Lab 3: Investigating Process Lifecycles and OS Interaction

Operating Systems lab (ST5003CMD).

## Tasks

| Task | Description                                       | Source File        |
| ---- | ------------------------------------------------- | ------------------ |
| 1    | Long-running process, background execution        | `task1_alive.c`    |
| 2    | Process identity with `getpid()` and `getppid()`  | `task2_identity.c` |
| 3    | Exit codes, checked with `echo $?`                | `task3_exit.c`     |
| 4    | Standard input and output                         | `task4_input.c`    |
| 5    | Conditional execution and process termination     | `task5_control.c`  |

## Example

```bash
gcc task1_alive.c -o task1
./task1 &
ps aux | grep task1
```

## Tools Used

Ubuntu Linux, GCC, Bash terminal
