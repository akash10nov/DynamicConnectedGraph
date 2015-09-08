#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <sys/time.h>
#include <stdint.h>
#define MAX 100
#define MIN 1
__global__ void DUKernel(int *D_Level,int *D_Del,int n, int num);
void IscomponentSame(int *L,int *D, int n,int num);

uint64_t getTime(){
	struct timeval t;
	gettimeofday(&t, NULL);
	return (uint64_t)(t.tv_sec)*1000000 + (uint64_t)(t.tv_usec);
}
int ModifyMatrix_node_seperation(int* Mat,int n, int index)
{
	/* for node seperation
	*  delete one whole row
	*  and respective edges
	*  from other rows.
	*/
	int i=0;
	//int j=0;
	
	for(i=0;i<n;i++)
	{
		Mat[(i*n)+index]=0;
		Mat[(index*n)+i]=0;
	}

	return 1;
}



int ModifyMatrix_random_deletion(int* Mat,int n, int Num,int *del_list)
{
	int i;
	int j;
	int count=0;
	i=0;
	j=0;
	int k=0;
	for(k=0;k<n;k++)
	{
		i=(rand()%n);
		for(j=0;j<n;j++)
		{
			if(Mat[(i*n)+j]==1)
			{
				Mat[(i*n)+j]=0;
				Mat[(j*n)+i]=Mat[(i*n)+j];
				del_list[(count*2)+0]=i;
				del_list[(count*2)+1]=j;
				count++;
				if(count==Num)
					return 1;
				break;
			}
		}
	}


	return 1;

}


int ModifyMatrix_insertion(int* Mat,int n)
{

	int i;
	int j;
	//int flag=0;
	j=0;
	int k=0;
	for(k=0;k<n;k++)
	{
		i=(rand()%n);
		for(j=0;j<n;j++)
		{
			if(Mat[(i*n)+j]==0)
			{
				Mat[(i*n)+j]=1;
				Mat[(j*n)+i]=Mat[(i*n)+j];
				return 1;
			}
		}
	}


	return 1;


}


int ConnectedGraph_checker(int* Mat,int* elements_covered,int* queue,int n)
{
			//printf("CHECK.1\n");

			elements_covered[0]=1;
			int add=0;
			//printf("CHECK.2\n");

			for(int j=1;j<n;j++)
			{
				if(Mat[j]==1)
				{
					elements_covered[j]=2;
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
				
					if(queue[i]>-1 && Mat[(queue[i]*n)+j]==1 && i!=j && elements_covered[j]<1 )
					{
						//printf("q:add:%d  value:%d\n",add,j);
						queue[add++]=j;
						elements_covered[j]=elements_covered[queue[i]]+1;
					}
				}
			}
		//printf("CHECK.4\n");

		for(int i=0;i<n;i++)
		{
			if(elements_covered[i]<0)
			{
				printf("%d\n",i);
				return -1;
			}
		}
		//printf("CHECK.5\n");

		return 1;
	
	
}

