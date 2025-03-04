#!/usr/bin/env bats

# File: student_tests.sh
# 
# Create your unit tests suit in this file

@test "Example: check ls runs without errors" {
    run ./dsh <<EOF                
ls
EOF

    # Assertions
    [ "$status" -eq 0 ]
}


@test "Check uname runs without errors" {
    run ./dsh <<EOF
uname
EOF

    # Assertions
    [ "$status" -eq 0 ]
}


@test "Check ls runs with argument" {
    run ./dsh <<EOF
ls -a
EOF

    # Assertions
    [ "$status" -eq 0 ]
}



@test "Check uname runs without errors with an argument" {
    run ./dsh <<EOF
uname -a
EOF

    # Assertions
    [ "$status" -eq 0 ]
}

@test "Check echo runs without errors" {
    run ./dsh <<EOF
echo "Hello, world!"
EOF
    [ "$status" -eq 0 ]
}





@test "Check whoami runs without errors" {
    run ./dsh <<EOF
whoami
EOF
    [ "$status" -eq 0 ]
}










@test "Check pwd runs without errors" {
    run ./dsh <<EOF
pwd
EOF

    # Assertions
    [ "$status" -eq 0 ]
}




@test "Handling of extra starting whitespace" {
  run "./dsh" <<EOF
   echo    "Multiple   spaces"
EOF
  stripped_output=$(echo "$output" | tr -d '\t\n\r\f\v')
  echo "$stripped_output" | grep -q "Multiple   spaces"
  [ "$status" -eq 0 ]
}


@test "cat works properly" {
echo "HELLOOOOO" > TXTXTTEMP.txt  


run "./dsh" <<EOF
cat TXTXTTEMP.txt   
EOF
 expected_output="HELLOOOOOdsh3>dsh3>cmdloopreturned0"
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



@test "Change of directory with .." {
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
    expected_output="${PWD}/dsh-test${PWD}dsh3>dsh3>dsh3>dsh3>dsh3>cmdloopreturned0"

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




@test "cd works with quotation marks" {
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
    
    
    expected_output="${PWD}/dsh-testdsh3>dsh3>dsh3>cmdloopreturned0"

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



@test "8 pipes works" {
    current=$(pwd)


    

    run "${current}/dsh" <<EOF
echo a | cat | cat | cat | cat | cat | cat | cat | cat
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="adsh3>dsh3>cmdloopreturned0"

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

@test "8 pipes works with quotes" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo "a" | cat | cat | cat | cat | cat | cat | cat | cat
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="adsh3>dsh3>cmdloopreturned0"

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





@test "arguments in pipes work" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo "Hello world" | wc -c
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="12dsh3>dsh3>cmdloopreturned0"

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


@test "arguments in multi-pipes work" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo "Hello world" | wc -c | wc -c
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="3dsh3>dsh3>cmdloopreturned0"

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











@test "cat file using pipes" {
    current=$(pwd)

echo "NEW FILE!!!!!" > TEMPTMP.TMPTEMPFILE


    run "${current}/dsh" <<EOF
cat  TEMPTMP.TMPTEMPFILE | tr 'A-Z' 'a-z' 
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="newfile!!!!!dsh3>dsh3>cmdloopreturned0"

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



@test "Pipe works twice in a row" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo Hello world | tr 'a-z' 'A-Z' | rev
echo Hello world | tr 'A-Z' 'a-z'
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="DLROWOLLEHhelloworlddsh3>dsh3>dsh3>cmdloopreturned0"

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

@test "Pipe works multiple times in a row" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo Hello world | tr 'a-z' 'A-Z' | rev
echo Hello world | tr 'A-Z' 'a-z'
echo a | cat | cat | cat | cat | cat | cat | cat | cat
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="DLROWOLLEHhelloworldadsh3>dsh3>dsh3>dsh3>cmdloopreturned0"

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


@test "reverse pipe test" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo Hello world | tr 'a-z' 'A-Z' | rev 
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="DLROWOLLEHdsh3>dsh3>cmdloopreturned0"

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

@test "reverse pipe test with quotes" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo "Hello world" | tr 'a-z' 'A-Z' | rev
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="DLROWOLLEHdsh3>dsh3>cmdloopreturned0"

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


@test "Error on 9 pipes" {
    current=$(pwd)




    run "${current}/dsh" <<EOF
echo a | cat | cat | cat | cat | cat | cat | cat | cat | cat
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching


    expected_output="error:pipinglimitedto9commandsdsh3>cmdloopreturned-2"

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












@test "cd with extra arguments doesnt error" {
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
    expected_output="${PWD}/dsh-test${PWD}dsh3>dsh3>dsh3>dsh3>dsh3>cmdloopreturned0"

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










@test "Handling of extra ending whitespace" {
  run "./dsh" <<EOF
   echo "Multiple   spaces at end"                                                                                                 







EOF
  stripped_output=$(echo "$output" | tr -d '\t\n\r\f\v')
  echo "$stripped_output" | grep -q "Multiple   spaces"
  [ "$status" -eq 0 ]
}



@test "Handling of extra starting and ending whitespace" {
  run "./dsh" <<EOF
   echo                            "Multiple   spaces"                      
EOF
  stripped_output=$(echo "$output" | tr -d '\t\n\r\f\v')
  echo "$stripped_output" | grep -q "Multiple   spaces"
  [ "$status" -eq 0 ]
}



@test "Handling of whitespace with tabs, new lines, etc." {
  run "./dsh" <<EOF
   echo   \r \v \f \t\f "Multiple   spaces"           \t   \n      \f
EOF
  stripped_output=$(echo "$output" | tr -d '\t\n\r\f\v')
  echo "$stripped_output" | grep -q "Multiple   spaces"
  [ "$status" -eq 0 ]
}



@test "Exit command" {
    run "./dsh" <<EOF
exit
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]')
    expected_output="dsh3>cmdloopreturned0"
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]

}




@test "Invalid command" {
    run "./dsh" <<EOF
nonexistentcommand
EOF
    stripped_output=$(echo "$output" | tr -d '[:space:]')
    expected_output="Errorexecutingcommanddsh3>dsh3>dsh3>cmdloopreturned0"
    echo "Captured stdout:"
    echo "Output: $output"
    echo "Exit Status: $status"
    echo "${stripped_output} -> ${expected_output}"
    [ "$stripped_output" = "$expected_output" ]
}


