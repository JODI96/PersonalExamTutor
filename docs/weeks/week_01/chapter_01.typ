// ============================================================
// Week 1 — Chapter 1: Linear Algebra for Deep Learning
// Topics: Scalars, Vectors, Matrices, Tensors + all operations
// Date: 2026-03-14
// PDF: pdfs/week_01/DL_L01b_LinearAlgebra.pdf
// ============================================================

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

== Chapter 1: Linear Algebra for Deep Learning

// ── PART 1: Building Blocks ──────────────────────────────────
=== Part 1 — The Building Blocks

#formula-box[
  #table(
    columns: (auto, auto, auto, auto),
    stroke: none,
    inset: 6pt,
    [*Type*], [*Dims*], [*Notation*], [*Example*],
    [Scalar], [0D], [$a$], [single loss value],
    [Vector], [1D], [$bold(x)$ — always column], [$[1,2,3]^top$],
    [Matrix], [2D], [$bold(A)$, element $A_(i,j)$], [weight layer],
    [Tensor], [3D+], [$bold(A)$, element $A_(i,j,k)$], [image batch],
  )
]

Column vector and matrix notation:
$ bold(x) = mat(x_1; x_2; dots.v; x_n) quad bold(A) = mat(A_(1,1), A_(1,2); A_(2,1), A_(2,2); A_(3,1), A_(3,2)) $

// ── PART 2: Operations ───────────────────────────────────────
=== Part 2 — Operations

*Matrix addition* (same size only):
- _Used for:_ combining two sets of features, adding residuals in ResNets
$ C_(i,j) = A_(i,j) + B_(i,j) $
$ mat(1,2;3,4) + mat(5,6;7,8) = mat(6,8;10,12) $

*Scalar on matrix* ($a$ = scale, $c$ = bias/shift):
- _Used for:_ normalising data, applying a weight + bias to a whole layer
$ D_(i,j) = a dot B_(i,j) + c $
$ 2 dot mat(1,2;3,4) + 10 = mat(12,14;16,18) quad arrow.r "every element ×2, then +10" $

*Broadcasting* (vector added to every column of matrix):
- _Used for:_ adding a bias vector to an entire batch of inputs at once
$ C_(i,j) = A_(i,j) + b_j $
$ mat(1,2;3,4;5,6) + mat(10;20) = mat(11,22;13,24;15,26) $

*Matrix multiplication:*
- _Used for:_ the core forward pass — transforming inputs through a weight layer: $bold(y) = W bold(x)$
#formula-box[
  $ bold(C) = bold(A) bold(B) quad C_(i,j) = sum_k A_(i,k) dot B_(k,j) $
  Shape: $(m times k) dot (k times n) = (m times n)$ — inner dims must match.

  $ mat(1,2;3,4) mat(5,6;7,8) = mat(19,22;43,50) $
]

*Inner / dot product* (vectors only, result is a scalar):
- _Used for:_ measuring similarity between two vectors; attention scores in Transformers
$ bold(x)^top bold(y) = sum_i x_i y_i = norm(bold(x))_2 norm(bold(y))_2 cos theta $
$ mat(1,2,3) mat(4;5;6) = 1 dot 4 + 2 dot 5 + 3 dot 6 = 32 $

*Hadamard (element-wise) product:*
- _Used for:_ gating mechanisms (LSTM, GRU), applying masks, dropout
$ bold(C) = bold(A) ⊙ bold(B) quad C_(i,j) = A_(i,j) dot B_(i,j) $
$ mat(1,2;3,4) ⊙ mat(5,6;7,8) = mat(5,12;21,32) $

*Properties of matrix multiplication:*
- Distributive: $A(B+C) = A B + A C$
- Associative: $A(B C) = (A B)C$

#warn-box[$A B eq.not B A$ — matrix multiplication is *NOT commutative*. This is on every exam.]

*Transpose:*
- _Used for:_ converting column↔row vectors, computing dot products ($bold(x)^top bold(y)$), flipping weight matrices in backpropagation
$ (A^top)_(i,j) = A_(j,i) quad (A B)^top = B^top A^top $
$ mat(1,2,3;4,5,6)^top = mat(1,4;2,5;3,6) quad arrow.r "(2 times 3) becomes (3 times 2)" $

// ── PART 3: Norms ────────────────────────────────────────────
=== Part 3 — Norms

- _Used for:_ measuring magnitude of weights, gradients, errors; regularisation (L1/L2); comparing vectors