int main(int argc, char **argv)
{
	int n;
	//printf("Num of vertices:\n");
	//scanf("%d",&n);
	n=atoi(argv[1]);
	int index;
	
	/* declare an 2-D array to store information about edges*/
	int* adj_matrix;
	adj_matrix=(int*) malloc ((sizeof(int*))*n*n);
	int i,j;
	for(i=0;i<n;i++)
	{
		for(j=i;j<n;j++)
		{
			int p;
			p=(rand() % n);
			int r;
			r=p/(n-15);
			//printf("%d\n",r);
			adj_matrix[(i*n)+j]=r;
			adj_matrix[(j*n)+i]=adj_matrix[(i*n)+j];
		}
	}
	int count=0;
	for(i=0;i<n;i++)
	{
		for(j=i;j<n;j++)
		{
			if(adj_matrix[(i*n)+j]==1)
				count++;
		}
		//printf("\n");
	}
	//printf("No of vertices: %d\n",n);
	count=0;

	int* elements_covered;
	elements_covered=(int*) malloc(sizeof(int)*n);
	int* queue;
	queue=(int*) malloc(sizeof(int)*n);
	for(i=0;i<n;i++)
	{
		elements_covered[i]=-1;
	}
	/*check the whether graph is connected or not*/
	int true_false=ConnectedGraph_checker(adj_matrix,elements_covered,queue,n);
	
	if(true_false==1)
	{
		//printf("Graph is connected\n");
	}
	else
		printf("Graph is NOT connected\n");
	for(i=0;i<n;i++)
	{
		//elements_covered[i]=-1;
		queue[i]=-1;
	}
	//printf("1\n");
	//struct timeval start, end;
	//printf("2\n");

	//int p;
	//gettimeofday(&start, NULL);
	//printf("3\n");
	//printf("Modify type:\n");
	//printf("1.detach one node\n");
	//printf("2.Random deletion\n");
	//printf("3.insertion.\n");
	int type;
	//scanf("%d",&type);
	type=2;
	int Num;
	int *deletions;
	if(type==1)
	{
		printf("Node index to be removed:\n");
		scanf("%d",&index);
	}
	if(type==2)
	{
		//printf("How many edge deletion:\n");
		Num=atoi(argv[2]);
		//scanf("%d",&Num);
		deletions=(int *)malloc(sizeof(int)*2*Num);
	}
	int p=0;
	//printf("Edges removes:%d:\n",Num);

	if(type==1)
		p=ModifyMatrix_node_seperation(adj_matrix,n,index);
	if(type==2)
		p=ModifyMatrix_random_deletion(adj_matrix,n,Num,deletions);
	if(type==3)
		p=ModifyMatrix_insertion(adj_matrix,n);
	//printf("4\n");
	
	/*
	for(i=0;i<Num;i++)
	{
		//printf("edge to be deleted:%d %2d\n",deletions[(i*2)],deletions[(i*2)+1]);
		//printf("their weight:%d %2d\n",elements_covered[deletions[(i*2)]],elements_covered[deletions[(i*2)+1]]);

		
	}

	*/
	
	//int flag=1;
	
	IscomponentSame(elements_covered,deletions,n,Num);
	/*
		for(int i=0;i<n;i++)
		printf("ele:%d \n",elements_covered[i]);
	*/
	int* harmful;
	harmful=(int*)malloc((sizeof(int)*Num));
	for(i=0;i<Num;i++)
	{
		//printf("edge:%d. %2d %2d\n",i,deletions[(i*2)],deletions[(i*2)+1]);
		if(deletions[(i*2)]<-1)
		{
			int Vertice=(deletions[(i*2)]+2)/(-2);
			for(j=0;j<n;j++)
			{
				if(j!=Vertice && adj_matrix[(Vertice*n)+j]==1)
				{
					if(elements_covered[Vertice]>=elements_covered[j])
					{
						//printf("num %d. Deletion was safe.\n",i);
						harmful[i]=1;
						break;
					}
				}	
			}
		}
			
		else if(deletions[(i*2)+1]<-1)
		{
			int Vertice=(deletions[(i*2)]+2)/(-2);
			for(j=0;j<n;j++)
			{
				if(j!=Vertice && adj_matrix[(Vertice*n)+j]==1)
				{
					if(elements_covered[Vertice]>=elements_covered[j])
					{
						//printf("num %d. Deletion was safe.\n",i);
						harmful[i]=1;

						break;
					}
				}	
			}
		}
		else if(deletions[(i*2)]==-1)
		{
			//printf("num %d. Deletion was safe.\n",i);
			harmful[i]=1;
		}
					
	}
	int s=0;
	for(i=0;i<Num;i++)
	{
		if(harmful[i]!=1)
			s=1;//printf("%d deletion would divide graph into 2 parts\n",i);
		else
		{
		}
	}


	return 0;
}
void IscomponentSame(int *L,int *D, int n,int num) 
{ 
    int *d_Level ,*d_Deletions; 
    uint64_t astart, aend;
   
    cudaMalloc(&d_Level, n*sizeof(int));
    cudaMalloc(&d_Deletions, num*2*sizeof(int));
   int i=0;
    //Copying data to device from host 
   astart = getTime();
    cudaMemcpy(d_Level, L, sizeof(int)*n,cudaMemcpyHostToDevice);
    cudaMemcpy(d_Deletions, D, sizeof(int)*(num*2),cudaMemcpyHostToDevice);
	
     
   DUKernel<<<1 ,num,4*num*2>>>(d_Level, d_Deletions ,n,num); 
   
   //cudaMemcpy(L, d_Level, sizeof(int)*(n),cudaMemcpyDeviceToHost);
   
   cudaMemcpy(D, d_Deletions, sizeof(int)*(num*2),cudaMemcpyDeviceToHost);
	 aend = getTime();
    //Deallocating memory on the device 
    cudaFree(d_Level); 
    cudaFree(d_Deletions);
   
	
    printf("%f,%10d,%10d \n",(aend-astart)/1000000.0,n,num); 
}


__global__ void DUKernel(int *D_Level,int *D_Del,int n, int num)
{
	// 10x10 size matrix is for experiment, so argv[1]=10
 
   	 extern __shared__ int temp[];	 
	   int p=threadIdx.x;
	 //int j=blockIdx.x;
	 //int p= threadIdx.x+(blockIdx.x*blockDim.x);
	 temp[p*2]= D_Del[(p*2)];
	 temp[(p*2)+1]= D_Del[(p*2)+1];

	 __syncthreads();
	//int i=0;
	
	/*int s=0;
	 while(i<threadIdx.x && s< blockIdx.x)
	 {
		temp[p]=temp[p]-(temp[(s*dimension)+(k*(j/1000))+k] * ((temp[(j*dimension)+(i*(j/1000))+i])/temp[(j*dimension)+(j*(j/1000))+j]));
		i++;
		s++;
	 }
	 */
	//printf("threadID:%d\n",p);
	//printf("out: %d %2d  %d\n",D_Level[D_Del[(p*2)]],D_Level[D_Del[(p*2)+1]],p);
	 if(D_Level[D_Del[(p*2)]]> D_Level[D_Del[(p*2)+1]])
	 {
		 temp[(p*2)]=(temp[(p*2)]*-2)-2;
		// printf("Kernel: %d %2d %2d\n",D_Del[(p*2)],D_Del[(p*2)+1], p);

	 }
	 else if(D_Level[D_Del[(p*2)]]< D_Level[D_Del[(p*2)+1]])
	 {
		temp[(p*2)+1]=(temp[(p*2)+1]*-2)-2;
		 //printf("Kernel: %d %2d %2d\n",D_Del[(p*2)],D_Del[(p*2)+1], p);
	 }
	 else
	 {
		 temp[(p*2)]=-1;
		 temp[(p*2)+1]=-1;
		 //printf("Kernel: %d %2d %2d\n",D_Del[(p*2)],D_Del[(p*2)+1], p);

	 }
	//__syncthreads();
	D_Del[(p*2)]=temp[(p*2)+1];
	D_Del[(p*2)]=temp[(p*2)];


}
