#!/usr/bin/env bash
#SANITY
set -ue

#CONFIG
FILE=graph.cnf
VARS=16
if [ -z "${VERBOSE+x}" ]; then
    VERBOSE=false
fi

#SCRIPT
minisatSolveStrategy() {
    got="$(minisat "$tmp2" 2>"$tmp" | tail -n1)"
}
picosatSolveStrategy() {
    got="$(picosat "$tmp2" 2>"$tmp" | head -n1 | sed 's/s \(.*\)/\1/g')"
}

init() {
    tmp="$(mktemp)"
    tmp2="$(mktemp)"
    failed=0
    if $(which minisat > /dev/null); then
        solveStrategy=minisatSolveStrategy
    elif $(which minisat > /dev/null); then
        solveStrategy=picosatSolveStrategy
    else
        withFail Please install minisat or picosat
    fi
}

fixFile() {
    # Clobbers both tmp files and leaves the result in tmp2
    tail -n+2 > "$tmp"
    cat <(echo p cnf "$VARS" "$(wc -l < "$tmp")") "$tmp" > "$tmp2"
}

cleanup() {
    rm -f testcase_*.cnf
}

withSuccess() {
    [ -t 0 ] && echo -en '\033[32;1m✔ '
    echo "$@"
    [ -t 0 ] && echo -en '\033[0m'
}

withFail() {
    [ -t 0 ] && echo -en '\033[31;1m✘ '
    echo "$@"
    [ -t 0 ] && echo -en '\033[0m'
}

doTest() {
    cat "${FILE}" $1 | grep '^[0-9-]' | fixFile
    ${solveStrategy}
    if [ "$(wc -l < "$tmp")" -gt 0 ]; then
        withFail "There were errors while executing minisat on $tmp2:"
        cat $tmp
        exit 1
    fi
    if [ "$got" == "$4" ]; then
        if [ "$VERBOSE" == true ]; then
            echo PASS "$5" "$2" "$3"
        fi
    else
        name=$(printf "testcase_%03d.cnf" ${failed})
        cp "$tmp2" "$name"
        eval failed=$((failed+1))
        echo ===FAIL=== on "$5" "$2" "$3" EXPECTED "$4" but got "$got", written testcase to "$name"
    fi
}

solidTest() {
    doTest <(echo -e "$1 0\n$2 0") $1 $2 SATISFIABLE solid
}

notSolidTest() {
    doTest <(echo -e "$1 0\n-$2 0") $1 $2 SATISFIABLE "not solid"
}

#DEPENDENCIES
declare -a deps=("minisat")
for i in "${deps[@]}"; do
    which $i > /dev/null || (echo Please install $i for me to work; exit 1);
done

if ! [ -f "$FILE" ]; then
    withFail "ERROR: $FILE does not exist! Exiting..."
    exit 1
fi

init
cleanup

solidTest 1 4
solidTest 1 5
solidTest 2 5
solidTest 3 6
solidTest 3 7
solidTest 5 8
solidTest 5 9
solidTest 6 10
solidTest 6 11
solidTest 6 12
solidTest 7 14
solidTest 9 13
solidTest 12 14
solidTest 13 16

notSolidTest 1 2
notSolidTest 1 3
notSolidTest 1 6
notSolidTest 1 7
notSolidTest 1 10
notSolidTest 1 11
notSolidTest 1 12
notSolidTest 1 14
notSolidTest 1 15

notSolidTest 2 1
notSolidTest 2 3
notSolidTest 2 4
notSolidTest 2 6
notSolidTest 2 7
notSolidTest 2 10
notSolidTest 2 11
notSolidTest 2 12
notSolidTest 2 15

notSolidTest 3 1
notSolidTest 3 2
notSolidTest 3 4
notSolidTest 3 5
notSolidTest 3 8
notSolidTest 3 9
notSolidTest 3 13
notSolidTest 3 15
notSolidTest 3 16

notSolidTest 4 1
notSolidTest 4 2
notSolidTest 4 3
notSolidTest 4 5
notSolidTest 4 6
notSolidTest 4 7
notSolidTest 4 8
notSolidTest 4 9
notSolidTest 4 10
notSolidTest 4 11
notSolidTest 4 12
notSolidTest 4 13
notSolidTest 4 14
notSolidTest 4 15
notSolidTest 4 16

notSolidTest 5 1
notSolidTest 5 2
notSolidTest 5 3
notSolidTest 5 4
notSolidTest 5 6
notSolidTest 5 7
notSolidTest 5 10
notSolidTest 5 11
notSolidTest 5 12
notSolidTest 5 14
notSolidTest 5 15

