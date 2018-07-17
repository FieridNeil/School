/*
   CPSC 471
   Assignment 1
   Group member: Hympert Nguyen
		 Xuan Do
		 Ebtihal Jaber Alwadee
		 Wesley Tang
*/

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <signal.h>
#include <ctype.h>          
#include <arpa/inet.h>
#include <netdb.h>
#include <dirent.h>
#include <unistd.h>

const int BACKLOG = 5;
const int MAXSIZE = 1024;
const int SOCKET = 8000;

//Receive file to Client

void put(int socket, char* filename){

	char path[100];
	strcpy(path, "server/");
	strcat(path, filename);
	char revbuf[MAXSIZE];
	FILE *r_file = fopen(path, "w+");
	if(r_file == NULL)
		printf("File  %s Cannot be opened file on server.\n", path);
	else
	{
		bzero(revbuf, MAXSIZE);
		int r_block_size = 0;
		while ((r_block_size = recv(socket, revbuf, MAXSIZE, 0)) > 0)
		{
			int write_size = fwrite(revbuf, sizeof(char), r_block_size, r_file);
			if (write_size < r_block_size)
			{
				fprintf(stderr, "File write failed on server.\n");
			}

			bzero(revbuf, MAXSIZE);
			if (r_block_size == 0 || r_block_size != 1024)
			{
				break;
			}
		}
		if (r_block_size < 0)
		{
			if(errno == EAGAIN)
			{
				printf("recv() time out.\n");
			}
		}

		else
		{
			//fprintf(stderr, "recv() failed due to errno = %d\n", errno);
			
		}
	}

	printf("Successfull recieved from client!\n");
	fclose(r_file);

}



//Send file from client

void get(int socket, char* filename){
char sdbuf[MAXSIZE];
	char path[100];
	strcpy(path, "server/");
	strcat(path, filename);
	printf("Server: Sending %s to the Client...", path);
		    FILE *s_file = fopen(path, "r");
		    if(s_file == NULL)
		    {
			printf("Fail to open file\n");
		        //fprintf(stderr, "ERROR: File %s not found on server. (errno = %d)\n", s_filename, errno);
		    }

		    bzero(sdbuf, MAXSIZE); 
		    int s_block_size; 
		    while((s_block_size = fread(sdbuf, sizeof(char), MAXSIZE, s_file))>0)
		    {
		        if(send(socket, sdbuf, s_block_size, 0) < 0)
		        {
		            //fprintf(stderr, "ERROR: Failed to send file %s. (errno = %d)\n", s_filename, errno);
		        }
		        bzero(sdbuf, MAXSIZE);
		    }
		    printf("Successfull sent to client!\n");
		    //close(socket);
		   // printf("Server: Connection with Client closed. Server will wait now...\n");


}



void ls(int socket){
	DIR *d;
	struct dirent *dir;
	d = opendir("server");
	// Every dir contains "." and ".." "files" so we need to exclude those
	// . = current dir
	// .. = previous dir
	int count = 0;
	if(d){
		while((dir = readdir(d)) != NULL){
			if(strcmp(dir->d_name, ".") == 0 || strcmp(dir->d_name,"..") == 0){
				continue;
			}
			count++;
			printf("%s\n", dir->d_name);
		}
	}

	printf("There are %i files\n", count);
}



int main(){
	/**************************************/
	/*-------------- SET UP --------------*/
	/**************************************/
	
	// int num;
	struct sockaddr_in s_sockaddr;
	int s_socket;
	int c_socket;

	// Create server socket
	if ((s_socket = socket(AF_INET, SOCK_STREAM, 0)) == -1)
	{
		fprintf(stderr, "Fail to create server socket (errno = %d)\n", errno);
		exit(1);
	}
	else
		printf("Server: Obtaining socket description successfully.\n");


	// Define the server address
	s_sockaddr.sin_family = AF_INET;  //Protocol Family
	s_sockaddr.sin_port = htons(SOCKET);	// Port number
	s_sockaddr.sin_addr.s_addr = INADDR_ANY; //AutoFill local address
	bzero(&(s_sockaddr.sin_zero),8);	//flush the rest of struct

	
	// Bind the socket to an IP address

	if (bind(s_socket, (struct sockaddr*) &s_sockaddr, sizeof(s_sockaddr)) == -1 )
	{
		fprintf(stderr, "ERROR: Failed to bind Port. (errno = %d)\n", errno);
		exit(1);
		
	}
	else 
		printf("Server: Binded tcp port %d in addr 127.0.0.1 sucessfully.\n",SOCKET);


	// Start listening for clients
	if(listen(s_socket, BACKLOG) == -1){
		fprintf(stderr, "ERROR: Failed to listen Port. (errno = %d)\n", errno);
		exit(1);
	}
	else
		printf ("Server: Listening the port %d successfully.\n", SOCKET);

	c_socket = accept(s_socket, NULL, NULL);

	//system("cd ; chmod +x script.sh ; ./script.sh");

	/**************************************/
	/*------------ MAIN LOOP -------------*/
	/**************************************/

	char mes[256];
	char cmd[5];
	char filename[250];
	while(1){
		if(recv(c_socket, &mes, sizeof(mes), 0) < 0){
			printf("Fail to receive option %s\n", strerror(errno));
		}else{
			sscanf(mes, "%s%s", cmd, filename);			
			if(strcmp(cmd, "get") == 0){
				//printf("cmd: %s, filename: %s\n", cmd, filename);
				get(c_socket, filename);
			}else if(strcmp(cmd, "put") == 0){
				//printf("cmd: %s, filename: %s\n", cmd, filename);
				put(c_socket, filename);				
			}else if(strcmp(cmd, "ls") == 0){
				ls(c_socket);
			}else if(strcmp(cmd, "quit") == 0){
				close(s_socket);
				exit(1);
			}
	
		}

	}

		

	

	return 0;
	
}
