#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include "dshlib.h"

/*
 * Implement your exec_local_cmd_loop function by building a loop that prompts the 
 * user for input.  Use the SH_PROMPT constant from dshlib.h and then
 * use fgets to accept user input.
 * 
 *      while(1){
 *        printf("%s", SH_PROMPT);
 *        if (fgets(cmd_buff, ARG_MAX, stdin) == NULL){
 *           printf("\n");
 *           break;
 *        }
 *        //remove the trailing \n from cmd_buff
 *        cmd_buff[strcspn(cmd_buff,"\n")] = '\0';
 * 
 *        //IMPLEMENT THE REST OF THE REQUIREMENTS
 *      }
 * 
 *   Also, use the constants in the dshlib.h in this code.  
 *      SH_CMD_MAX              maximum buffer size for user input
 *      EXIT_CMD                constant that terminates the dsh program
 *      SH_PROMPT               the shell prompt
 *      OK                      the command was parsed properly
 *      WARN_NO_CMDS            the user command was empty
 *      ERR_TOO_MANY_COMMANDS   too many pipes used
 *      ERR_MEMORY              dynamic memory management failure
 * 
 *   errors returned
 *      OK                     No error
 *      ERR_MEMORY             Dynamic memory management failure
 *      WARN_NO_CMDS           No commands parsed
 *      ERR_TOO_MANY_COMMANDS  too many pipes used
 *   
 *   console messages
 *      CMD_WARN_NO_CMD        print on WARN_NO_CMDS
 *      CMD_ERR_PIPE_LIMIT     print on ERR_TOO_MANY_COMMANDS
 *      CMD_ERR_EXECUTE        print on execution failure of external command
 * 
 *  Standard Library Functions You Might Want To Consider Using (assignment 1+)
 *      malloc(), free(), strlen(), fgets(), strcspn(), printf()
 * 
 *  Standard Library Functions You Might Want To Consider Using (assignment 2+)
 *      fork(), execvp(), exit(), chdir()
 */






int exec_local_cmd_loop() {
    	char *cmd_buff = malloc(SH_CMD_MAX);
	int rc = 0;

	if (!cmd_buff) {
       	 	return ERR_MEMORY;
    	}

   
       


	int first = 1;
 	   while (1) {
        	if (!first) {
         	   	printf("%s", SH_PROMPT);
       	 }
        	
		
	first = 0;

        if (fgets(cmd_buff, SH_CMD_MAX, stdin) == NULL) {
           	 if (!isatty(STDIN_FILENO)) {
             	 	  printf("%s", SH_PROMPT);
            	}
           	 printf("\n");
           	 break;
        }

           cmd_buff[strcspn(cmd_buff, "\n")] = '\0';

           char *start = cmd_buff;
        	while (isspace((unsigned char)*start)) {
            		start++;
        	}
        	
		
		
		
		if (*start == '\0') {
            		printf("%s", CMD_WARN_NO_CMD);
        
			continue;
        	
		
		
		
		}
       
	       
	
	
		if (strcmp(start, EXIT_CMD) == 0) {
        
	    		break;
      
		}

       		 cmd_buff_t cmd;
      	 	 memset(&cmd, 0, sizeof(cmd_buff_t));

     		   cmd._cmd_buffer = strdup(start);
     		   if (!cmd._cmd_buffer) {
     	   			    fprintf(stderr, "Memory allocation error.\n");
        	    	continue;
        		}

       		 int argc = 0;
        	char *p = cmd._cmd_buffer;
        	while (*p != '\0') {
        	    
			
			while (isspace((unsigned char)*p)) {
                	*p = '\0';
        


	       
			p++;
           	
		    }
          	  
			
		if (*p == '\0') {
          		      break;
         
     		}

     	       if (*p == '"') {
        
	       
		       p++;
        	        cmd.argv[argc++] = p;
                
			
		while (*p && *p != '"') {
                
		    	p++;
                
		}
                
	
		if (*p == '"') {
        
	    
			*p = '\0';
        	            p++;
                }
            
	       } else {
               	
		       cmd.argv[argc++] = p;
                
		       while (*p && !isspace((unsigned char)*p)) {
                  
	       		       p++;
              	 }
            
	       }

	       
            if (argc >= CMD_ARGV_MAX - 1) {
                break;
            }
        }
        
		
		cmd.argv[argc] = NULL;
        	cmd.argc = argc;

       		 if (cmd.argc < 1) {
         	   printf("%s", CMD_WARN_NO_CMD);
        
       		   free(cmd._cmd_buffer);
        
		    continue;
       		 }

       		 if (strcmp(cmd.argv[0], "cd") == 0) {
       	
	    
	
			 if (cmd.argc > 1 && strlen(cmd.argv[1]) > 0) {
              
	     
			     if (chdir(cmd.argv[1]) == 0) {
                    char *cwd = getcwd(NULL, 0);
       
       
		    if (cwd != NULL) {
        	                setenv("PWD", cwd, 1);
	                    }
               
			    
			     }

	     		 }
            			 
		 free(cmd._cmd_buffer);

     		 continue;
     
	      
		 }

        pid_t pid = fork();
        
	
	if (pid < 0) {
        	    fprintf(stderr, "Error executing command\n");
       
	       
		    free(cmd._cmd_buffer);
        
		    continue;
        }

        if (pid == 0) {
            execvp(cmd.argv[0], cmd.argv);
       
       	    fprintf(stderr, "Error executing command\n");
       
       	    exit(ERR_EXEC_CMD);
       
       		} else {
            int status;
       
       	    waitpid(pid, &status, 0);
        }
   
   	free(cmd._cmd_buffer);
    }

    free(cmd_buff);
    return OK;
}