General $L^p$ norm:
#formula-box[
  $ norm(bold(x))_p = (sum_i |x_i|^p)^(1/p), quad p >= 1 $
]

Example with $bold(x) = [3, -4]^top$:
$ norm(bold(x))_1 = 3+4 = 7 quad norm(bold(x))_2 = sqrt(9+16) = 5 quad norm(bold(x))_infinity = 4 $

#table(
  columns: (auto, auto, auto),
  stroke: 0.5pt + gray,
  inset: 6pt,
  [*Norm*], [*Formula*], [*Use*],
  [$L^2$ (Euclidean)], [$norm(bold(x))_2 = sqrt(sum_i x_i^2)$], [most common],
  [Squared $L^2$], [$norm(bold(x))_2^2 = bold(x)^top bold(x)$], [easier to compute],
  [$L^1$], [$norm(bold(x))_1 = sum_i |x_i|$], [sparsity],
  [$L^0$], [count of non-zeros], [*not a true norm*],
  [$L^infinity$], [$norm(bold(x))_infinity = max_i |x_i|$], [max element],
  [Frobenius], [$norm(A)_F = sqrt(sum_(i,j) A_(i,j)^2) = sqrt(op("tr")(A A^top))$], [matrix size],
)

// ── PART 3.5: A vs A^T vs A^-1 ──────────────────────────────
=== Quick Reference — $A$ vs $A^top$ vs $A^(-1)$

#formula-box[
  #table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt + gray,
    inset: 8pt,
    [*Notation*], [*Name*], [*What it does*], [*How it looks*],
    [$A$],
    [Original matrix],
    [Transforms input],
    [unchanged],
    [$A^top$],
    [Transpose],
    [Swaps rows and columns],
    [$(A^top)_(i,j) = A_(j,i)$],
    [$A^(-1)$],
    [Inverse],
    [Undoes $A$ — like dividing],
    [$A^(-1) A = I$],
  )
]

Starting with the same matrix $A$:
$ A = mat(1,2;3,4) $

*Transpose* $A^top$ — flip across diagonal (rows become columns):
$ A^top = mat(1,3;2,4) quad arrow.r "row 1" [1,2] "becomes col 1" mat(1;2) $

*Inverse* $A^(-1)$ — the "undo" matrix, found by calculation (not just flipping!):
$ A^(-1) = mat(-2, 1; 3\/2, -1\/2) quad arrow.r A^(-1) A = mat(1,0;0,1) = I $

*Special case — Orthogonal matrix:* transpose = inverse ($A^top = A^(-1)$) \
→ only works because orthogonal matrices purely rotate (no stretching).

#warn-box[
  $A^top$ is always easy — just flip. \
  $A^(-1)$ requires real computation — unless $A$ is orthogonal (then $A^(-1) = A^top$ for free).
]

// ── PART 4: Identity & Inverse ───────────────────────────────
=== Part 4 — Identity, Inverse, Solving Systems

- _Used for:_ solving systems of equations $A bold(x) = bold(b)$; finding model parameters given data

$ A^(-1) A = I quad bold(A) bold(x) = bold(b) arrow.r.double bold(x) = A^(-1) bold(b) $

Example — solve $A bold(x) = bold(b)$:
$ A = mat(2,0;0,4) quad bold(b) = mat(6;8) quad arrow.r A^(-1) = mat(1\/2,0;0,1\/4) quad arrow.r bold(x) = mat(3;2) $

*How to compute $A^(-1)$ — 2×2 formula (exam):*

#formula-box[
  $ A = mat(a,b;c,d) quad arrow.r.double quad A^(-1) = frac(1, det(A)) mat(d,-b;-c,a) quad "where" det(A) = a d - b c $

  Steps: ① swap $a$ and $d$ on diagonal ② flip signs of $b$ and $c$ ③ divide by $det(A)$
]

Example:
$ A = mat(1,2;3,4) arrow.r det(A) = 1 dot 4 - 2 dot 3 = -2 arrow.r A^(-1) = frac(1,-2) mat(4,-2;-3,1) = mat(-2,1;3\/2,-1\/2) $

Verify: $A^(-1) A = mat(-2,1;3\/2,-1\/2) mat(1,2;3,4) = mat(1,0;0,1) = I checkmark$

#warn-box[If $det(A) = a d - b c = 0$ → division by zero → *no inverse exists* (singular matrix).]

