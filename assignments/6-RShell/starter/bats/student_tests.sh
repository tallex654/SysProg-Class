#!/usr/bin/env bats

# File: student_tests.sh
# 
# Create your unit tests suit in this file

@test "Local Mode: Example: check ls runs without errors" {
    run ./dsh <<EOF                
ls
EOF

    # Assertions
    [ "$status" -eq 0 ]
}


@test "Local Mode: Check uname runs without errors" {
    run ./dsh <<EOF
uname
EOF

    # Assertions
    [ "$status" -eq 0 ]
}


@test "Local Mode: Check ls runs with argument" {
    run ./dsh <<EOF
ls -a
EOF

    # Assertions
    [ "$status" -eq 0 ]
}





@test "Local Mode: Handling of extra starting whitespace" {
  run "./dsh" <<EOF
   echo    "Multiple   spaces"
EOF
  stripped_output=$(echo "$output" | tr -d '\t\n\r\f\v')
  echo "$stripped_output" | grep -q "Multiple   spaces"
  [ "$status" -eq 0 ]
}


@test "Local Mode: cat works properly" {
echo "HELLOOOOO" > TXTXTTEMP.txt  


run "./dsh" <<EOF
cat TXTXTTEMP.txt   
EOF
 expected_output="HELLOOOOOlocalmodedsh4>dsh4>cmdloopreturned0"
stripped_output=$(echo "$output" | tr -d '[:space:]')
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]

}



@test "Local Mode: Change of directory with .." {
    current=$(pwd)


    mkdir -p ~/tmp 
    cd ~/tmp
    mkdir -p dsh-test

    run "${current}/dsh" <<EOF
cd dsh-test
pwd
cd ..
pwd
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    expected_output="${PWD}/dsh-test${PWD}localmodedsh4>dsh4>dsh4>dsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}




@test "Local Mode: cd works with quotation marks" {
    current=$(pwd)


    mkdir -p ~/tmp
    cd ~/tmp
    mkdir -p dsh-test 

    run "${current}/dsh" <<EOF
cd dsh-test
pwd
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    
    
    expected_output="${PWD}/dsh-testlocalmodedsh4>dsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}



@test "Local Mode: 8 pipes works" {
    current=$(pwd)


    

    run "${current}/dsh" <<EOF
echo a | cat | cat | cat | cat | cat | cat | cat | cat
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="alocalmodedsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}

@test "Local Mode: 8 pipes works with quotes" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo "a" | cat | cat | cat | cat | cat | cat | cat | cat
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="alocalmodedsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}





@test "Local Mode: arguments in pipes work" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo "Hello world" | wc -c
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="12localmodedsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}


@test "Local Mode: arguments in multi-pipes work" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo "Hello world" | wc -c | wc -c
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="3localmodedsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}











@test "Local Mode: cat file using pipes" {
    current=$(pwd)

echo "NEW FILE!!!!!" > TEMPTMP.TMPTEMPFILE


    run "${current}/dsh" <<EOF
cat  TEMPTMP.TMPTEMPFILE | tr 'A-Z' 'a-z' 
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="newfile!!!!!localmodedsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}



@test "Local Mode: Pipe works twice in a row" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo Hello world | tr 'a-z' 'A-Z' | rev
echo Hello world | tr 'A-Z' 'a-z'
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="DLROWOLLEHhelloworldlocalmodedsh4>dsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}

@test "Local Mode: Pipe works multiple times in a row" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo Hello world | tr 'a-z' 'A-Z' | rev
echo Hello world | tr 'A-Z' 'a-z'
echo a | cat | cat | cat | cat | cat | cat | cat | cat
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="DLROWOLLEHhelloworldalocalmodedsh4>dsh4>dsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}


@test "Local Mode: reverse pipe test" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo Hello world | tr 'a-z' 'A-Z' | rev 
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="DLROWOLLEHlocalmodedsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}

@test "Local Mode: reverse pipe test with quotes" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo "Hello world" | tr 'a-z' 'A-Z' | rev
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="DLROWOLLEHlocalmodedsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}


@test "Local Mode: Error on 9 pipes" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo a | cat | cat | cat | cat | cat | cat | cat | cat | cat
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="error:pipinglimitedto9commandslocalmodedsh4>cmdloopreturned-2"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}












@test "Local Mode: cd with extra arguments doesnt error" {
    current=$(pwd)
    mkdir -p ~/tmp
    cd ~/tmp
    mkdir -p dsh-test

    run "${current}/dsh" <<EOF
cd dsh-test one two three
pwd
cd .. one two three
pwd
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    expected_output="${PWD}/dsh-test${PWD}localmodedsh4>dsh4>dsh4>dsh4>dsh4>cmdloopreturned0"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}










@test "Local Mode: Handling of extra ending whitespace" {
  run "./dsh" <<EOF
   echo "Multiple   spaces at end"                                                                                                 







EOF
  stripped_output=$(echo "$output" | tr -d '\t\n\r\f\v')
  echo "$stripped_output" | grep -q "Multiple   spaces"
  [ "$status" -eq 0 ]
}



@test "Local Mode: Handling of extra starting and ending whitespace" {
  run "./dsh" <<EOF
   echo                            "Multiple   spaces"                      
EOF
  stripped_output=$(echo "$output" | tr -d '\t\n\r\f\v')
  echo "$stripped_output" | grep -q "Multiple   spaces"
  [ "$status" -eq 0 ]
}



@test "Local Mode: Handling of whitespace with tabs, new lines, etc." {
  run "./dsh" <<EOF
   echo   \r \v \f \t\f "Multiple   spaces"           \t   \n      \f
EOF
  stripped_output=$(echo "$output" | tr -d '\t\n\r\f\v')
  echo "$stripped_output" | grep -q "Multiple   spaces"
  [ "$status" -eq 0 ]
}



@test "Local Mode: Exit command" {
    run "./dsh" <<EOF
exit
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]')
    expected_output="localmodedsh4>cmdloopreturned0"
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]

}




@test "Local Mode: Invalid command" {
    run "./dsh" <<EOF
nonexistentcommand
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')
    expected_output="Errorexecutingcommandlocalmodedsh4>localmodedsh4>dsh4>cmdloopreturned0"
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]
}



