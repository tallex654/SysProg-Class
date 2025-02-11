#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#include "dshlib.h"

/*
 *  build_cmd_list
 *    cmd_line:     the command line from the user
 *    clist *:      pointer to clist structure to be populated
 *
 *  This function builds the command_list_t structure passed by the caller
 *  It does this by first splitting the cmd_line into commands by spltting
 *  the string based on any pipe characters '|'.  It then traverses each
 *  command.  For each command (a substring of cmd_line), it then parses
 *  that command by taking the first token as the executable name, and
 *  then the remaining tokens as the arguments.
 *
 *  NOTE your implementation should be able to handle properly removing
 *  leading and trailing spaces!
 *
 *  errors returned:
 *
 *    OK:                      No Error
 *    ERR_TOO_MANY_COMMANDS:   There is a limit of CMD_MAX (see dshlib.h)
 *                             commands.
 *    ERR_CMD_OR_ARGS_TOO_BIG: One of the commands provided by the user
 *                             was larger than allowed, either the
 *                             executable name, or the arg string.
 *
 *  Standard Library Functions You Might Want To Consider Using
 *      memset(), strcmp(), strcpy(), strtok(), strlen(), strchr()
 */
int build_cmd_list(char *cmd_line, command_list_t *clist)
{
    memset(clist,0,sizeof(command_list_t));

    while (*cmd_line == SPACE_CHAR) {
	    
	    cmd_line++;

    }

    if (!*cmd_line) {

	return OK;

    }



char *token, *saveptr;
int cmd_count = 0;

for (token = strtok_r(cmd_line,PIPE_STRING,&saveptr); token; token = strtok_r(NULL,PIPE_STRING,&saveptr)) {

	if (cmd_count >= CMD_MAX) {
		return ERR_TOO_MANY_COMMANDS;

	}

	while (*token == SPACE_CHAR) {
		token++;

	}
	char *end = token +strlen(token)- 1;

	while (end > token && *end == SPACE_CHAR) {
		*end = '\0';
		end--;

	}

	char *exe = strtok(token," ");
	char *args = strtok(NULL,"");

	if (!exe || strlen(exe) >= EXE_MAX || (args && strlen(args) >= ARG_MAX)) {

		return ERR_CMD_OR_ARGS_TOO_BIG;

	}

	strcpy(clist->commands[cmd_count].exe,exe);
	if (args) {

		strcpy(clist->commands[cmd_count].args, args);

	} else {

		clist->commands[cmd_count].args[0] = '\0';
	}
	cmd_count++;


}




clist->num = cmd_count;
return OK;







}
