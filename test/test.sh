#!bin/bash

MY_TESTS=
STAN_SOURCE=/c/cs223/Hwk2/Psched
MY_SOURCE=./Psched
WRITTEN="stanout.txt
        myout.txt
        myerr.txt
        stanerr.txt"
i=0
j=0
n=0

for file in $MY_TESTS; do
    let n = n + 1
    echo "*************************" $file "Test **************************"
    $STAN_SOURCE <$file >stanout.txt 2>stanerr.txt
    $MY_SOURCE <$file >myout.txt 2>myerr.txt
    echo "diff on outputs for test file " $file
    if diff stanout.txt myout.txt >/dev/null; then
        echo stdout same on $file
        let i = i + 1
    else
        echo stdout differs on $file:
        diff stanout.txt myout.txt
    fi
    if diff stanerr.txt myerr.txt >/dev/null; then
        echo stderr same on $file
        let j = j + 1
    else
        echo stderr differs on $file:
        diff stanerr.txt myerr.txt
    fi
    echo ""
done

echo TOTAL $i/$n STDOUT PASSED
echo TOTAL $j/$n STDERR PASSEd

for wrote in $WRITTEN; do
    rm $wrote
done