@test "Client/server: Exit works properly" {
    ./dsh -s -p 4092 &

    server_pid=$!


    sleep 1



    run ./dsh -c -p 4092 <<EOF
exit
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')
    expected_output="socketclientmode:addr:127.0.0.1:4092rsh>cmdloopreturned0"


    echo "Captured stdout:"

echo "$stripped_output" | cat -A

    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]





}




@test "Client/server: Echo command works properly" {
    ./dsh -s -p 4092 &

    server_pid=$!


    sleep 1



    run ./dsh -c -p 4092 <<EOF
echo Hello, World!
exit
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')
    expected_output="socketclientmode:addr:127.0.0.1:4092rsh>Hello,World!rsh>cmdloopreturned0"


    echo "Captured stdout:"

echo "$stripped_output" | cat -A

    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]





}


@test "Client/server: Echo command works with quotations properly" {
    ./dsh -s -p 4092 &

    server_pid=$!


    sleep 1



    run ./dsh -c -p 4092 <<EOF
echo "Hello, World!"
exit
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')
    expected_output="socketclientmode:addr:127.0.0.1:4092rsh>Hello,World!rsh>cmdloopreturned0"
    

    echo "Captured stdout:"
    echo "Output: $output"

    echo "$stripped_output" | cat -A
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]





}





@test "Client/server: 2 pipes work properly" {
    ./dsh -s -p 4092 &

    server_pid=$!


    sleep 1



    run ./dsh -c -p 4092 <<EOF
echo Hello world | tr 'a-z' 'A-Z'
exit
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')
    expected_output="socketclientmode:addr:127.0.0.1:4092rsh>HELLOWORLDrsh>cmdloopreturned0"


    echo "Captured stdout:"

echo "$stripped_output" | cat -A

    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]





}

