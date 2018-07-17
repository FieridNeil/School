# Assignment 1

### Members: 
  - Hympert Nguyen
  - Xuan Do
  - Ebtihal Jaber Alwadee
  - Wesley Tang



### Folder structure
  |= parent_folder/ <br />
  |== client/ <br />
  |----- client.txt <br />
  |== server/ <br />
  |----- server.txt <br />
  |----- big.txt <br />
  |-- makefile <br />
  |-- README.md <br />
  |-- client.c <br />
  |-- server.c <br />

### Compile and run
Compile with the following commands:
  - make: make all files
  - make client.o: make only client.o file from client.c
  - make server.o: make only server.o file from server.c

Run:
  - ./server.o: start server FIRST
  - ./client.o <IP/HOST> <PORT>: For this assignment <IP/HOST> = localhost and <PORT> = 8000
  
  
### Commands:
  - put <filename.txt>: Upload a file from client to server
  - get <filename.txt>: Download a file from server to client
  - ls: list files inside server folder
  - quit: quit
  
  
### Due date: Sat 4/7/2018
  
