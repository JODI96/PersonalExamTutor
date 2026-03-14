# Week 1 — Solutions

**Topic:** Linear Algebra for Deep Learning
**Source:** Deep Learning (Goodfellow, Bengio, Courville) — Lesson 1, Chapter 2

> Only read this after you have genuinely tried the problems!

---

## Exercise 1 — Matrix Products

### (a) C = AB and D = BA

$$A = \begin{bmatrix} 7 & 7 & 0 \\ 8 & 4 & 2 \end{bmatrix} \quad (2\times3) \qquad B = \begin{bmatrix} 7 & 0 \\ 0 & 1 \\ 3 & 8 \end{bmatrix} \quad (3\times2)$$

**Step 1 — Check shapes.**
$A$ is $2\times3$, $B$ is $3\times2$ → $C = AB$ will be $2\times2$. Inner dims match (both 3). ✓

**Step 2 — Compute C = AB** (row of A · column of B):

$$C_{1,1} = 7{\cdot}7 + 7{\cdot}0 + 0{\cdot}3 = 49 + 0 + 0 = 49$$
$$C_{1,2} = 7{\cdot}0 + 7{\cdot}1 + 0{\cdot}8 = 0 + 7 + 0 = 7$$
$$C_{2,1} = 8{\cdot}7 + 4{\cdot}0 + 2{\cdot}3 = 56 + 0 + 6 = 62$$
$$C_{2,2} = 8{\cdot}0 + 4{\cdot}1 + 2{\cdot}8 = 0 + 4 + 16 = 20$$

$$\boxed{C = \begin{bmatrix} 49 & 7 \\ 62 & 20 \end{bmatrix}}$$

**Step 3 — Compute D = BA** — now $B$ is $3\times2$ and $A$ is $2\times3$ → $D$ will be $3\times3$:

$$D_{1,1} = 7{\cdot}7 + 0{\cdot}8 = 49 \qquad D_{1,2} = 7{\cdot}7 + 0{\cdot}4 = 49 \qquad D_{1,3} = 7{\cdot}0 + 0{\cdot}2 = 0$$
$$D_{2,1} = 0{\cdot}7 + 1{\cdot}8 = 8 \qquad D_{2,2} = 0{\cdot}7 + 1{\cdot}4 = 4 \qquad D_{2,3} = 0{\cdot}0 + 1{\cdot}2 = 2$$
$$D_{3,1} = 3{\cdot}7 + 8{\cdot}8 = 21+64 = 85 \qquad D_{3,2} = 3{\cdot}7 + 8{\cdot}4 = 21+32 = 53 \qquad D_{3,3} = 3{\cdot}0 + 8{\cdot}2 = 16$$

$$\boxed{D = \begin{bmatrix} 49 & 49 & 0 \\ 8 & 4 & 2 \\ 85 & 53 & 16 \end{bmatrix}}$$

> $C$ is $2\times2$, $D$ is $3\times3$ — different shapes, completely different results. This confirms $AB \neq BA$.

---

### (b) b = Ax

$$\mathbf{x} = \begin{bmatrix} 7 \\ 3 \\ 10 \end{bmatrix}$$

**Step 1 — Check shapes.** $A$ is $2\times3$, $\mathbf{x}$ is $3\times1$ → result $\mathbf{b}$ will be $2\times1$. ✓

**Step 2 — Multiply each row of A by x** (dot product of row with column vector):

$$b_1 = 7{\cdot}7 + 7{\cdot}3 + 0{\cdot}10 = 49 + 21 + 0 = 70$$
$$b_2 = 8{\cdot}7 + 4{\cdot}3 + 2{\cdot}10 = 56 + 12 + 20 = 88$$

$$\boxed{\mathbf{b} = \begin{bmatrix} 70 \\ 88 \end{bmatrix}}$$

---

### (c) c = h^T A

$$\mathbf{h} = \begin{bmatrix} 2 \\ 5 \end{bmatrix}$$

**Step 1 — Transpose h.** $\mathbf{h}^\top = [2,\ 5]$ — now a $1\times2$ row vector.

**Step 2 — Check shapes.** $\mathbf{h}^\top$ is $1\times2$, $A$ is $2\times3$ → result $\mathbf{c}$ will be $1\times3$ (a row vector). ✓

**Step 3 — Multiply row vector by each column of A:**

