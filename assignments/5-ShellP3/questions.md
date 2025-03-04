1. Your shell forks multiple child processes when executing piped commands. How does your implementation ensure that all child processes complete before the shell continues accepting user input? What would happen if you forgot to call waitpid() on all child processes?

My shell ensures that are child processes are complete before accepting new input by calling waitpid() on each child process after forking. If I forgot to call waitpid() on all child processes, the shell prompt could appear before the child process finishes, causing the output to be messed up. 

2. The dup2() function is used to redirect input and output file descriptors. Explain why it is necessary to close unused pipe ends after calling dup2(). What could go wrong if you leave pipes open?

It is necessary to close unused pipe ends after calling dup2 since the pipe would never signal the EOF, which could cause an indenite wait for data that would never arrive. Additionally, this would leave resources that will never free up.

3. Your shell recognizes built-in commands (cd, exit, dragon). Unlike external commands, built-in commands do not require execvp(). Why is cd implemented as a built-in rather than an external command? What challenges would arise if cd were implemented as an external process?

cd is implemented as a build-in command since we need to change the directory of the shell itself. If cd were implemented as an external process, meaning it would run in a child process, only the child process would change the directory. This means that when child finishes, the shell would remain in the original directory.

4. Currently, your shell supports a fixed number of piped commands (CMD_MAX). How would you modify your implementation to allow an arbitrary number of piped commands while still handling memory allocation efficiently? What trade-offs would you need to consider?

In order to allow an arbitrary number of piped commands, we can seperate the input into commands by the "|" symbol, count the number of commands while parsing, then allocate a list of command structures that is big enough to hold every command. This would be much more complex, can slow down performance, and could use much more memory depending on how many piped commands there are.
