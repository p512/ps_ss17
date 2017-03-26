#include <stdio.h>
#include <assert.h>
#include <stdlib.h>

#ifdef ENDEBUG
#define DEBUG(...) do { fprintf(stderr, __VA_ARGS__); } while(0)
#else
#define DEBUG(...)
#endif


int invCode(int r, int i, int n, int (*f)(int,int,int));
int invAssert01(int r, int i, int n);
int invAssert02(int r, int i, int n);
int invAssert03(int r, int i, int n);
int invAssert04(int r, int i, int n);


int main(int argc, char **argv){
	int r = -1;
	int i = 0;
	int n = atoi(argv[1]);
	int assertMethod = atoi(argv[2]);

	switch(assertMethod){
		case 1 :
		       invCode(r,i,n,invAssert01);
		       break;
		case 2 :
		       invCode(r,i,n,invAssert02);
		       break;
		case 3 :
		       invCode(r,i,n,invAssert03);
		       break;
		case 4 :
		       invCode(r,i,n,invAssert04);
		       break;
	}
}

int invCode(int r, int i, int n, int (*invAssert)(int,int,int) ){
	DEBUG("\n#####Start#####\n");
	assert(invAssert(r,i,n) == 0);

	while (( i <= n ) && ( r == -1) ) {
		DEBUG("i= %i; r= %i; n=%i\n",i,r,n);
		assert((*invAssert)(r,i,n) == 0);

		if ( i * i == n )
			r = i;
		else
			i = i + 1;
	
		DEBUG("i= %i; r= %i; n=%i\n",i,r,n);
		assert((*invAssert)(r,i,n) == 0);
	}

	DEBUG("i= %i; r= %i; n=%i\n####END###\n",i,r,n);
	return 0;
}

int invAssert01(int r, int i, int n){
	if(r*r == n || r < 0) return 0;
	else return 1;
}

int invAssert02(int r, int i, int n){
	if(i*i <= n) return 0;
	else return 1;
}

int invAssert03(int r, int i, int n){
	if(r <= 1 || r != n) return 0;
	else return 1;
}

int invAssert04(int r, int i, int n){
	if(r >= -1) return 0;
	else return 1;
}
