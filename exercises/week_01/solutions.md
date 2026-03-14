# Week 1 — Solutions

**Topic:** Linear Algebra for Deep Learning
**Source:** Deep Learning (Goodfellow, Bengio, Courville) — Lesson 1, Chapter 2

> Only read this after you have genuinely tried the problems!

---

## Exercise 1 — Matrix Products

### (a) C = AB and D = BA

$$A = \begin{bmatrix} 7 & 7 & 0 \\ 8 & 4 & 2 \end{bmatrix} \qquad B = \begin{bmatrix} 7 & 0 \\ 0 & 1 \\ 3 & 8 \end{bmatrix}$$

**C = AB** (shape: 2×3 · 3×2 = 2×2):

| | Col 1 | Col 2 |
|---|---|---|
| Row 1 | $7·7 + 7·0 + 0·3 = 49$ | $7·0 + 7·1 + 0·8 = 7$ |
| Row 2 | $8·7 + 4·0 + 2·3 = 62$ | $8·0 + 4·1 + 2·8 = 20$ |

$$\boxed{C = \begin{bmatrix} 49 & 7 \\ 62 & 20 \end{bmatrix}}$$

**D = BA** (shape: 3×2 · 2×3 = 3×3):

| | Col 1 | Col 2 | Col 3 |
|---|---|---|---|
| Row 1 | $7·7+0·8=49$ | $7·7+0·4=49$ | $7·0+0·2=0$ |
| Row 2 | $0·7+1·8=8$ | $0·7+1·4=4$ | $0·0+1·2=2$ |
| Row 3 | $3·7+8·8=85$ | $3·7+8·4=53$ | $3·0+8·2=16$ |

$$\boxed{D = \begin{bmatrix} 49 & 49 & 0 \\ 8 & 4 & 2 \\ 85 & 53 & 16 \end{bmatrix}}$$

> Note: $C \neq D$ and shapes differ (2×2 vs 3×3) — confirms $AB \neq BA$.

---

### (b) b = Ax

$$\boldsymbol{x} = \begin{bmatrix} 7 \\ 3 \\ 10 \end{bmatrix}$$

- Row 1: $7·7 + 7·3 + 0·10 = 49 + 21 + 0 = 70$
- Row 2: $8·7 + 4·3 + 2·10 = 56 + 12 + 20 = 88$

$$\boxed{\boldsymbol{b} = \begin{bmatrix} 70 \\ 88 \end{bmatrix}}$$

---

### (c) c = h^T A

$$\boldsymbol{h} = \begin{bmatrix} 2 \\ 5 \end{bmatrix} \quad \Rightarrow \quad \boldsymbol{h}^\top = [2, 5]$$

Multiply row vector $[2,5]$ by each column of $A$:

- Col 1: $2·7 + 5·8 = 14 + 40 = 54$
- Col 2: $2·7 + 5·4 = 14 + 20 = 34$
- Col 3: $2·0 + 5·2 = 0 + 10 = 10$

$$\boxed{\boldsymbol{c} = [54,\ 34,\ 10]}$$

---

## Exercise 2 — Inverse of an Orthogonal Matrix

$$A = \frac{1}{3} \begin{bmatrix} 2 & -2 & 1 \\ 1 & 2 & 2 \\ 2 & 1 & -2 \end{bmatrix}$$

### (a) Find A⁻¹

Check if $A$ is orthogonal by verifying $A^\top A = I$. If yes, then $A^{-1} = A^\top$.

$$\boxed{A^{-1} = A^\top = \frac{1}{3} \begin{bmatrix} 2 & 1 & 2 \\ -2 & 2 & 1 \\ 1 & 2 & -2 \end{bmatrix}}$$

### (b) Verification

$$A^{-1} A = \frac{1}{9} \begin{bmatrix} 2 & 1 & 2 \\ -2 & 2 & 1 \\ 1 & 2 & -2 \end{bmatrix} \begin{bmatrix} 2 & -2 & 1 \\ 1 & 2 & 2 \\ 2 & 1 & -2 \end{bmatrix} = \frac{1}{9} \begin{bmatrix} 9 & 0 & 0 \\ 0 & 9 & 0 \\ 0 & 0 & 9 \end{bmatrix} = I \checkmark$$

### (c) Solve Ax = b

$$\boldsymbol{b} = \begin{bmatrix} 1 \\ 1 \\ 3 \end{bmatrix} \qquad \boldsymbol{x} = A^{-1}\boldsymbol{b} = \frac{1}{3} \begin{bmatrix} 2 & 1 & 2 \\ -2 & 2 & 1 \\ 1 & 2 & -2 \end{bmatrix} \begin{bmatrix} 1 \\ 1 \\ 3 \end{bmatrix}$$

- Row 1: $\frac{1}{3}(2·1 + 1·1 + 2·3) = \frac{9}{3} = 3$
- Row 2: $\frac{1}{3}(-2·1 + 2·1 + 1·3) = \frac{3}{3} = 1$
- Row 3: $\frac{1}{3}(1·1 + 2·1 + (-2)·3) = \frac{-3}{3} = -1$

