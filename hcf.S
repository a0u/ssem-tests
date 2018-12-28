/*
 * Kilburn Highest Common Factor Routine (reconstructed)
 * 21 July 1948 (11:15)
 *
 * First program to run successfully on a stored-program computer
 *
 * B. J. Shelburne and C. P. Burton, "Early programs on the Manchester
 * Mark I Prototype," in IEEE Annals of the History of Computing,
 * vol. 20, no. 3, pp. 4-15, July-Sept. 1998.
 */

	.text
	.global _start
	.long 0		/* unused */
_start:
	ldn Z		/* clear accumulator */
1:
	ldn A		/* load -(-a) = +a */
2:
	sub B		/* perform trial subtraction of b_i */
	cmp		/* test if difference is negative */
3:
	jrp L2		/* jump to label 2 otherwise */
	sub B_neg	/* add b_i to obtain remainder r_i */
	sto R		/* store +r_i */
	ldn B_neg	/* load -(-b_i) = +b_i */
	sub C		/* form b_{i+1} = b_i - 1  */
	sto B		/* store b_{i+1} */
	ldn B		/* load -b_{i+1} */
	sto B_neg	/* store -b_{i+1} */
	ldn R		/* load -r_i */
	cmp		/* test if -r_i < 0 */
	jmp L4		/* jump to label 4 when r_i = 0 (done) */
	jmp C		/* jump to label 1 */
4:
	stp		/* halt with result in B */

	.data
Z:
	.long 0			/* constant */
A:
	.long 31		/* dividend */
B:
	.long 19		/* divisor, result (off-by-one) */
L2:
	.long (2b - 3b) - 1	/* jump offset */
B_neg:
	.long 0			/* negated divisor */
C:
	.long 1			/* constant, jump address */
R:
	.long 0			/* remainder */
L4:
	.long 4b - 1		/* jump address */
