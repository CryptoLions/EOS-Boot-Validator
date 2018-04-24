#!/bin/bash
SNAPSHOT_URL="https://raw.githubusercontent.com/eosdac/airdrop/master/snapshots/snapshot_290.csv"
DATADIR="data"

#------------------------------------------------------------------------------------------------

# Creating dirs and load files
if [ ! -d $DATADIR ]; then
    mkdir $DATADIR
fi

if [ ! -f $DATADIR/snapshot.csv ]; then
    wget $SNAPSHOT_URL -O $DATADIR/snapshot.csv
    csvtool col 2,3 $DATADIR/snapshot.csv > $DATADIR/snapshot.txt
fi




SUM=0
ROW=0
echo "Loading snapshot.. \n"
filelines=$(cat $DATADIR/snapshot.txt)
filelines=$(echo "$filelines" | tr -d ".")
TOTAL=$(wc -l < $DATADIR/snapshot.txt)
echo -ne "Snapshot loaded.\n"

echo -ne "Calculating Totals:\n"
for line in $filelines; do
    addr=($(echo "$line" | tr "," " "))
    ROW=$(($ROW+1))
    SUM=$(( $SUM+${addr[1]} ))

    echo -ne "$ROW / $TOTAL : ${addr[0]} =  ${addr[1]}                                             \r"
done
echo -ne "SUM: $SUM \n\n"
