#include <stdio.h>
#include <string.h>
#include <stdlib.h>


#define BUFFER_SZ 50

//prototypes
void usage(char *);
void print_buff(char *, int);
int  setup_buff(char *, char *, int);

//prototypes for functions to handle required functionality
int  count_words(char *, int, int);
//add additional prototypes here


int setup_buff(char *buff, char *user_str, int len){
    bool requireChar = true;
  int charNumber = 0;
	int strLength;
   for (int i = 0, user_str[i] != "\0", i++) {
	if (charNumber < len) { // Will continue so long as the length of entered string is less than the buffer
	
		if (requireChar) {
			if (user_str[i] != ' ' && user_str[i] != "\t") {
				buff[charNumber] = user_str[i];
				charNumber++;
				requireChar = false;
			}

		} else {
			buff[charNumber] = user_str[i];
                        charNumber++;
			if (user_str[i] == ' ' && user_str[i] == "\t") {
				requireChar = true;

			}

		}
	} else {
		printf("The user supplied string is too large\n");
		return -1;
	}

   
   }
strLength = charNumber;
   while (charNumber < len) {
	buff[charNumber] = '.';
	charNumber++;
   }
	buff[len] = '\0';
	return strLength;

}

void print_buff(char *buff, int len){
    printf("Buffer:  ");
    for (int i=0; i<len; i++){
        putchar(*(buff+i));
    }
    putchar('\n');
}

void usage(char *exename){
    printf("usage: %s [-h|c|r|w|x] \"string\" [other args]\n", exename);

}

int count_words(char *buff, int len, int str_len){
    //YOU MUST IMPLEMENT
    return 0;
}

//ADD OTHER HELPER FUNCTIONS HERE FOR OTHER REQUIRED PROGRAM OPTIONS

int main(int argc, char *argv[]){

    char *buff;             //placehoder for the internal buffer
    char *input_string;     //holds the string provided by the user on cmd line
    char opt;               //used to capture user option from cmd line
    int  rc;                //used for return codes
    int  user_str_len;      //length of user supplied string

    //TODO:  #1. WHY IS THIS SAFE, aka what if arv[1] does not exist?
    //      This is completely safe because of the conditional before it. Specifially, argc < 2. This conditional will return true if there are less than 2 elements. Meaning that if it is true (Has less than 2 elements), the second conditional will never run because the or statement would have already returned true. In the event whee argc has more than 1 element and returns false, the second statement about the first element of argv will run. This would be fine because we know that argv has more than one element if it got to this point. 
    
    if ((argc < 2) || (*argv[1] != '-')){
        usage(argv[0]);
        exit(1);
    }

    opt = (char)*(argv[1]+1);   //get the option flag

    //handle the help flag and then exit normally
    if (opt == 'h'){
        usage(argv[0]);
        exit(0);
    }

    //WE NOW WILL HANDLE THE REQUIRED OPERATIONS

    //TODO:  #2 Document the purpose of the if statement below
    //      In this program, argv[2] would be the string entered by the user, which is used just after this if block. The purpose of the if block is to determine if the argument count is greater than 2. If a user correctly entered the operation and string, the argument count should be 3. However, if the user entered something incorrect, the following argv[2] call would cause an error. Therefore, it is vital to check if the argument count is over 2.
    if (argc < 3){
        usage(argv[0]);
        exit(1);
    }

    input_string = argv[2]; //capture the user input string

    //TODO:  #3 Allocate space for the buffer using malloc and
    //          handle error if malloc fails by exiting with a 
    //          return code of 99
    buff = (char *)malloc(BUFFER_SZ * sizeof(char));
    if (buff == NULL) {
	    printf("Error allocating memory\n");
	    exit(99);
    }


    user_str_len = setup_buff(buff, input_string, BUFFER_SZ);     //see todos
    if (user_str_len < 0){
        printf("Error setting up buffer, error = %d", user_str_len);
        exit(2);
    }

    switch (opt){
        case 'c':
            rc = count_words(buff, BUFFER_SZ, user_str_len);  //you need to implement
            if (rc < 0){
                printf("Error counting words, rc = %d", rc);
                exit(2);
            }
            printf("Word Count: %d\n", rc);
            break;

        //TODO:  #5 Implement the other cases for 'r' and 'w' by extending
        //       the case statement options
        default:
            usage(argv[0]);
            exit(1);
    }

    //TODO:  #6 Dont forget to free your buffer before exiting
    print_buff(buff,BUFFER_SZ);
    exit(0);
}

//TODO:  #7  Notice all of the helper functions provided in the 
//          starter take both the buffer as well as the length.  Why
//          do you think providing both the pointer and the length
//          is a good practice, after all we know from main() that 
//          the buff variable will have exactly 50 bytes?
//  
//          PLACE YOUR ANSWER HERE
