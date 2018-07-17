
CC = gcc
CXX = g++
RM = rm -f
FLAGS = -g -Wall

all: client.o server.o

client.o: client.c	
	$(CC) $(FLAGS) -o client.o client.c

server.o: server.c
	$(CC) $(FLAGS) -o server.o server.c

clean:
	$(RM) *.o
