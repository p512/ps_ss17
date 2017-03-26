CC = gcc
CFLAGS = -std=c99 -pedantic -Wall -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -g -DENDEBUG -fprofile-arcs -ftest-coverage
LFLAGS =


all: clean ue01 invariant

ue01 :
		$(CC) $(LFLAGS) $(CFLAGS) maxsum.c -o maxsum
invariant :
		$(CC) $(LFLAGS) $(CFLAGS) invariant.c -o invariant

clean:
		rm -f maxsum invariant

.PHONY: clean