notSolidTest 6 1
notSolidTest 6 2
notSolidTest 6 3
notSolidTest 6 4
notSolidTest 6 5
notSolidTest 6 7
notSolidTest 6 8
notSolidTest 6 9
notSolidTest 6 13
notSolidTest 6 15

notSolidTest 7 1
notSolidTest 7 2
notSolidTest 7 3
notSolidTest 7 4
notSolidTest 7 5
notSolidTest 7 6
notSolidTest 7 8
notSolidTest 7 9
notSolidTest 7 10
notSolidTest 7 11
notSolidTest 7 12
notSolidTest 7 13
notSolidTest 7 15
notSolidTest 7 16

notSolidTest 8 1
notSolidTest 8 2
notSolidTest 8 3
notSolidTest 8 4
notSolidTest 8 5
notSolidTest 8 6
notSolidTest 8 7
notSolidTest 8 9
notSolidTest 8 10
notSolidTest 8 11
notSolidTest 8 12
notSolidTest 8 13
notSolidTest 8 14
notSolidTest 8 15
notSolidTest 8 16

notSolidTest 9 1
notSolidTest 9 2
notSolidTest 9 3
notSolidTest 9 4
notSolidTest 9 5
notSolidTest 9 6
notSolidTest 9 7
notSolidTest 9 8
notSolidTest 9 10
notSolidTest 9 11
notSolidTest 9 12
notSolidTest 9 14
notSolidTest 9 15

notSolidTest 10 1
notSolidTest 10 2
notSolidTest 10 3
notSolidTest 10 4
notSolidTest 10 5
notSolidTest 10 6
notSolidTest 10 7
notSolidTest 10 8
notSolidTest 10 9
notSolidTest 10 11
notSolidTest 10 12
notSolidTest 10 13
notSolidTest 10 14
notSolidTest 10 15
notSolidTest 10 16

notSolidTest 11 1
notSolidTest 11 2
notSolidTest 11 3
notSolidTest 11 4
notSolidTest 11 5
notSolidTest 11 6
notSolidTest 11 7
notSolidTest 11 8
notSolidTest 11 9
notSolidTest 11 10
notSolidTest 11 12
notSolidTest 11 13
notSolidTest 11 14
notSolidTest 11 15
notSolidTest 11 16

notSolidTest 12 1
notSolidTest 12 2
notSolidTest 12 3
notSolidTest 12 4
notSolidTest 12 5
notSolidTest 12 6
notSolidTest 12 7
notSolidTest 12 8
notSolidTest 12 9
notSolidTest 12 10
notSolidTest 12 11
notSolidTest 12 13
notSolidTest 12 15
notSolidTest 12 16

notSolidTest 13 1
notSolidTest 13 2
notSolidTest 13 3
notSolidTest 13 4
notSolidTest 13 5
notSolidTest 13 6
notSolidTest 13 7
notSolidTest 13 8
notSolidTest 13 9
notSolidTest 13 10
notSolidTest 13 11
notSolidTest 13 12
notSolidTest 13 14
notSolidTest 13 15

notSolidTest 14 1
notSolidTest 14 2
notSolidTest 14 3
notSolidTest 14 4
notSolidTest 14 5
notSolidTest 14 6
notSolidTest 14 7
notSolidTest 14 8
notSolidTest 14 9
notSolidTest 14 10
notSolidTest 14 11
notSolidTest 14 12
notSolidTest 14 13
notSolidTest 14 15
notSolidTest 14 16

notSolidTest 15 1
notSolidTest 15 2
notSolidTest 15 3
notSolidTest 15 4
notSolidTest 15 5
notSolidTest 15 6
notSolidTest 15 7
notSolidTest 15 8
notSolidTest 15 9
notSolidTest 15 10
notSolidTest 15 11
notSolidTest 15 12
notSolidTest 15 13
notSolidTest 15 14
notSolidTest 15 16

notSolidTest 16 1
notSolidTest 16 2
notSolidTest 16 3
notSolidTest 16 4
notSolidTest 16 5
notSolidTest 16 6
notSolidTest 16 7
notSolidTest 16 8
notSolidTest 16 9
notSolidTest 16 10
notSolidTest 16 11
notSolidTest 16 12
notSolidTest 16 13
notSolidTest 16 14
notSolidTest 16 15

doTest <(echo -e "1 0\n2 0") 1 2 SATISFIABLE custom1
doTest <(echo -e "1 0\n3 0") 1 3 UNSATISFIABLE custom2

if [ "$failed" == 0 ]; then
    [ "$VERBOSE" == true ] && echo
    withSuccess ALL TESTS PASSED
else
    echo
    withFail "$failed" TESTS FAILED
fi
