#!/usr/bin/env bash

files=$(find . -type f)

for f in $files
do
    # info=
    info=$(file -i $f | grep -E 'illegal|text' | grep -vE './.git|charset=utf-8')

    if [[ $info ]]
    then
        tmpfile=${f}.utf8
        echo "Converting «${f}» into «${tmpfile}»..." >&2

        iconv -f L1 -t UTF-8 $f > $tmpfile \
            && (mv $tmpfile $f; echo WIN >&2) \
            || (rm $tmpfile; echo FAIL >&2)
    fi
done