$$c_1 = 2{\cdot}7 + 5{\cdot}8 = 14 + 40 = 54$$
$$c_2 = 2{\cdot}7 + 5{\cdot}4 = 14 + 20 = 34$$
$$c_3 = 2{\cdot}0 + 5{\cdot}2 = 0 + 10 = 10$$

$$\boxed{\mathbf{c} = [54,\ 34,\ 10]}$$

---

## Exercise 2 — Inverse of an Orthogonal Matrix

$$A = \frac{1}{3} \begin{bmatrix} 2 & -2 & 1 \\ 1 & 2 & 2 \\ 2 & 1 & -2 \end{bmatrix}$$

### (a) Find A⁻¹

**Step 1 — Check if A is orthogonal** by testing $A^\top A = I$.

An orthogonal matrix has mutually orthonormal columns (perpendicular + unit length).
For this matrix, check each pair of columns is orthogonal and each column has unit length:

Column 1 · Column 2: $\frac{1}{9}(2{\cdot}(-2) + 1{\cdot}2 + 2{\cdot}1) = \frac{1}{9}(-4+2+2) = 0$ ✓

Column 1 length: $\frac{1}{3}\sqrt{2^2+1^2+2^2} = \frac{1}{3}\sqrt{9} = 1$ ✓

**Step 2 — Apply the rule:** for orthogonal matrices, $A^{-1} = A^\top$ (just transpose).

$$A^\top = \frac{1}{3} \begin{bmatrix} 2 & 1 & 2 \\ -2 & 2 & 1 \\ 1 & 2 & -2 \end{bmatrix}$$

$$\boxed{A^{-1} = \frac{1}{3} \begin{bmatrix} 2 & 1 & 2 \\ -2 & 2 & 1 \\ 1 & 2 & -2 \end{bmatrix}}$$

### (b) Verification — check A⁻¹ · A = I

$$A^{-1} A = \frac{1}{9} \begin{bmatrix} 2 & 1 & 2 \\ -2 & 2 & 1 \\ 1 & 2 & -2 \end{bmatrix} \begin{bmatrix} 2 & -2 & 1 \\ 1 & 2 & 2 \\ 2 & 1 & -2 \end{bmatrix}$$

Computing element by element:

$$[1,1]: \frac{1}{9}(2{\cdot}2 + 1{\cdot}1 + 2{\cdot}2) = \frac{9}{9} = 1$$
$$[1,2]: \frac{1}{9}(2{\cdot}(-2) + 1{\cdot}2 + 2{\cdot}1) = \frac{0}{9} = 0$$
$$[2,1]: \frac{1}{9}((-2){\cdot}2 + 2{\cdot}1 + 1{\cdot}2) = \frac{0}{9} = 0$$
$$[2,2]: \frac{1}{9}((-2){\cdot}(-2) + 2{\cdot}2 + 1{\cdot}1) = \frac{9}{9} = 1$$
$$[3,3]: \frac{1}{9}(1{\cdot}1 + 2{\cdot}2 + (-2){\cdot}(-2)) = \frac{9}{9} = 1$$

$$A^{-1}A = I \checkmark$$

### (c) Solve Ax = b

$$\mathbf{b} = \begin{bmatrix} 1 \\ 1 \\ 3 \end{bmatrix}$$

**Step 1 — Apply:** $\mathbf{x} = A^{-1}\mathbf{b}$

$$\mathbf{x} = \frac{1}{3} \begin{bmatrix} 2 & 1 & 2 \\ -2 & 2 & 1 \\ 1 & 2 & -2 \end{bmatrix} \begin{bmatrix} 1 \\ 1 \\ 3 \end{bmatrix}$$

**Step 2 — Compute each row:**

$$x_1 = \frac{1}{3}(2{\cdot}1 + 1{\cdot}1 + 2{\cdot}3) = \frac{1}{3}(2+1+6) = \frac{9}{3} = 3$$
$$x_2 = \frac{1}{3}((-2){\cdot}1 + 2{\cdot}1 + 1{\cdot}3) = \frac{1}{3}(-2+2+3) = \frac{3}{3} = 1$$
$$x_3 = \frac{1}{3}(1{\cdot}1 + 2{\cdot}1 + (-2){\cdot}3) = \frac{1}{3}(1+2-6) = \frac{-3}{3} = -1$$

$$\boxed{\mathbf{x} = \begin{bmatrix} 3 \\ 1 \\ -1 \end{bmatrix}}$$

