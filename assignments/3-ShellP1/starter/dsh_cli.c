#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "dshlib.h"

/*
 * Implement your main function by building a loop that prompts the
 * user for input.  Use the SH_PROMPT constant from dshlib.h and then
 * use fgets to accept user input.  Since we want fgets to also handle
 * end of file so we can run this headless for testing we need to check
 * the return code of fgets.  I have provided an example below of how
 * to do this assuming you are storing user input inside of the cmd_buff
 * variable.
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
 *
 *   Expected output:
 *
 *      CMD_OK_HEADER      if the command parses properly. You will
 *                         follow this by the command details
 *
 *      CMD_WARN_NO_CMD    if the user entered a blank command
 *      CMD_ERR_PIPE_LIMIT if the user entered too many commands using
 *                         the pipe feature, e.g., cmd1 | cmd2 | ... |
 *
 *  See the provided test cases for output expectations.
 */
int main()
{

char dragon_compress[] = {
    1, '\n', 72, ' ', 1, '@', 4, '%', 1, '\n', 69, ' ', 6, '%', 1, '\n', 68, ' ', 6, '%', 1, '\n', 65, ' ', 1, '%', 1, ' ', 7, '%', 11, ' ', 1, '@', 1, '\n', 64, ' ', 10, '%', 8, ' ', 7, '%', 1, '\n', 39, ' ', 7, '%', 2, ' ', 4, '%', 1, '@', 9, ' ', 12, '%', 1, '@', 4, ' ', 6, '%', 2, ' ', 1, '@', 4, '%', 1, '\n', 34, ' ', 22, '%', 6, ' ', 28, '%', 1, '\n', 32, ' ', 26, '%', 3, ' ', 12, '%', 1, ' ', 15, '%', 1, '\n', 31, ' ', 29, '%', 1, ' ', 19, '%', 5, ' ', 3, '%', 1, '\n', 29, ' ', 28, '%', 1, '@', 1, ' ', 1, '@', 18, '%', 8, ' ', 2, '%', 1, '\n', 28, ' ', 33, '%', 1, ' ', 22, '%', 1, '\n', 28, ' ', 58, '%', 1, '\n', 28, ' ', 50, '%', 1, '@', 6, '%', 1, '@', 1, '\n', 6, ' ', 8, '%', 1, '@', 11, ' ', 16, '%', 8, ' ', 26, '%', 6, ' ', 2, '%', 1, '\n', 4, ' ', 13, '%', 9, ' ', 2, '%', 1, '@', 12, '%', 11, ' ', 11, '%', 1, ' ', 12, '%', 6, ' ', 1, '@', 1, '%', 1, '\n', 2, ' ', 10, '%', 3, ' ', 3, '%', 8, ' ', 14, '%', 12, ' ', 24, '%', 1, '\n', 1, ' ', 9, '%', 7, ' ', 1, '%', 9, ' ', 13, '%', 13, ' ', 12, '%', 1, '@', 11, '%', 1, '\n', 9, '%', 1, '@', 16, ' ', 1, '%', 1, ' ', 13, '%', 12, ' ', 1, '@', 25, '%', 1, '\n', 8, '%', 1, '@', 17, ' ', 2, '%', 1, '@', 12, '%', 12, ' ', 1, '@', 28, '%', 1, '\n', 7, '%', 1, '@', 19, ' ', 15, '%', 11, ' ', 33, '%', 1, '\n', 10, '%', 18, ' ', 15, '%', 10, ' ', 35, '%', 6, ' ', 4, '%', 1, '\n', 9, '%', 1, '@', 19, ' ', 1, '@', 14, '%', 9, ' ', 12, '%', 1, '@', 1, ' ', 4, '%', 1, ' ', 17, '%', 3, ' ', 8, '%', 1, '\n', 10, '%', 18, ' ', 17, '%', 8, ' ', 13, '%', 6, ' ', 18, '%', 1, ' ', 9, '%', 1, '\n', 9, '%', 1, '@', 2, '%', 1, '@', 16, ' ', 16, '%', 1, '@', 7, ' ', 14, '%', 5, ' ', 24, '%', 2, ' ', 2, '%', 1, '\n', 1, ' ', 10, '%', 18, ' ', 1, '%', 1, ' ', 14, '%', 1, '@', 8, ' ', 14, '%', 3, ' ', 26, '%', 1, ' ', 2, '%', 1, '\n', 2, ' ', 12, '%', 2, ' ', 1, '@', 11, ' ', 18, '%', 8, ' ', 40, '%', 2, ' ', 3, '%', 1, '\n', 3, ' ', 13, '%', 1, ' ', 2, '%', 2, ' ', 1, '%', 2, ' ', 1, '%', 1, '@', 1, ' ', 18, '%', 10, ' ', 37, '%', 4, ' ', 3, '%', 1, '\n', 4, ' ', 18, '%', 1, ' ', 22, '%', 11, ' ', 1, '@', 31, '%', 4, ' ', 7, '%', 1, '\n', 5, ' ', 39, '%', 14, ' ', 28, '%', 8, ' ', 3, '%', 1, '\n', 6, ' ', 1, '@', 35, '%', 18, ' ', 25, '%', 1, '\n', 8, ' ', 32, '%', 22, ' ', 19, '%', 2, ' ', 7, '%', 1, '\n', 11, ' ', 26, '%', 27, ' ', 15, '%', 2, ' ', 1, '@', 9, '%', 1, '\n', 14, ' ', 20, '%', 11, ' ', 1, '@', 1, '%', 1, '@', 1, '%', 18, ' ', 1, '@', 18, '%', 3, ' ', 3, '%', 1, '\n', 18, ' ', 15, '%', 8, ' ', 10, '%', 20, ' ', 15, '%', 4, ' ', 1, '%', 1, '\n', 16, ' ', 36, '%', 22, ' ', 14, '%', 1, '\n', 16, ' ', 26, '%', 2, ' ', 4, '%', 1, ' ', 3, '%', 22, ' ', 10, '%', 2, ' ', 3, '%', 1, '@', 1, '\n', 21, ' ', 19, '%', 1, ' ', 6, '%', 1, ' ', 2, '%', 26, ' ', 13, '%', 1, '@', 1, '\n', 81, ' ', 7, '%', 1, '@', 1, '\n', 0 
};



    char *cmd_buff = malloc(SH_CMD_MAX*sizeof(char));
    int rc = 0;
    command_list_t clist;

    while (1) {

		printf("%s", SH_PROMPT);

		if (fgets(cmd_buff,ARG_MAX,stdin) == NULL) {
			printf("\n");
			break;

		}	


		cmd_buff[strcspn(cmd_buff,"\n")] = '\0';

		if (strlen(cmd_buff) == 0) {
			printf("%s",CMD_WARN_NO_CMD);
			continue;
		}

		if (strcmp(cmd_buff, EXIT_CMD) == 0) {
			break;

		}
		if (strcmp(cmd_buff,"dragon") == 0) {


			int i = 0;

			while (dragon_compress[i] != 0) {
				
				int count = dragon_compress[i++];
				char character = dragon_compress[i++];
				for (int j = 0; j < count; j++) {
					putchar(character);

				}

			}
			putchar("\n");
		
		}


		rc = build_cmd_list(cmd_buff, &clist);


		if (rc == WARN_NO_CMDS) {

			printf("%s",CMD_WARN_NO_CMD);


		} else if (rc == ERR_TOO_MANY_COMMANDS) {

			printf(CMD_ERR_PIPE_LIMIT,CMD_MAX);

		} else if (rc == OK) {

			printf(CMD_OK_HEADER,clist.num);
			for (int i = 0; i < clist.num; i++) {
				
				if (strlen(clist.commands[i].args) > 0) {
				printf("<%d> %s [%s]\n", i+ 1, clist.commands[i].exe,clist.commands[i].args);


				} else {
					printf("<%d> %s\n", i + 1, clist.commands[i].exe);
				}
			}
		}



    }
	free(cmd_buff);
    return 0;
}
