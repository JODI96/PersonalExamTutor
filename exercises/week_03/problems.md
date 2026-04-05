# Week 3 — Exercises

**Topic:** Numerical Computation
**Source:** Deep Learning (Goodfellow, Bengio, Courville) — Lesson 3, Chapter 4
**Date:** 2026-03-02

> Try all exercises before looking at `solutions.md`!

---

## Exercise 1 — Gradient, Hessian, and Optimisation

Given is the loss function:

$$f(\mathbf{x}) = \frac{1}{4}x_1^4 + x_1^3 - \frac{17}{4}x_1^2 - 6x_1 + \frac{1}{5}x_2^4 + \frac{6}{5}x_2^3 + 89$$

**(a)** Determine the gradient $\nabla_\mathbf{x} f(\mathbf{x})$ and the Hessian matrix $\mathbf{H}(f)(\mathbf{x})$.

**(b)** Determine all critical points. For each, determine the type (local minimum, local maximum, or saddle point) using the Hessian matrix.

**(c)** Determine the global minimum.

**(d)** Search for a minimum using the **steepest descent** method. Start at each point below, perform **10 iterations**, and check whether you found the global minimum.

| Case | Start point $\mathbf{x}^{(0)}$ | Learning rate $\epsilon$ |
|------|-------------------------------|--------------------------|
| i    | $[0,\ -0.5]^T$               | $0.1$                    |
| ii   | $[-2.5,\ 4]^T$               | $0.05$                   |

Recall the update rule:
$$\mathbf{x}^{(i)} = \mathbf{x}^{(i-1)} - \epsilon \cdot \nabla_\mathbf{x} f(\mathbf{x}^{(i-1)})$$

**(e)** Repeat part (d) using **Newton's method**:
$$\mathbf{x}^{(i)} = \mathbf{x}^{(i-1)} - \mathbf{H}(f)(\mathbf{x}^{(i-1)})^{-1}\, \nabla_\mathbf{x} f(\mathbf{x}^{(i-1)})$$

Compare the results to part (d). What do you observe?
