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

General $L^p$ norm:
#formula-box[
  $ norm(bold(x))_p = (sum_i |x_i|^p)^(1/p), quad p >= 1 $
]

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

// ── PART 4: Identity & Inverse ───────────────────────────────
=== Part 4 — Identity, Inverse, Solving Systems

$ A^(-1) A = I quad bold(A) bold(x) = bold(b) arrow.r.double bold(x) = A^(-1) bold(b) $

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
$ op("diag")(bold(v)) bold(x) = bold(v) ⊙ bold(x) quad op("diag")(bold(v))^(-1) = op("diag")([1\/v_1, dots, 1\/v_n]^top) $

*Symmetric:*
$ A = A^top $

*Orthogonal* (rows AND cols are orthonormal):
#formula-box[
  $ A^top A = A A^top = I quad arrow.r.double quad A^(-1) = A^top $
  Inverting an orthogonal matrix = just transposing it.
]

// ── PART 6: Eigendecomposition ───────────────────────────────
=== Part 6 — Eigendecomposition

#formula-box[
  $ A bold(v) = lambda bold(v) $
  - $bold(v)$ = eigenvector (direction unchanged by $A$, unit length $norm(bold(v))=1$)
  - $lambda$ = eigenvalue (scaling factor)
]

Full decomposition:
$ A = V op("diag")(bold(lambda)) V^(-1) quad V = [bold(v)^((1)), dots, bold(v)^((n))] $

Intuition: *rotate* (by $V$) → *scale* (by $lambda$) → *rotate back* ($V^(-1)$).

For real symmetric matrices: $n$ real eigenvalues, orthogonal eigenvectors → $V^(-1) = V^top$.

Optimization (exam!):
$ max_(norm(bold(x))=1) bold(x)^top A bold(x) arrow.r bold(x) = "eigenvec of max eigenvalue" $
$ min_(norm(bold(x))=1) bold(x)^top A bold(x) arrow.r bold(x) = "eigenvec of min eigenvalue" $

// ── PART 7: SVD ──────────────────────────────────────────────
=== Part 7 — Singular Value Decomposition (SVD)

Works for *any* matrix (generalization of eigendecomposition):
#formula-box[
  $ A = U D V^top $
  - $U$: orthogonal — left singular vectors
  - $D$: diagonal — singular values
  - $V$: orthogonal — right singular vectors
]

// ── PART 8: Pseudoinverse ────────────────────────────────────
=== Part 8 — Moore-Penrose Pseudoinverse

When $A^(-1)$ doesn't exist:
$ A^+ = V D^+ U^top quad (D^+: "reciprocal of each non-zero diagonal") $

#table(
  columns: (auto, auto),
  stroke: 0.5pt + gray,
  inset: 6pt,
  [*Case*], [*Result*],
  [More rows than cols], [Minimises $norm(A bold(x) - bold(b))_2$ (least squares)],
  [More cols than rows], [Minimises $norm(bold(x))_2$ among all solutions],
)

// ── PART 9: Trace ────────────────────────────────────────────
=== Part 9 — Trace

$ op("tr")(A) = sum_i A_(i,i) = sum_i lambda_i $

- $op("tr")(A^top) = op("tr")(A)$
- $op("tr")(A B C) = op("tr")(C A B) = op("tr")(B C A)$ ← cyclic invariant
- $norm(A)_F = sqrt(op("tr")(A A^top))$

// ── PART 10: Determinant ─────────────────────────────────────
=== Part 10 — Determinant

$ det(A) = product_i lambda_i $

- $det(A) = 0$ → singular, not invertible
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