**Step 3 — Verify:** $A\mathbf{x} = \mathbf{b}$?

$$\frac{1}{3}\begin{bmatrix}2&-2&1\\1&2&2\\2&1&-2\end{bmatrix}\begin{bmatrix}3\\1\\-1\end{bmatrix} = \frac{1}{3}\begin{bmatrix}6-2-1\\3+2-2\\6+1+2\end{bmatrix} = \frac{1}{3}\begin{bmatrix}3\\3\\9\end{bmatrix} = \begin{bmatrix}1\\1\\3\end{bmatrix} = \mathbf{b} \checkmark$$

---

## Exercise 3 — Lp Norms

$$\mathbf{y} = \begin{bmatrix} 4 \\ -3 \end{bmatrix}$$

**General formula:** $\|\mathbf{y}\|_p = \left(\sum_i |y_i|^p\right)^{1/p}$

**Note:** always take absolute values first — signs disappear.

**p = 1** (sum of absolute values):
$$\|\mathbf{y}\|_1 = |4| + |-3| = 4 + 3 = \boxed{7}$$

**p = 2** (Euclidean length — most common):
$$\|\mathbf{y}\|_2 = \sqrt{|4|^2 + |-3|^2} = \sqrt{16 + 9} = \sqrt{25} = \boxed{5}$$

> Geometric interpretation: $\mathbf{y}$ is the hypotenuse of a 3-4-5 right triangle.

**p = 3:**
$$\|\mathbf{y}\|_3 = \left(|4|^3 + |-3|^3\right)^{1/3} = (64 + 27)^{1/3} = 91^{1/3} \approx \boxed{4.498}$$

> Pattern: as $p$ increases, the norm gets closer to $L^\infty = \max(4,3) = 4$.

---

## Exercise 4 — Moore-Penrose Pseudoinverse via SVD

$$A = \begin{bmatrix} 1 & 2 \\ 1 & 4 \\ 1 & 6 \end{bmatrix} \quad (3\times2) \qquad \mathbf{b} = \begin{bmatrix} 1.8 \\ 3.3 \\ 4.1 \end{bmatrix}$$

**Why pseudoinverse?** $A$ is $3\times2$ (more rows than cols = overdetermined). No exact solution to $A\mathbf{x}=\mathbf{b}$ exists, so we find the best approximation via $A^+ = VD^+U^\top$.

---

### (a) Eigenvalues of B = A^T A

**Step 1 — Compute $B = A^\top A$:**

$$B = \begin{bmatrix}1&1&1\\2&4&6\end{bmatrix}\begin{bmatrix}1&2\\1&4\\1&6\end{bmatrix} = \begin{bmatrix}1+1+1 & 2+4+6\\2+4+6 & 4+16+36\end{bmatrix} = \begin{bmatrix}3&12\\12&56\end{bmatrix}$$

**Step 2 — Characteristic equation** $\det(B - \lambda I) = 0$:

$$(3-\lambda)(56-\lambda) - 12{\cdot}12 = 0$$
$$\lambda^2 - 59\lambda + (168 - 144) = 0$$
$$\lambda^2 - 59\lambda + 24 = 0$$

**Step 3 — Quadratic formula:**

$$\lambda = \frac{59 \pm \sqrt{59^2 - 4{\cdot}24}}{2} = \frac{59 \pm \sqrt{3481 - 96}}{2} = \frac{59 \pm \sqrt{3385}}{2} \approx \frac{59 \pm 58.18}{2}$$

$$\boxed{\lambda_1 = 58.5904 \qquad \lambda_2 = 0.4096}$$

---

### (b) Matrix D

**Rule:** $D$ contains the square roots of the eigenvalues of $B = A^\top A$ on its diagonal, with the same shape as $A$ (here $3\times2$):

$$\boxed{D = \begin{bmatrix}\sqrt{58.5904}&0\\0&\sqrt{0.4096}\\0&0\end{bmatrix} = \begin{bmatrix}7.6544&0\\0&0.6400\\0&0\end{bmatrix}}$$

---

### (c) Matrix V — eigenvectors of B = A^T A

**For $\lambda_1 = 58.5904$**, solve $(B - \lambda_1 I)\mathbf{v} = \mathbf{0}$:

$$(B - 58.5904\,I) = \begin{bmatrix}-55.5904&12\\12&-2.5904\end{bmatrix}$$

