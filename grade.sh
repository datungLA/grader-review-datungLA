CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission      # remove student submission if it exists
rm -rf grading-area            # remove grading area if it exists

mkdir grading-area             # create grading area directory

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
if [[ -e student-submission/ListExamples.java ]] && [[ -f student-submission/ListExamples.java ]]
then
    echo 'student submitted correct file'
    echo 'compiling'
    javac -cp $CPATH student-submission/ListExamples.java
    if [[ $? > 0 ]]
    then 
        echo 'failed to compile student-submission file'
        exit 1 
    fi
    echo 'sucessfully compiling'
    cp student-submission/*.java grading-area
    cp TestListExamples.java grading-area
    cd grading-area
    javac -cp $CPATH *.java
else
    echo 'file does not exist or student submitted wrong file'

fi
