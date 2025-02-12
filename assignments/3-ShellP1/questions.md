1. In this assignment I suggested you use `fgets()` to get user input in the main while loop. Why is `fgets()` a good choice for this application?

    > **Answer**:  fgets() is able to property detect the end of the file, it is able to read the entire input line, and it won't read more than the max amount of characters selected.

2. You needed to use `malloc()` to allocte memory for `cmd_buff` in `dsh_cli.c`. Can you explain why you needed to do that, instead of allocating a fixed-size array?

    > **Answer**: Using malloc() instead of allocating a fixed-size array allows for prevention of potential overflows with longer command. It also ensures we only use as much memory as we need.


3. In `dshlib.c`, the function `build_cmd_list(`)` must trim leading and trailing spaces from each command before storing it. Why is this necessary? If we didn't trim spaces, what kind of issues might arise when executing commands in our shell?

    > **Answer**:  Without trimming, incorrect command recognition and argument parsing errors could appear.

4. For this question you need to do some research on STDIN, STDOUT, and STDERR in Linux. We've learned this week that shells are "robust brokers of input and output". Google _"linux shell stdin stdout stderr explained"_ to get started.

- One topic you should have found information on is "redirection". Please provide at least 3 redirection examples that we should implement in our custom shell, and explain what challenges we might have implementing them.

    > **Answer**: First redirection that we should implement is the output redirection. The challenge would be properly handling overwriting vs appending to a file. The second redirection we should implement is the input redirection. A challenge here would be ensure the specified file exists before reading. Another case is where we don't have the permission to view. Finally, we should also implement error redirection. The biggest challenge here would be correctly redirecting STDERR without affectiong STDOUT.

- You should have also learned about "pipes". Redirection and piping both involve controlling input and output in the shell, but they serve different purposes. Explain the key differences between redirection and piping.

    > **Answer**:  Redirection sends command inputs/outputs to/from files, while piping connects multiple commands, which processes the commands in direct command chaining. 

- STDERR is often used for error messages, while STDOUT is for regular output. Why is it important to keep these separate in a shell?

    > **Answer**:  Keeping these seperate is important since it allows error messages to be dealt with independently from the regular output. If they were together, errors could be mixed with valid output.

- How should our custom shell handle errors from commands that fail? Consider cases where a command outputs both STDOUT and STDERR. Should we provide a way to merge them, and if so, how?

    > **Answer**: Our shell should handle errors from commands that fail by keeping STDOUT and STDERR seperate in order to prevent error messages from interfering the normal output. We should provide a way to merge by making STDERR and STDOUT go to the same destination. 
