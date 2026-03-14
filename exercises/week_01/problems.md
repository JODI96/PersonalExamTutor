# Week 1 — Exercises

**Topic:** Linear Algebra for Deep Learning
**Source:** Deep Learning (Goodfellow, Bengio, Courville) — Lesson 1, Chapter 2
**Date:** 2026-03-14

> Try all exercises before looking at `solutions.md`!

---

## Exercise 1 — Matrix Products

Given:

$$A = \begin{bmatrix} 7 & 7 & 0 \\ 8 & 4 & 2 \end{bmatrix} \quad (2 \times 3) \qquad B = \begin{bmatrix} 7 & 0 \\ 0 & 1 \\ 3 & 8 \end{bmatrix} \quad (3 \times 2)$$

**(a)** Compute $C = AB$ and $D = BA$.

**(b)** Given $\boldsymbol{x} = [7, 3, 10]^\top$, compute $\boldsymbol{b} = A\boldsymbol{x}$.

**(c)** Given $\boldsymbol{h} = [2, 5]^\top$, compute $\boldsymbol{c} = \boldsymbol{h}^\top A$.

---

## Exercise 2 — Inverse of an Orthogonal Matrix

Given:

$$A = \frac{1}{3} \begin{bmatrix} 2 & -2 & 1 \\ 1 & 2 & 2 \\ 2 & 1 & -2 \end{bmatrix}$$

**(a)** Find $A^{-1}$. Hint: check whether $A$ is orthogonal.

**(b)** Verify your result by checking $A^{-1} A = I$.

**(c)** Use your result to solve $A\boldsymbol{x} = \boldsymbol{b}$ where $\boldsymbol{b} = [1, 1, 3]^\top$.

---

## Exercise 3 — $L^p$ Norms

Given: $\boldsymbol{y} = [4, -3]^\top$

Compute $\|\boldsymbol{y}\|_p$ for $p = 1,\ 2,\ 3$.

Recall: $\|\boldsymbol{y}\|_p = \left(\sum_i |y_i|^p\right)^{1/p}$

---

## Exercise 4 — Moore-Penrose Pseudoinverse via SVD

Given the overdetermined system $A\boldsymbol{x} = \boldsymbol{b}$ (no exact solution exists):

$$A = \begin{bmatrix} 1 & 2 \\ 1 & 4 \\ 1 & 6 \end{bmatrix} \qquad \boldsymbol{b} = \begin{bmatrix} 1.8 \\ 3.3 \\ 4.1 \end{bmatrix}$$

The Moore-Penrose pseudoinverse is computed via SVD: $A = UDV^\top \Rightarrow A^+ = VD^+U^\top$

**(a)** Compute $B = A^\top A$ and find its eigenvalues $\lambda_1, \lambda_2$.

**(b)** Write the matrix $D$ (from the SVD of $A$).

**(c)** Find $V$ — the matrix of eigenvectors of $B = A^\top A$.

**(d)** Compute $C = AA^\top$ and find its eigenvectors to build $U$.

**(e)** Verify: $UU^\top = I$, $VV^\top = I$, and $UDV^\top = A$.

**(f)** Write $D^+$ (pseudo-inverse of $D$).

**(g)** Compute $A^+ = VD^+U^\top$.

**(h)** Find the least-squares solution: $\boldsymbol{x} = A^+\boldsymbol{b}$.
