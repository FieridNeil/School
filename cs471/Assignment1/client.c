/*
   CPSC 471
   Assignment 1
   Group member: Hympert Nguyen
		 Xuan Do
		 Ebtihal Jaber Alwadee
		 Wesley Tang
*/

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/wait.h>
#include <signal.h>
#include <ctype.h>          
#include <arpa/inet.h>
#include <netdb.h>


const int MAXSIZE = 1024;
const int SOCKET = 8000;

// Downloads a file from the server
void get(int socket, char *filename){
	char path[100];
	strcpy(path, "client/");
	strcat(path, filename);
	printf("Client: Receiving file from server...\n");
	char revbuf[MAXSIZE];
	FILE *r_file =fopen(path, "w+");
	
	if(r_file == NULL)
		printf("File %s Cannot be openned.\n", filename);
	else
	{
		bzero(revbuf, MAXSIZE);
		int r_block_sz = 0;
		while ((r_block_sz = recv(socket, revbuf, MAXSIZE, 0)) > 0)
		{
			int write_sz = fwrite(revbuf, sizeof(char), r_block_sz, r_file);
			if(write_sz < r_block_sz)
			{
				printf("File write failed.\n");

			}
			bzero(revbuf, MAXSIZE);
			if (r_block_sz == 0 || r_block_sz != 1024)
			{
				break;

			}	
		}
		if (r_block_sz < 0)
		{
			if (errno == EAGAIN)
			{
				printf("rec() time out.\n");
			}
			else
			{
				fprintf(stderr, "recv() filed due to errno = %d\n", errno);
			}
		}
		printf("Received from Server!\n");
		fclose(r_file);
	}
	
}

// Uploads a file to the server
void put(int socket, char* filename){
	// Send the file's name
	char path[100];
	strcpy(path, "client/");
	strcat(path, filename);
	char sdbuf[MAXSIZE];
	printf("Client: Sending %s to the Server ...\n", filename);
	FILE *s_file = fopen(path, "r");
	if (s_file == NULL)
	{
		printf("ERROR: File %s not found.\n", filename);
	}
	
	bzero(sdbuf, MAXSIZE);
	int s_block_sz;
	while((s_block_sz = fread(sdbuf,sizeof(char), MAXSIZE, s_file)) > 0)
	{
		if(send(socket, sdbuf, s_block_sz, 0) < 0){
			fprintf(stderr, "Fail to send get file %s(errno = %d)\n", filename, errno);
			break;
		}
		bzero(sdbuf, MAXSIZE);

	}
	printf("File %s from Client was Sent Successfully!\n", filename);

}

// Close the socket and quit the program
void quit(int socket){
	char request[5] = "quit";
	if(send(socket, request, sizeof(request), 0) < 0){
		printf("Fail to send quit message %s\n", strerror(errno));
	}else{
		printf("Messege sent\n");
	}
	close(socket);
	exit(1);
}

int main(int argc, char* argv[]){

	int c_socket;

	/********************************/
	/*------------ SET UP ----------*/
	/********************************/
	// Create a socket
	if ((c_socket = socket(AF_INET, SOCK_STREAM, 0)) == -1)
	{
		fprintf(stderr, "ERROR: Failed to obtain Socket Descriptor! (errno = %d)\n",errno);
	}
	
	// Connect the socket to the server
	struct sockaddr_in c_sockaddr;
	c_sockaddr.sin_family = AF_INET;		// TCP 
	c_sockaddr.sin_port = htons(SOCKET);		// Port number
	c_sockaddr.sin_addr.s_addr = INADDR_ANY;	// Localhost ip adress
	bzero(&(c_sockaddr.sin_zero), 8);
	
	int c_connect = connect(c_socket, (struct sockaddr*) &c_sockaddr, sizeof(c_sockaddr));
	if(c_connect < 0){
		printf("Fail to connect to the server %s \n", strerror(errno));
	}
	else
		printf("Client: Connected to server at port %d...ok!\n", SOCKET);

	/********************************/
	/*---------- MAIN LOOP ---------*/
	/********************************/
	char input[256];
	char filename[250];
	char cmd[5];
		
	while(1){
		printf("ftp> ");
		// Flush the stream
		fflush(stdin);
		fgets(input, 50, stdin);
		// Remove the trailing \r\n
		input[strcspn(input, "\r\n")] = 0;
		sscanf(input, "%s%s", cmd, filename);	
		if(strcmp(cmd,"get") == 0){
			if(send(c_socket, &input, sizeof(input), 0) < 0){
			printf("Fail to send ls message %s\n", strerror(errno));
			}
			get(c_socket, filename);
		}else if(strcmp(cmd,"put") == 0){
			if(send(c_socket, &input, sizeof(input), 0) < 0){
			printf("Fail to send ls message %s\n", strerror(errno));
			}
			put(c_socket, filename);
		}else if(strcmp(cmd,"ls") == 0){
			if(send(c_socket, &input, sizeof(input), 0) < 0){
				printf("Fail to send ls message %s\n", strerror(errno));
			}
			//ls(c_socket);
		}else if(strcmp(cmd,"quit") == 0){
			if(send(c_socket, &input, sizeof(input), 0) < 0){
			printf("Fail to send ls message %s\n", strerror(errno));
			}
			close(c_socket);
			exit(1);
		}else{
			printf("Invalid command\n");
		}
	}

	return 0;
}
