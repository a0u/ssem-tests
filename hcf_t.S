/*
 * Tootill Highest Common Factor Routine
 * 19 July 1948
 *
 * B. J. Shelburne and C. P. Burton, "Early programs on the Manchester
 * Mark I Prototype," in IEEE Annals of the History of Computing,
 * vol. 20, no. 3, pp. 4-15, July-Sept. 1998.
 */

	.text
	.global _start
L0:
	.long L0	/* jump address */
_start:
	ldn A		/* load -a_i */
	sto A_neg	/* store -a_i */
	ldn B		/* load -b_i */
	sto B		/* store -b_i */
	ldn B		/* load -(-b_i) = +b_i */
	sto A		/* store a_{i+1} = b_i */
	ldn A_neg	/* load -(-a_i) = +a_i */
1:
	sub A		/* decrement b_i */
	cmp		/* test if a_i < (b_i * n) */
2:
	jrp L1		/* jump to label 1 otherwise (loop) */
	sub B		/* add b_i to obtain remainder r_i */
	sto B		/* store b_{i+1} = r_i */
	sub C		/* subtract 2 from r_i */
	cmp		/* test if r_i < 2 (done) */
	jmp L0		/* jump to _start otherwise */
	stp		/* halt when r_i = 0 or r_i = 1 */

	.data
	.skip 10 << 2		/* padding */
L1:
	.long (1b - 2b) - 1	/* jump address */
C:
	.long 2			/* constant */
A_neg:
	.long 0			/* negated A */
A:
	.long 314159265		/* dividend; initial A > B */
B:
	.long 271828182 	/* divisor */