@test "Client/server: 2 pipes work properly with quotes" {
    ./dsh -s -p 4092 &

    server_pid=$!


    sleep 1



    run ./dsh -c -p 4092 <<EOF
echo "Hello world" | tr 'a-z' 'A-Z'
exit
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')
    expected_output="socketclientmode:addr:127.0.0.1:4092rsh>HELLOWORLDrsh>cmdloopreturned0"


    echo "Captured stdout:"

echo "$stripped_output" | cat -A

    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]





}



@test "Client/server: 3 pipes work properly with quotes" {
    ./dsh -s -p 4092 &

    server_pid=$!


    sleep 1



    run ./dsh -c -p 4092 <<EOF
echo "Hello world" | tr 'a-z' 'A-Z' | rev
exit
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')
    expected_output="socketclientmode:addr:127.0.0.1:4092rsh>DLROWOLLEHrsh>cmdloopreturned0"


    echo "Captured stdout:"

echo "$stripped_output" | cat -A

    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]





}


@test "Client/server: 3 pipes work properly without quotes" {
    ./dsh -s -p 4092 &

    server_pid=$!


    sleep 1



    run ./dsh -c -p 4092 <<EOF
echo "Hello world" | tr 'a-z' 'A-Z' | rev
exit
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')
    expected_output="socketclientmode:addr:127.0.0.1:4092rsh>DLROWOLLEHrsh>cmdloopreturned0"


    echo "Captured stdout:"

echo "$stripped_output" | cat -A

    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]





}


@test "Client/server: 8 pipes work properly" {
    ./dsh -s -p 4092 &

    server_pid=$!


    sleep 1



    run ./dsh -c -p 4092 <<EOF
echo "a" | cat | cat | cat | cat | cat | cat | cat | cat
exit
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')
    expected_output="socketclientmode:addr:127.0.0.1:4092rsh>arsh>cmdloopreturned0"


    echo "Captured stdout:"

echo "$stripped_output" | cat -A

    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]





}






@test "Client/server: Change of directory test" {
    current=$(pwd)
	mkdir -p tmp
	cd tmp
	mkdir -p cool
	cd ..


    ./dsh -s -p 4398 &

    server_pid=$!


    sleep 1



    run ./dsh -c -p 4398 <<EOF
cd tmp
ls
stop-server
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')

    # Expected output with all whitespace removed for easier matching
    expected_output="socketclientmode:addr:127.0.0.1:4398rsh>socketservermode:addr:0.0.0.0:4398->Single-ThreadedModersh>coolrsh>cmdloopreturned-50"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}



@test "Client/server: Change of directory test with quotes" {
    current=$(pwd)
        mkdir -p tmp
        cd tmp
        mkdir -p cool
        cd ..


    ./dsh -s -p 4398 &

    server_pid=$!


    sleep 1



    run ./dsh -c -p 4398 <<EOF
cd "tmp"
ls
stop-server
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]\04')

    # Expected output with all whitespace removed for easier matching
    expected_output="socketclientmode:addr:127.0.0.1:4398rsh>socketservermode:addr:0.0.0.0:4398->Single-ThreadedModersh>coolrsh>cmdloopreturned-50"

    # These echo commands will help with debugging and will only print
    #if the test fails
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

    # Assertions
    [ "$status" -eq 0 ]



}





@test "Client/server: Connection refusal when server is not on" {

run ./dsh -c -p 4122 <<EOF 
exit
EOF

    stripped_output=$(echo "$output" | tr -d '[:space:]\04')
    expected_output="connect:Connectionrefusedstartclient:Invalidargumentsocketclientmode:addr:127.0.0.1:4122cmdloopreturned-52"


    echo "Captured stdout:"

echo "$stripped_output" | cat -A

    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]





}







@test "exit from remote shell shuts down server" {
skip    

    	./dsh -s &
    	SERVER_PID=$!
    	sleep 1
        run ./dsh -c <<EOF
exit
EOF

	
	

    stripped_output=$(echo "$output" | tr -d '[:space:]')
    expected_output="socketclientmode:addr:127.0.0.1:1234rsh>cmdloopreturned0"
    
    run ./dsh -c <<EOF
stop-server
EOF
    
    echo "Captured stdout:" 
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"

    # Check exact match
    [ "$stripped_output" = "$expected_output" ]

}


