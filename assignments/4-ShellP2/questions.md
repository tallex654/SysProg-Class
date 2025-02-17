1. Can you think of why we use `fork/execvp` instead of just calling `execvp` directly? What value do you think the `fork` provides?

    > **Answer**:  If we were to call 'execvp' directly, it would replace the parent process itself, which is why we need to use fork. The fork would provide a new process that is an exact copy of the parent process.

2. What happens if the fork() system call fails? How does your implementation handle this scenario?

    > **Answer**:  If fork() fails, it would return -1. My implementation handles this by checking to see if the vakue is less than 0. If it is less than 0, there would be a command error.

3. How does execvp() find the command to execute? What system environment variable plays a role in this process?

    > **Answer**:  execvp() finds the command by searching for the command in the PATH environment. The PATH variable is important here since it allows commands to run without the need for their full absolute path. 

4. What is the purpose of calling wait() in the parent process after forking? What would happen if we didn’t call it?

    > **Answer**:  Calling wait() makes the parent process wait for the child to finish execution before continuing on. 

5. In the referenced demo code we used WEXITSTATUS(). What information does this provide, and why is it important?

    > **Answer**:  It provides the exit status of the child process. This is important as we can determine if the child executed successfully or not.

6. Describe how your implementation of build_cmd_buff() handles quoted arguments. Why is this necessary?

    > **Answer**:  My implementation of the function works by allowing delimiters such as spaces so that a command like 'echo "Hello World"' would work properly.

7. What changes did you make to your parsing logic compared to the previous assignment? Were there any unexpected challenges in refactoring your old code?

    > **Answer**:  The biggest change was inplementing quotes to work properly. I didn't expect it to take as long as it did for me, which why is was an unexpected challenge.

8. For this quesiton, you need to do some research on Linux signals. You can use [this google search](https://www.google.com/search?q=Linux+signals+overview+site%3Aman7.org+OR+site%3Alinux.die.net+OR+site%3Atldp.org&oq=Linux+signals+overview+site%3Aman7.org+OR+site%3Alinux.die.net+OR+site%3Atldp.org&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBBzc2MGowajeoAgCwAgA&sourceid=chrome&ie=UTF-8) to get started.

- What is the purpose of signals in a Linux system, and how do they differ from other forms of interprocess communication (IPC)?

    > **Answer**:  Signals are automatic notifications sent to process that contain info about terminations, user interruptions, and problems with memory access. They differ from IPC since the process does not need to continously check for new messages.

- Find and describe three commonly used signals (e.g., SIGKILL, SIGTERM, SIGINT). What are their typical use cases?

    > **Answer**:  SIGKILL immediately terminated a process without cleanup, and is typically used when a process is unresponsive. SIGTERM asks to terminate a process, and is used as the default signal for the kill command. SIGINT interrupts processes, and is typically caused by using ctrl+c in the terminal.

- What happens when a process receives SIGSTOP? Can it be caught or ignored like SIGINT? Why or why not?

    > **Answer**:  When a process receives SIGSTOP, it is suspended and cannot continue execution until SIGCONT is received. SIGSTOP cannot be caught or ignored in order to ensure processes can always be stopped by the system.
