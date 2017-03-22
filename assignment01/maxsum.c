#include <stdio.h>

int maxsum (int max, int val);

int main (void){
	int result0 = maxsum(0,0);
	int result1 = maxsum(0,-1);
	int result2 = maxsum(10,1);

	(void) printf("maxsum(0,0) returns %i expected was 0\n", result0 );
	(void) printf("maxsum(0,-1) returns %i expected was 0\n", result1 );
	(void) printf("maxsum(10,1) returns %i expected was 1\n", result2 );

	return 0;
}

int maxsum (int max, int val) {
	int result = 0;
	int i = 0;

	if (val < 0)
		val = -val;

	while ((i < val) && (result <= max)) {
		i = i + 1;
		result = result + i;
	}

	if (result <= max)
		return result;
	else
		return max;
}
