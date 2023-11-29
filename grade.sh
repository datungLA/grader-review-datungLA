CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission      # remove student submission if it exists
rm -rf grading-area            # remove grading area if it exists

#mkdir grading-area             # create grading area directory

git clone $1 student-submission
echo 'Finished cloning.'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
if [[ -e student-submission/ListExamples.java ]] && [[ -f student-submission/ListExamples.java ]]
then
    echo 'student submitted correct file.'
    cp student-submission/*.java ./
    #cp TestListExamples.java grading-area
    echo 'compiling...'
    #javac -cp $CPATH grading-area/TestListExamples.java grading-area/ListExamples.java
    javac -cp $CPATH TestListExamples.java ListExamples.java 2> test-output.txt
    if [[ $? > 0 ]]
    then 
        echo 'failed to compile student-submission file.'
        exit 1 
    fi
    echo 'sucessfully compiling.'
    java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt
    FAILURE_OUTPUT=$(grep -c "FAILURES!!!" test-output.txt)        
    if [[ $FAILURE_OUTPUT -eq 0 ]]
    then 
        SUCCESS_MESSAGE=$(grep -i "OK" test-output.txt)
        TEST_COUNT=${SUCCESS_MESSAGE:4:1}
        echo 'all tests passed.'
        echo $TEST_COUNT'/'$TEST_COUNT
        exit 0
    else   
        FAILURE_MESSAGE=$(grep -i "Tests run" test-output.txt)
        FAILURE_COUNT=${FAILURE_MESSAGE:25:1}
        TEST_COUNT=${FAILURE_MESSAGE:11:1}
        echo 'some tests passed.'
        echo $(($TEST_COUNT-$FAILURE_COUNT))'/'$TEST_COUNT
    fi
else
    echo 'file does not exist or student submitted wrong file.'

fi
