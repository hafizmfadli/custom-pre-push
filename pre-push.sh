#!/bin/bash
# dummy apply
# file for store test result : MODIFIED THIS
test_output_file_path='test_result_v1.log'

if [ "$test_output_file_path" = "" ]
then
    echo "test_output_file_path must be specified"
    exit 1
fi

echo "Running unit-tests..."

# execute service owner target Makefile for running unit test :  MODIFIED THIS
make test | tee "./$test_output_file_path"

# check test result
if grep  "^--- FAIL" "$test_output_file_path"; then
    echo "Unit-tests failed, therefore the push is canceled."
    echo "You can check test result on $test_output_file_path"
    echo "Please fix them before pushing again."
    exit 1
else
    echo "Well done, unit-tests are green!"
fi

# check modified and untracked go files
untracked_go_files=$(eval "git ls-files --other --directory --exclude-standard | grep ".go$"")
modifed_go_files=$(eval git diff-index --name-only HEAD | grep ".go$")

if [ -n "$untracked_go_files" ] || [ -n "$modifed_go_files" ]
then
    echo "=============== WARNING: This files has not been committed to the repository. ==============="
    echo -e "untracked go files :\n$untracked_go_files"
    echo -e "modified go files :\n$modifed_go_files"
    echo "============================================================================================="
fi

echo "execute 'git push' ..."
exit 0