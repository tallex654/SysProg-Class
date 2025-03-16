1. How does the remote client determine when a command's output is fully received from the server, and what techniques can be used to handle partial reads or ensure complete message transmission?

The remote client determines that the command's output is fully received using EOF markers. In order to handle partial reads, recv() can be used in a loop. 

2. This week's lecture on TCP explains that it is a reliable stream protocol rather than a message-oriented one. Since TCP does not preserve message boundaries, how should a networked shell protocol define and detect the beginning and end of a command sent over a TCP connection? What challenges arise if this is not handled correctly?

Since we know TCP is a stream protocol, the message boundries should be defined using delimiters such as EOF and \n. If not handled correctly, messages may be incomplete or an indefinite waiting of data.

3. Describe the general differences between stateful and stateless protocols.

Stateful protocols maintain session info, such as the working directory. Meanwhile, stateless protocols treat each request independently, which would require all necessary information to be sent with each individual request. 

4. Our lecture this week stated that UDP is "unreliable". If that is the case, why would we ever use it?

It can be used in situations where speed is more important than reliability. In other words, if packet loss is acceptable, then speed might be more important to go for.

5. What interface/abstraction is provided by the operating system to enable applications to use network communications?

The socket interface is provided by the operating system in order to enable applications to use network communications.