From row 1: $-55.5904\,v_1 + 12\,v_2 = 0 \Rightarrow v_1 = \frac{12}{55.5904}v_2 \approx 0.2158\,v_2$

Normalised: $\mathbf{v}^{(1)} = \begin{bmatrix}-0.2110\\-0.9775\end{bmatrix}$

**For $\lambda_2 = 0.4096$**, eigenvector is perpendicular to $\mathbf{v}^{(1)}$:

$\mathbf{v}^{(2)} = \begin{bmatrix}-0.9775\\0.2110\end{bmatrix}$

$$\boxed{V = \begin{bmatrix}-0.2110&-0.9775\\-0.9775&0.2110\end{bmatrix}}$$

---

### (d) Matrix U — eigenvectors of C = AA^T

**Step 1 — Compute $C = AA^\top$:**

$$C = \begin{bmatrix}1&2\\1&4\\1&6\end{bmatrix}\begin{bmatrix}1&1&1\\2&4&6\end{bmatrix} = \begin{bmatrix}1+4&1+8&1+12\\1+8&1+16&1+24\\1+12&1+24&1+36\end{bmatrix} = \begin{bmatrix}5&9&13\\9&17&25\\13&25&37\end{bmatrix}$$

**Step 2 —** Eigenvalues of $C$: same non-zero ones as $B$ ($\lambda_1=58.59$, $\lambda_2=0.41$) plus $\lambda_3=0$.

**Step 3 —** Compute eigenvectors similarly, then normalise:

$$\boxed{U = \begin{bmatrix}-0.2830&-0.8679&0.4082\\-0.5384&-0.2085&-0.8165\\-0.7938&0.4508&0.4082\end{bmatrix}}$$

---

### (e) Verification

Check that $U$ and $V$ are orthogonal, and that $UDV^\top$ reconstructs $A$:

$$UU^\top = I_{3\times3} \checkmark \qquad VV^\top = I_{2\times2} \checkmark \qquad UDV^\top = A \checkmark$$

---

### (f) Matrix D^+

**Rule:** take the reciprocal of each non-zero diagonal entry of $D$, then transpose the shape ($3\times2$ → $2\times3$):

$$D = \begin{bmatrix}7.6544&0\\0&0.6400\\0&0\end{bmatrix} \xrightarrow{\text{reciprocal + transpose}} D^+ = \begin{bmatrix}\frac{1}{7.6544}&0&0\\0&\frac{1}{0.6400}&0\end{bmatrix}$$

$$\boxed{D^+ = \begin{bmatrix}0.1306&0&0\\0&1.5625&0\end{bmatrix}}$$

---

### (g) Pseudoinverse A^+

$$A^+ = VD^+U^\top = \begin{bmatrix}-0.2110&-0.9775\\-0.9775&0.2110\end{bmatrix}\begin{bmatrix}0.1306&0&0\\0&1.5625&0\end{bmatrix}\begin{bmatrix}-0.2830&-0.5384&-0.7938\\-0.8679&-0.2085&0.4508\\0.4082&-0.8165&0.4082\end{bmatrix}$$

After full multiplication:

$$\boxed{A^+ = \begin{bmatrix}4/3&1/3&-2/3\\-1/4&0&1/4\end{bmatrix}}$$

---

### (h) Least-squares solution x = A^+ b

$$\mathbf{x} = A^+\mathbf{b} = \begin{bmatrix}4/3&1/3&-2/3\\-1/4&0&1/4\end{bmatrix}\begin{bmatrix}1.8\\3.3\\4.1\end{bmatrix}$$

**Row 1:**
$$x_1 = \tfrac{4}{3}(1.8) + \tfrac{1}{3}(3.3) + (-\tfrac{2}{3})(4.1) = 2.400 + 1.100 - 2.733 = 0.767$$

**Row 2:**
$$x_2 = (-\tfrac{1}{4})(1.8) + 0(3.3) + \tfrac{1}{4}(4.1) = -0.450 + 0 + 1.025 = 0.575$$

$$\boxed{\mathbf{x} = \begin{bmatrix}0.767\\0.575\end{bmatrix}}$$

**Interpretation:** This is the line $y = 0.575x + 0.767$ that best fits the three data points $(2, 1.8)$, $(4, 3.3)$, $(6, 4.1)$ in the least-squares sense — minimising $\|A\mathbf{x} - \mathbf{b}\|_2$.