$$\boxed{\boldsymbol{x} = \begin{bmatrix} 3 \\ 1 \\ -1 \end{bmatrix}}$$

---

## Exercise 3 — Lp Norms

$$\boldsymbol{y} = \begin{bmatrix} 4 \\ -3 \end{bmatrix}$$

**p = 1:**
$$\|\boldsymbol{y}\|_1 = |4| + |-3| = \boxed{7}$$

**p = 2:**
$$\|\boldsymbol{y}\|_2 = \sqrt{4^2 + (-3)^2} = \sqrt{16 + 9} = \sqrt{25} = \boxed{5}$$

**p = 3:**
$$\|\boldsymbol{y}\|_3 = \left(|4|^3 + |-3|^3\right)^{1/3} = (64 + 27)^{1/3} = 91^{1/3} \approx \boxed{4.498}$$

---

## Exercise 4 — Moore-Penrose Pseudoinverse via SVD

$$A = \begin{bmatrix} 1 & 2 \\ 1 & 4 \\ 1 & 6 \end{bmatrix} \qquad \boldsymbol{b} = \begin{bmatrix} 1.8 \\ 3.3 \\ 4.1 \end{bmatrix}$$

### (a) Eigenvalues of B = A^T A

$$B = A^\top A = \begin{bmatrix} 3 & 12 \\ 12 & 56 \end{bmatrix}$$

$$\boxed{\lambda_1 = 58.5904 \qquad \lambda_2 = 0.4096}$$

### (b) Matrix D

$$\boxed{D = \begin{bmatrix} \sqrt{58.5904} & 0 \\ 0 & \sqrt{0.4096} \\ 0 & 0 \end{bmatrix} = \begin{bmatrix} 7.6544 & 0 \\ 0 & 0.6400 \\ 0 & 0 \end{bmatrix}}$$

### (c) Matrix V (eigenvectors of B = A^T A)

$$\boxed{V = \begin{bmatrix} -0.2110 & -0.9775 \\ -0.9775 & 0.2110 \end{bmatrix}}$$

where $\boldsymbol{v}^{(1)} = [-0.2110,\ -0.9775]^\top$ (for $\lambda_1$) and $\boldsymbol{v}^{(2)} = [-0.9775,\ 0.2110]^\top$ (for $\lambda_2$).

### (d) Matrix U (eigenvectors of C = AA^T)

$$C = AA^\top = \begin{bmatrix} 5 & 9 & 13 \\ 9 & 17 & 25 \\ 13 & 25 & 37 \end{bmatrix}$$

Eigenvalues: $\lambda_1 = 58.5904$, $\lambda_2 = 0.4096$, $\lambda_3 = 0$

$$\boxed{U = \begin{bmatrix} -0.2830 & -0.8679 & 0.4082 \\ -0.5384 & -0.2085 & -0.8165 \\ -0.7938 & 0.4508 & 0.4082 \end{bmatrix}}$$

### (e) Verification

$$UU^\top = I_{3\times3} \checkmark \qquad VV^\top = I_{2\times2} \checkmark \qquad UDV^\top = A \checkmark$$

### (f) Matrix D^+

Take reciprocal of each non-zero diagonal, then transpose:

$$\boxed{D^+ = \begin{bmatrix} \frac{1}{7.6544} & 0 & 0 \\ 0 & \frac{1}{0.6400} & 0 \end{bmatrix} = \begin{bmatrix} 0.1306 & 0 & 0 \\ 0 & 1.5625 & 0 \end{bmatrix}}$$

### (g) Pseudoinverse A^+

$$A^+ = VD^+U^\top$$

$$\boxed{A^+ = \begin{bmatrix} 4/3 & 1/3 & -2/3 \\ -1/4 & 0 & 1/4 \end{bmatrix}}$$

### (h) Least-squares solution x = A^+ b

$$\boldsymbol{x} = \begin{bmatrix} 4/3 & 1/3 & -2/3 \\ -1/4 & 0 & 1/4 \end{bmatrix} \begin{bmatrix} 1.8 \\ 3.3 \\ 4.1 \end{bmatrix}$$

- Row 1: $\frac{4}{3}(1.8) + \frac{1}{3}(3.3) + (-\frac{2}{3})(4.1) = 2.4 + 1.1 - 2.733 = 0.767$
- Row 2: $-\frac{1}{4}(1.8) + 0(3.3) + \frac{1}{4}(4.1) = -0.45 + 1.025 = 0.575$

$$\boxed{\boldsymbol{x} = \begin{bmatrix} 0.767 \\ 0.575 \end{bmatrix}}$$

This is the **least-squares solution** — it minimises $\|A\boldsymbol{x} - \boldsymbol{b}\|_2$ since the system is overdetermined (no exact solution exists).
