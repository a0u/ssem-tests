/*
 * Kilburn Highest Common Factor Routine (amended)
 * 18 July 1948
 *
 * B. J. Shelburne and C. P. Burton, "Early programs on the Manchester
 * Mark I Prototype," in IEEE Annals of the History of Computing,
 * vol. 20, no. 3, pp. 4-15, July-Sept. 1998.
 */

	.text
	.global _start
	.long 0		/* unused */
_start:
	ldn B_init	/* load -b_0 */
	sto B_neg	/* store -b_0 */
	ldn B_neg	/* load -(-b_0) = +b_0 */
	sto B_pos	/* store +b_0 */
1:
	ldn A		/* load -(-a) = +a */
2:
	sub B_pos	/* subtract b_i */
	cmp		/* test if (a - b_i) < 0 */
3:
	jrp L2		/* jump to label 2 if non-negative */
	sub B_neg	/* add b_i to obtain r_i */
	sto R		/* store +r_i */
	ldn R		/* load -r_i */
	cmp		/* test if -r_i != 0 */
	stp		/* halt when r_i = 0 */
	ldn B_neg	/* load -(-b_i) = +b_i */
	sub C		/* form b_{i+1} = b_i - 1 */
	sto B_pos	/* store b_{i+1} */
	ldn B_pos	/* load -b_{i+1} */
	sto B_neg	/* store -b_{i+1} */
	jmp L1		/* jump to label 1 */

	.data
L2:
	.long (2b - 3b) - 1	/* jump offset */
C:
	.long 1			/* constant */
L1:
	.long 1b		/* jump address */
A:
	.long -(2 << 18)	/* negated number to factor */
B_init:
	.long (2 << 18) - 1	/* initial trial divisor */
R:
	.long 0			/* remainder */
B_neg:
	.long 0			/* negative trial divisor, result */
B_pos:
	.long 0			/* positive trial divisor */
