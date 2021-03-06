#!/bin/bash

source ./utils.sh
it "CD-02: cd pwd"

rm $CSH_OUT $BUSH_OUT
echo "cd" > $BUSH_IN
echo "/bin/pwd" >> $BUSH_IN
echo "cd" > $CSH_IN
echo "/bin/pwd" >> $CSH_IN

/bin/sh < $CSH_IN > $CSH_OUT 2>&1
$SHELL < $BUSH_IN > $BUSH_OUT 2>&1

diff $BUSH_OUT $CSH_OUT
check $?
succeed
