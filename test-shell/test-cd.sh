#!/bin/bash

source utils.sh
describe "Change Working Directory"

grade6=0
grade6max=5
./test-cd-1.sh && grade6=`expr $grade6 "+" 1`
./test-cd-2.sh && grade6=`expr $grade6 "+" 1`
./test-cd-3.sh && grade6=`expr $grade6 "+" 1`
./test-cd-4.sh && grade6=`expr $grade6 "+" 1`
./test-cd-5.sh && grade6=`expr $grade6 "+" 1`
echo ""
suit $grade6 $grade6max
echo ""
