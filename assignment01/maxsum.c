#include <stdio.h>
#include <assert.h>

/* === Macros === */

#ifdef ENDEBUG
#define DEBUG(...) do { fprintf(stderr, __VA_ARGS__); } while(0)
#else
#define DEBUG(...)
#endif

/* === Prototypes === */

int maxsum (int max, int val);

/* === Implementations === */

int main(int argc, char** argv){
	/*int result0 = maxsum(0,0);
	(void) printf("maxsum(0,0) returns %i expected was 0\n", result0 );
	assert( result0 == 0);
	DEBUG("\n");

	int result1 = maxsum(0,-1);
	(void) printf("maxsum(0,-1) returns %i expected was 0\n", result1 );
	assert( result1 == 0);
	DEBUG("\n");

	int result2 = maxsum(10,1);
	(void) printf("maxsum(10,1) returns %i expected was 1\n", result2 );
	assert( result2 == 1);
	DEBUG("\n");

	int result3 = maxsum(20,10);
	(void) printf("maxsum(20,10) returns %i expected was 20\n", result3 );
	assert( result3 == 20);*/
	assert(maxsum (0,0) == 0);
}

int maxsum (int max, int val) {
	DEBUG("##########maxsum(%i,%i)##########\n",max,val);
	int result = 0;
	int i = 0;

	if (val < 0)
		val = -val;

	while ((i < val) && (result <= max)) {
		i = i + 1;
		result = result + i;
		DEBUG("i=%i result=%i\n",i,result);
	}

	if (result <= max)
		return result;
	else
		return max;
}
