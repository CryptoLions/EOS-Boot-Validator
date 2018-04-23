#!/bin/bash
SNAPSHOT_URL="https://github.com/eosdac/airdrop/raw/master/snapshots/distribution_300.csv"
DATADIR="data"

function getSnapShotSum {
    SUM=0
    ROW=0
    while read line;
    do
        echo -ne $line"                                             \r"
        ROW=$(($ROW+1))
        pubKeyBalance=$(echo "$line" | tr "," " ")
        pubKeyBalanceArr=( $(echo "$pubKeyBalance" | tr -d ".") )
        SUM=$(($SUM+${pubKeyBalanceArr[1]}))

    done <$DATADIR/snapshot.txt
    echo -ne "\n\nSUM: $SUM"
    #return $SUM
}

#------------------------------------------------------------------------------------------------

if [ ! -d $DATADIR ]; then
    mkdir $DATADIR
fi

if [ ! -f $DATADIR/snapshot.csv ]; then
    wget $SNAPSHOT_URL -O $DATADIR/snapshot.csv
    csvtool col 1,2 $DATADIR/snapshot.csv > $DATADIR/snapshot.txt
fi

echo $( getSnapShotSum )
