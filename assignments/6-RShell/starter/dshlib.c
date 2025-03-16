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
int exec_local_cmd_loop()
{
   	char *cmd_buff = malloc(SH_CMD_MAX);
	int rc = 0;

	if (!cmd_buff) {
       	 	return ERR_MEMORY;
    	}

   
       


 	   while (1) {
        //	if (!first) {
         	   	printf("%s", SH_PROMPT);
       	// }
        	
		
			int done = 0;

        if (fgets(cmd_buff, SH_CMD_MAX, stdin) == NULL) {
            	
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
        		
			return OK;
			//exit(0);
	    		break;
     			 
		}






//-----------------------------------------------------------------------------------------
//
//
//
//
//
//
       cmd_buff_t cmda;
                 memset(&cmda, 0, sizeof(cmd_buff_t));

                   cmda._cmd_buffer = strdup(start);
                   if (!cmda._cmd_buffer) {
                                    fprintf(stderr, "Memory allocation error.\n");
                        continue;
                        }

                 int argca = 0;
                char *pa = cmda._cmd_buffer;
                while (*pa != '\0') {


                        while (isspace((unsigned char)*pa)) {
                        *pa = '\0';




                        pa++;

                    }


                if (*pa == '\0') {
                              break;

                }

               if (*pa == '"') {


                       pa++;
                        cmda.argv[argca++] = pa;


                while (*pa && *pa != '"') {

                        pa++;

                }


                if (*pa == '"') {


                        *pa = '\0';
                            pa++;
                }

               } else {

                       cmda.argv[argca++] = pa;

                       while (*pa && !isspace((unsigned char)*pa)) {
                                                                                              




                               pa++;
                 }

               }


            if (argca >= CMD_ARGV_MAX - 1) {
                break;
            }
        }


                cmda.argv[argca] = NULL;
                cmda.argc = argca;

                 if (cmda.argc < 1) {
                   printf("%s", CMD_WARN_NO_CMD);

                   free(cmda._cmd_buffer);

                    continue;
                 }









//--------------------------------------------------------------------------------------------



























                 if (strcmp(cmda.argv[0], "cd") == 0) {

                                

                         if (cmda.argc > 1 && strlen(cmda.argv[1]) > 0) {


                             if (chdir(cmda.argv[1]) == 0) {
                    char *cwda = getcwd(NULL, 0);


                    if (cwda != NULL) {
                                setenv("PWD", cwda, 1);
                            }


                             }


                         }



  free(cmda._cmd_buffer);
  //break;
 continue;

                }




		char *cmdList[CMD_ARGV_MAX];

		int count = 0;

		char *t = strtok(start, PIPE_STRING);



		while (t != NULL) {


			cmdList[count++] = t;

			t=strtok(NULL, PIPE_STRING);
			

		}

		if (count > CMD_ARGV_MAX) {

		fprintf(stderr, CMD_ERR_PIPE_LIMIT,CMD_ARGV_MAX);
		return ERR_TOO_MANY_COMMANDS; 
		}



		int pipes[count-1][2];

		for (int i = 0; i < count-1; i++) {

			if (pipe(pipes[i]) == -1) {

				perror("pipe");
				return ERR_MEMORY;

			}

		}


		pid_t p[count];


		for (int i = 0; i < count; i++) {



			p[i] = fork();

			if (p[i]== -1) {

				perror("fork");
				return ERR_MEMORY;

			}




			if (p[i] == 0) {

				if (i > 0) {

					dup2(pipes[i-1][0], STDIN_FILENO);
			
				}
				if (i < count -1) {

					dup2(pipes[i][1], STDOUT_FILENO);

				}


				for (int j = 0; j < count-1; j++) {

					close(pipes[j][0]);
					close(pipes[j][1]);
				}

				
		






       		 cmd_buff_t cmd;
      	 	 memset(&cmd, 0, sizeof(cmd_buff_t));

     		   cmd._cmd_buffer = strdup(cmdList[i]);
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


		if (strcmp(cmd.argv[0], EXIT_CMD) == 0) {
		return 100;	
			printf("earfersafg");
			exit(0);

		}

/*
       		 if (strcmp(cmd.argv[0], "cd") == 0) {
       	
	    			done = 1;
	
			 if (cmd.argc > 1 && strlen(cmd.argv[1]) > 0) {
              
	     
			     if (chdir(cmd.argv[1]) == 0) {
                    char *cwd = getcwd(NULL, 0);
       
       
		    if (cwd != NULL) {
        	                setenv("PWD", cwd, 1);
	                    }
               
			    
			     }

	     		 
			 }	 
     
	      
  
  free(cmd._cmd_buffer);
  //break;	
 continue;
 
	      	}
//printf("\nggggg\n");
 //if (done == 0) {
*/	 
	 
	 execvp(cmd.argv[0], cmd.argv);
                       	    fprintf(stderr, "Error executing command\n");
       
       	    exit(ERR_EXEC_CMD);
 //}
	    
	    /*


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
            int statusa;
       
       	    waitpid(pid, &statusa, 0);
        }



*/

		}

	   }	

	
		for (int i = 0; i < count - 1; i++) {

		close(pipes[i][0]);
		close(pipes[i][1]);
	}



int status;

	for (int i = 0; i < count; i++) {

		waitpid(p[i], &status, 0);
	}




	   }






    free(cmd_buff);   
    return OK;
}
