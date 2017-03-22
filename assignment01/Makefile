CC = gcc
CFLAGS = -std=c99 -pedantic -Wall -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -g -DENDEBUG
LFLAGS =
OBJECTS = maxsum.c

all: clean ue01

ue01 :
		$(CC) $(LFLAGS) $(CFLAGS) $(OBJECTS) -o maxsum

clean:
		rm -f maxsum

.PHONY: clean