*For larger matrices:* use Gauss-Jordan — write $[A | I]$, row-reduce until left side = $I$, right side becomes $A^(-1)$.

$A^(-1)$ exists only if: $A$ is square AND columns are linearly independent (non-singular).

#table(
  columns: (auto, auto),
  stroke: 0.5pt + gray,
  inset: 6pt,
  [*Situation*], [*Solutions*],
  [$m > n$ (overdetermined)], [None (generically)],
  [$m < n$ (underdetermined)], [Infinitely many],
  [$m = n$, independent cols], [*Exactly one*],
)

// ── PART 5: Special Matrices ─────────────────────────────────
=== Part 5 — Special Matrices

*Diagonal:*
- _Used for:_ efficient scaling; eigenvalue matrices in decompositions; fast inversion
$ op("diag")(bold(v)) bold(x) = bold(v) ⊙ bold(x) quad op("diag")(bold(v))^(-1) = op("diag")([1\/v_1, dots, 1\/v_n]^top) $
$ op("diag")(mat(2;3;4)) bold(x) = mat(2,0,0;0,3,0;0,0,4) mat(x_1;x_2;x_3) = mat(2x_1;3x_2;4x_3) quad arrow.r "same as" mat(2;3;4) ⊙ bold(x) $

*Symmetric:*
- _Used for:_ covariance matrices, distance matrices, any matrix of pairwise values
$ A = A^top $
$ mat(1,2,3;2,5,4;3,4,6) = mat(1,2,3;2,5,4;3,4,6)^top quad arrow.r "mirrored across diagonal" $

*Orthogonal* (rows AND cols are orthonormal):
- _Used for:_ rotation matrices, $V$ and $U$ in SVD, efficient inversion (just transpose)

#warn-box[
  *Symmetric $eq.not$ Orthogonal* — completely different properties! \
  Symmetric: $A = A^top$ (mirrored across diagonal). \
  Orthogonal: $A^top A = I$ (columns perpendicular + unit length). A matrix can be orthogonal without looking symmetric at all.
]

*How to check if a matrix is orthogonal* — verify two conditions on every column:
+ *Unit length:* $norm(bold(c)_i)_2 = 1$ — each column has length 1
+ *Perpendicular:* $bold(c)_i^top bold(c)_j = 0$ for all $i eq.not j$ — every pair of columns is at 90°

If both hold → orthogonal → use $A^(-1) = A^top$ (free inverse, no computation).

Example — check col 1 and col 2 of $A = frac(1,3) mat(2,-2,1;1,2,2;2,1,-2)$:

First, extract the columns (each column = one vertical slice of the matrix):
$ bold(c)_1 = frac(1,3) mat(2;1;2) quad bold(c)_2 = frac(1,3) mat(-2;2;1) quad bold(c)_3 = frac(1,3) mat(1;2;-2) $

*Check unit length* — square each element, sum them, take the square root. Must equal 1:
$ norm(bold(c)_1)_2 = sqrt((frac(2,3))^2 + (frac(1,3))^2 + (frac(2,3))^2) = sqrt(frac(4,9) + frac(1,9) + frac(4,9)) = sqrt(frac(9,9)) = sqrt(1) = 1 checkmark $

*Check perpendicular* — dot product = multiply matching elements, then sum. Must equal 0:
$ bold(c)_1^top bold(c)_2 = frac(2,3) dot frac(-2,3) + frac(1,3) dot frac(2,3) + frac(2,3) dot frac(1,3) $
$ = frac(-4,9) + frac(2,9) + frac(2,9) = frac(-4+2+2,9) = frac(0,9) = 0 checkmark $

Same check for every other pair: $bold(c)_1^top bold(c)_3 = 0$ and $bold(c)_2^top bold(c)_3 = 0$ (verify yourself!).

#formula-box[
  $ A^top A = A A^top = I quad arrow.r.double quad A^(-1) = A^top $
  Inverting an orthogonal matrix = just transposing it — no computation needed.
]

// ── PART 6: Eigendecomposition ───────────────────────────────
=== Part 6 — Eigendecomposition

- _Used for:_ understanding what a matrix does geometrically; PCA; finding principal directions of data; quadratic optimisation

#formula-box[
  $ A bold(v) = lambda bold(v) $
  - $bold(v)$ = eigenvector (direction unchanged by $A$, unit length $norm(bold(v))=1$)
  - $lambda$ = eigenvalue (scaling factor along that direction)
]

*How to compute eigenvalues* — solve the characteristic equation $det(A - lambda I) = 0$:

#formula-box[
  *Step 1:* Subtract $lambda$ from every diagonal element → get $A - lambda I$

  *Step 2:* Compute $det(A - lambda I) = 0$ → gives a polynomial in $lambda$

  *Step 3:* Solve for $lambda$ using the quadratic formula (for 2×2):
  $ lambda = frac(-b plus.minus sqrt(b^2 - 4 a c), 2 a) $
]

Example — find eigenvalues of $B = mat(3,12;12,56)$:
$ "Step 1:" quad B - lambda I = mat(3-lambda, 12; 12, 56-lambda) $
$ "Step 2:" quad det = (3-lambda)(56-lambda) - 12 dot 12 = lambda^2 - 59 lambda + 24 = 0 $
$ "Step 3:" quad lambda = frac(59 plus.minus sqrt(59^2 - 4 dot 24), 2) = frac(59 plus.minus sqrt(3385), 2) arrow.r lambda_1 approx 58.59, quad lambda_2 approx 0.41 $

Example — $A = mat(3,1;1,3)$ has eigenvalues $lambda_1=4, lambda_2=2$:
$ A mat(1;1) = mat(4;4) = 4 mat(1;1) quad arrow.r "direction" [1,1]^top "scaled by 4" $
$ A mat(1;-1) = mat(2;-2) = 2 mat(1;-1) quad arrow.r "direction" [1,-1]^top "scaled by 2" $

Full decomposition:
$ A = V op("diag")(bold(lambda)) V^(-1) quad V = [bold(v)^((1)), dots, bold(v)^((n))] $

Intuition: *rotate* (by $V$) → *scale* (by $lambda$) → *rotate back* ($V^(-1)$).

For real symmetric matrices: $n$ real eigenvalues, orthogonal eigenvectors → $V^(-1) = V^top$.

Optimization (exam!):
$ max_(norm(bold(x))=1) bold(x)^top A bold(x) arrow.r bold(x) = "eigenvec of max eigenvalue" $
$ min_(norm(bold(x))=1) bold(x)^top A bold(x) arrow.r bold(x) = "eigenvec of min eigenvalue" $

// ── PART 7: SVD ──────────────────────────────────────────────
=== Part 7 — Singular Value Decomposition (SVD)

- _Used for:_ pseudoinverse, data compression, dimensionality reduction (PCA), recommender systems, solving any linear system

Works for *any* matrix (generalization of eigendecomposition):
#formula-box[
  $ A = U D V^top $
  - $U$: orthogonal — left singular vectors (output directions)
  - $D$: diagonal — singular values (how much each direction is stretched)
  - $V$: orthogonal — right singular vectors (input directions)
]

*How to build $D$* — take the square roots of the eigenvalues of $A^top A$, put them on the diagonal in descending order. Shape of $D$ = same shape as $A$:

#formula-box[
  $ lambda_1 >= lambda_2 >= dots arrow.r D = mat(sqrt(lambda_1), 0, dots; 0, sqrt(lambda_2), dots; dots.v, dots.v, dots.down) quad "same shape as" A $

  Extra rows or columns → filled with zeros.
]

Example — $A$ is $3 times 2$, eigenvalues $lambda_1=58.59$, $lambda_2=0.41$:
$ D = mat(sqrt(58.59), 0; 0, sqrt(0.41); 0, 0) = mat(7.65, 0; 0, 0.64; 0, 0) quad (3 times 2, "same as" A) $

*How to build $V$* — eigenvectors of $A^top A$, stacked as columns, in same order as eigenvalues:
$ V = [bold(v)^((1)) | bold(v)^((2)) | dots] quad arrow.r "col 1 = eigenvec of" lambda_1, "col 2 = eigenvec of" lambda_2, dots $

Example — eigenvalues $lambda_1=58.59$, $lambda_2=0.41$ give eigenvectors $bold(v)^((1))$ and $bold(v)^((2))$:
$ V = mat(-0.211, -0.977; -0.977, 0.211) quad (2 times 2 "since" A "has 2 columns") $

*How to build $U$* — eigenvectors of $A A^top$, stacked as columns, same eigenvalue order. Shape = $m times m$ where $m$ = rows of $A$:
$ U = [bold(u)^((1)) | bold(u)^((2)) | dots | bold(u)^((m))] $

