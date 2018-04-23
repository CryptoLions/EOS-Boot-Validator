#!/bin/bash

DATABASE="testDB"

function mongoCreateCollection {
    collection=$1
    mongo <<EOF
    use $DATABASE
    db.createCollection("$collection")
EOF
}

function mongoAddToCollection {
    collection=$1
    data=$2
    mongo <<EOF
    use $DATABASE
    db.$collection.insert($data)
EOF
}


function mongoUpdateCollection {
    collection=$1
    query=$2
    data=$3
    mongo <<EOF
    use $DATABASE
    db.$collection.update($query, $data, { upsert: true })
EOF
}



#echo $(mongoCreateCollection testValidator)
#echo $(mongoAddToCollection testValidator '{block:1, account:"test", anydata: "data"}')
#echo $(mongoUpdateCollection testValidator '{block:1}' '{block:1, account:"test2", anydata: "data"}')
