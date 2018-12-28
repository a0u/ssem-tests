/*
 * Turing Long Division Routine (corrected)
 * 10 July 1948
 *
 * B. J. Shelburne and C. P. Burton, "Early programs on the Manchester
 * Mark I Prototype," in IEEE Annals of the History of Computing,
 * vol. 20, no. 3, pp. 4-15, July-Sept. 1998.
 */
	.text
	.global _start
L3:
	.long 3f - 1	/* jump address */
_start:
	/*
	 * if (a_i >= (b * 2^n)) {
	 *    a_{i+1} = 2 * (a_i - (b * 2^n))
	 *    q_{i+1} = (2 * q_i) + 2^d
	 * } else {
	 *    a_{i+1} = 2 * a_i
	 *    a_{i+1} = 2 * q_i
	 * }
	 */
	ldn A		/* load -a_0 */
	sto A		/* store -a_0 */
1:
	ldn A		/* load -(-a_i) = +a_i */
	sub B		/* form a_i - (b * 2^n) */
	cmp		/* skip if (a_i - (b * 2^n)) < 0 */
	jmp L3		/* jump to label 3 otherwise */
	ldn A		/* load -(-a_i) = +a_i */
	sto A		/* store +a_i */
	ldn Q		/* load -q_i */
	sub Q		/* form -q_{i+1} = -2 * q_i (left-shift) */
	sto Q		/* store -q_{i+1} */
2:
	ldn A		/* load -a_i */
	sub A		/* form -2 * a_i (left-shift) */
	sto A		/* store -2 * a_i */
	ldn Q		/* load -(-q_{i+1}) = +q_{i+1} */
	sto Q		/* store +q_{i+1} (restore shifted quotient) */
	cmp		/* skip if MSB of q_{i+1} is 1 (done) */
	jmp L1		/* jump to label 1 otherwise (loop) */
	stp		/* halt with result in Q */
3:
	sto A		/* store a_i - (b * 2^n) */
	/* Set LSB d of Q */
	ldn D		/* load -2^d */
	sub Q		/* form -2^d - q_i */
	sub Q		/* form -q_{i+1} = -2^d - 2*q_i (left-shift) */
	sto Q		/* store -q_{i+1} */
	jmp L2		/* jump to label 2 */

	.data
L1:
	.long 1b - 1	/* jump address */
L2:
	.long 2b - 1	/* jump address */
Q:
	.long 0		/* quotient, result */
D:
	/* n is number of bits that B is shifted left to align with A,
	   so d represents the fixed-point position (LSB) of quotient */
	.long 0		/* 2^d for d = 31 - n */
B:
	.long 0		/* divisor multipled by 2^n */
A:
	.long 0		/* initial dividend */