Example — $A$ is $3 times 2$ so $A A^top$ is $3 times 3$ → $U$ is $3 times 3$. Eigenvalues: $lambda_1=58.59$, $lambda_2=0.41$, $lambda_3=0$:
$ U = mat(-0.283, -0.868, 0.408; -0.538, -0.208, -0.816; -0.794, 0.451, 0.408) $

#tip-box[
  *Summary — how to get each piece of SVD $A = U D V^top$:*
  - $V$: eigenvectors of $A^top A$ as columns (size: $n times n$)
  - $D$: $sqrt(lambda_i)$ on diagonal, same shape as $A$ (size: $m times n$)
  - $U$: eigenvectors of $A A^top$ as columns (size: $m times m$)
  Always in descending eigenvalue order.
]

For a general matrix the singular values in $D$ tell you how much the matrix stretches space in each direction — largest first.

// ── PART 8: Pseudoinverse ────────────────────────────────────
=== Part 8 — Moore-Penrose Pseudoinverse

- _Used for:_ least-squares regression, solving overdetermined systems (more equations than unknowns); any time a true inverse doesn't exist

When $A^(-1)$ doesn't exist:
$ A^+ = V D^+ U^top quad (D^+: "reciprocal of each non-zero diagonal of D") $

Example — $D = mat(3,0;0,2;0,0)$ → $D^+ = mat(1\/3,0,0;0,1\/2,0)$

#table(
  columns: (auto, auto),
  stroke: 0.5pt + gray,
  inset: 6pt,
  [*Case*], [*Result*],
  [More rows than cols (overdetermined)], [Minimises $norm(A bold(x) - bold(b))_2$ (least squares)],
  [More cols than rows (underdetermined)], [Minimises $norm(bold(x))_2$ among all solutions],
)

// ── PART 9: Trace ────────────────────────────────────────────
=== Part 9 — Trace

- _Used for:_ computing Frobenius norm, simplifying matrix derivative expressions, checking eigenvalue sums

$ op("tr")(A) = sum_i A_(i,i) = sum_i lambda_i $

Example:
$ op("tr")(mat(1,9,7;2,5,3;4,6,8)) = 1+5+8 = 14 $

- $op("tr")(A^top) = op("tr")(A)$
- $op("tr")(A B C) = op("tr")(C A B) = op("tr")(B C A)$ ← cyclic invariant
- $norm(A)_F = sqrt(op("tr")(A A^top))$

// ── PART 10: Determinant ─────────────────────────────────────
=== Part 10 — Determinant

- _Used for:_ checking if a matrix is invertible; measuring volume scaling; appears in probability density formulas (multivariate Gaussian)

$ det(A) = product_i lambda_i $

Example:
$ det(mat(3,1;1,3)) = 3 dot 3 - 1 dot 1 = 8 quad arrow.r lambda_1 dot lambda_2 = 4 dot 2 = 8 checkmark $

- $det(A) = 0$ → singular, not invertible (at least one eigenvalue is zero)
- $det(A) eq.not 0$ → invertible
- Geometric meaning: factor by which $A$ scales volume

// ── CHEAT SHEET ──────────────────────────────────────────────
=== Cheat Sheet

#cheat-box[
  *WEEK 1 — LINEAR ALGEBRA CHEAT SHEET*

  #v(0.4em)

  *Structures:* scalar=0D · vector=1D(col) · matrix=2D · tensor=3D+

  *Multiply:*
  - Standard: $C_(i,j) = sum_k A_(i,k) B_(k,j)$
  - Dot product: $bold(x)^top bold(y) = norm(bold(x)) norm(bold(y)) cos theta$
  - Hadamard $⊙$: $C_(i,j) = A_(i,j) B_(i,j)$
  - $A B eq.not B A$ — NEVER commutative

  *Norms:* $L^2 = sqrt(sum x^2)$ · $L^1 = sum|x|$ · $L^infinity = max|x|$ · $norm(A)_F = sqrt(op("tr")(A A^top))$

  *Special:* Symmetric $A=A^top$ · Orthogonal $A^(-1)=A^top$ · Diagonal: invert = reciprocal diagonal

  *Eigen:* $A bold(v) = lambda bold(v)$ → $A = V op("diag")(lambda) V^(-1)$

  *SVD:* $A = U D V^top$ (always works)

  *Pseudoinverse:* $A^+ = V D^+ U^top$

  *Trace:* $op("tr")(A) = sum A_(i,i) = sum lambda_i$ (cyclic invariant)

  *Det:* $det(A) = product lambda_i$ · zero = singular = not invertible
]
