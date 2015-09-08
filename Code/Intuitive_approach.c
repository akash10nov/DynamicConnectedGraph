#include <time.h>
#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h>
#include <stdint.h>
#define MAX 100
#define MIN 1

uint64_t getTime()
{
	struct timeval t;
	gettimeofday(&t, NULL);
	return (uint64_t)(t.tv_sec)*1000000 + (uint64_t)(t.tv_usec);
}
int ModifyMatrix_node_seperation(int** Mat,int n, int index)
{
	/* for node seperation
	*  delete one whole row
	*  and respective edges
	*  from other rows.
	*/
	int i=0;
	int j=0;
	
	for(i=0;i<n;i++)
	{
		Mat[i][index]=0;
		Mat[index][i]=0;
	}

	return 1;
}



int ModifyMatrix_random_deletion(int** Mat,int n,int *delete)
{
	int i;
	int j;
	i=0;
	j=0;
	int k=0;
	for(k=0;k<n;k++)
	{
		i=rand()%n;
		for(j=0;j<n;j++)
		{
			if(Mat[i][j]==1)
			{
				Mat[i][j]=0;
				Mat[j][i]=Mat[i][j];
				delete[0]=i;
				delete[1]=j;
				return 1;
			}
		}
	}

	return 1;
}


int ModifyMatrix_insertion(int** Mat,int n)
{

	int i;
	int j;
	i=0;
	j=0;
		int k=0;
	for(k=0;k<n;k++)
	{
		i=rand()%n;
		for(j=0;j<n;j++)
		{
			if(Mat[i][j]==0)
			{
				Mat[i][j]=1;
				Mat[j][i]=Mat[i][j];
				return 1;
			}
		}
	}

	return 1;
}



int ConnectedGraph_checker(int** Mat,int* elements_covered,int* queue,int n)
{
			//printf("CHECK.1\n");

			//elements_covered[0]=1;
			int add=0;
			//printf("CHECK.2\n");

			for(int j=0;j<n;j++)
			{
				if(Mat[0][j]==1)
				{
					elements_covered[j]=1;
					//printf("q:index:%d  value:%d\n",add,j);
					queue[add++]=j;
				}
			}
			//printf("CHECK.3\n");

			for(int i=1;i<n;i++)
			{
				for(int j=0;j<n;j++)
				{
					//printf("%2d %2d\n",i,j);
					if(queue[i]<0)
					{
						//printf("%d,here\n",i);
						return -1;
					}
					if(Mat[queue[i]][j]==1 && i!=j && elements_covered[j]!=1 && queue[i]>0)
					{
						//printf("q:add:%d  value:%d\n",add,j);
						queue[add++]=j;
						elements_covered[j]=1;
					}
				}
			}
		//printf("CHECK.4\n");

		for(int i=0;i<n;i++)
		{
			if(elements_covered[i]==0)
			{
			//	printf("%d\n",i);
				return -1;
			}
		}
		//printf("CHECK.5\n");

		return 1;
	
	
}

int main(int argc,char** argv)
{
	int n;
	//printf("Num of vertices:\n");
	n=atoi(argv[1]);
	int index;
	
	/* declare an 2-D array to store information about edges*/
	int** adj_matrix;
	adj_matrix=(int**) malloc ((sizeof(int*))*n);
	int i,j;
	for (i = 0; i < n; i++){
		adj_matrix[i] = (int *)malloc(sizeof(int) * n);
	}
	for(i=0;i<n;i++)
	{
		for(j=i;j<n;j++)
		{
			int p;
			p=(rand() % n);
			int r;
			r=p/(n-20);
			//printf("%d\n",r);
			adj_matrix[i][j]=r;
			adj_matrix[j][i]=adj_matrix[i][j];
		}
	}
	
	int* elements_covered;
	elements_covered=(int*) malloc(sizeof(int)*n);
	int* queue;
	queue=(int*) malloc(sizeof(int)*n);
	for(i=0;i<n;i++)
	{
		elements_covered[i]=0;
	}
	/*check the whether graph is connected or not*/
	int true_false=ConnectedGraph_checker(adj_matrix,elements_covered,queue,n);
	
	if(true_false==1)
	{
		printf("Graph is connected\n");
	}
	else
		printf("Graph is NOT connected\n");
	for(i=0;i<n;i++)
	{
		//elements_covered[i]=0;
		queue[i]=-1;
	}
	=

	int p;
	
	int type;
	type=2;
	
	if(type==2)
		p=ModifyMatrix_random_deletion(adj_matrix,n);
	/*if(type==3)
		p=ModifyMatrix_insertion(adj_matrix,n);
	*/
	//printf("4\n");
	 uint64_t astart, aend;
	 astart = getTime();
	 int Num;
	 Num=atoi(argv[2]);
	 int delete[2];
	
	for(i=0;i<Num;i++)
	{
		p=ModifyMatrix_random_deletion(adj_matrix,n,delete);
		
		if()
		{
		int true_false1=ConnectedGraph_checker(adj_matrix,elements_covered,queue,n);
		//printf("5\n");
	
		if(true_false1==1)
		{
			//printf("Graph is still connected\n");	
		}
		else
		{
		}
	}	//printf("Now,Graph is NOT connected\n");
	}	
	  aend = getTime();
	
    printf("time taken :%f vertices: %d requsts: %d\n",(aend-astart)/1000000.0,n,Num); 


	return 0;
}
