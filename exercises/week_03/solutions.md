# Week 3 — Solutions

**Topic:** Numerical Computation
**Source:** Deep Learning (Goodfellow, Bengio, Courville) — Lesson 3, Chapter 4

> Only read this after you have genuinely tried the problems!

---

## Exercise 1 — Gradient, Hessian, and Optimisation

$$f(\mathbf{x}) = \frac{1}{4}x_1^4 + x_1^3 - \frac{17}{4}x_1^2 - 6x_1 + \frac{1}{5}x_2^4 + \frac{6}{5}x_2^3 + 89$$

---

### (a) Gradient and Hessian

**First partial derivatives:**

$$\frac{\partial f}{\partial x_1} = x_1^3 + 3x_1^2 - \frac{17}{2}x_1 - 6$$

$$\frac{\partial f}{\partial x_2} = \frac{4}{5}x_2^3 + \frac{18}{5}x_2^2$$

**Second partial derivatives:**

$$\frac{\partial^2 f}{\partial x_1^2} = 3x_1^2 + 6x_1 - \frac{17}{2} \qquad \frac{\partial^2 f}{\partial x_2^2} = \frac{12}{5}x_2^2 + \frac{36}{5}x_2 \qquad \frac{\partial^2 f}{\partial x_1 \partial x_2} = 0$$

**Gradient:**

$$\boxed{\nabla_\mathbf{x} f(\mathbf{x}) = \begin{bmatrix} x_1^3 + 3x_1^2 - \tfrac{17}{2}x_1 - 6 \\[4pt] \tfrac{4}{5}x_2^3 + \tfrac{18}{5}x_2^2 \end{bmatrix}}$$

**Hessian:**

$$\boxed{\mathbf{H}(f)(\mathbf{x}) = \begin{bmatrix} 3x_1^2 + 6x_1 - \tfrac{17}{2} & 0 \\ 0 & \tfrac{12}{5}x_2^2 + \tfrac{36}{5}x_2 \end{bmatrix}}$$

> Note: the Hessian is diagonal (off-diagonal = 0) because $f$ is separable — $x_1$ and $x_2$ terms never mix.

---

### (b) Critical Points and Their Types

Set $\nabla_\mathbf{x} f = \mathbf{0}$. Because the Hessian is diagonal, the two components decouple.

**From $\partial f / \partial x_1 = 0$:** solve $x_1^3 + 3x_1^2 - \tfrac{17}{2}x_1 - 6 = 0$:

$$x_{1,a} \approx -4.572, \qquad x_{1,b} \approx -0.603, \qquad x_{1,c} \approx 2.175$$

**From $\partial f / \partial x_2 = 0$:** solve $\tfrac{4}{5}x_2^3 + \tfrac{18}{5}x_2^2 = 0$, i.e. $x_2^2\!\left(\tfrac{4}{5}x_2 + \tfrac{18}{5}\right) = 0$:

$$x_{2,a} = 0, \qquad x_{2,b} = -4.5$$

This gives $3 \times 2 = 6$ critical points:

| Point | $\mathbf{c}$ | $H_{11}$ | $H_{22}$ | Type |
|-------|-------------|----------|----------|------|
| $\mathbf{c}_1$ | $[-4.572,\;0]^T$ | $+26.78$ | $0$ | saddle (inconclusive → saddle by higher-order analysis) |
| $\mathbf{c}_2$ | $[-0.603,\;0]^T$ | $-11.03$ | $0$ | saddle |
| $\mathbf{c}_3$ | $[2.175,\;0]^T$ | $+18.75$ | $0$ | saddle |
| $\mathbf{c}_4$ | $[-4.572,\;-4.5]^T$ | $+26.78$ | $+16.2$ | **local minimum** |
| $\mathbf{c}_5$ | $[-0.603,\;-4.5]^T$ | $-11.03$ | $+16.2$ | saddle point |
| $\mathbf{c}_6$ | $[2.175,\;-4.5]^T$ | $+18.75$ | $+16.2$ | **local minimum** |

> $\mathbf{c}_4$ and $\mathbf{c}_6$: both Hessian eigenvalues positive → local minima.  
> $\mathbf{c}_5$: one negative, one positive eigenvalue → saddle point.  
> $\mathbf{c}_1, \mathbf{c}_2, \mathbf{c}_3$: $H_{22} = 0$ → test inconclusive for $x_2$ direction; higher-order analysis confirms all three are saddle points.

---

### (c) Global Minimum

Evaluate $f$ at the two local minima (all others are saddle points):

$$f(\mathbf{c}_4) = f([-4.572,\,-4.5]^T) \approx 13.92$$

$$f(\mathbf{c}_6) = f([2.175,\,-4.5]^T) \approx 44.39$$

$$\boxed{\text{Global minimum: } \mathbf{c}_4 = [-4.572,\,-4.5]^T \text{ with } f(\mathbf{c}_4) \approx 13.92}$$

---

### (d) Steepest Descent

Update rule: $\mathbf{x}^{(i)} = \mathbf{x}^{(i-1)} - \epsilon \cdot \nabla_\mathbf{x} f(\mathbf{x}^{(i-1)})$

**Case i — start $[0,\,-0.5]^T$, $\epsilon = 0.1$:**

| Step | $x_1$ | $x_2$ |
|------|--------|--------|
| 0 | 0.0000 | −0.5000 |
| 1 | 0.6000 | −0.5800 |
| 2 | 1.5804 | −0.6855 |
| 3 | 2.3797 | −0.8289 |
| 4 | 1.9559 | −1.0307 |
| 5 | 2.3225 | −1.3255 |
| 6 | 2.0257 | −1.7717 |
| 7 | 2.2853 | −2.4568 |
| 8 | 2.0675 | −3.4434 |
| 9 | 2.2587 | −4.4457 |
| **10** | **2.0957** | **−4.5316** |

Result: $\mathbf{x}^{(10)} \approx [2.096,\,-4.532]^T$ → converges toward **local minimum $\mathbf{c}_6$** (not the global minimum).

---

**Case ii — start $[-2.5,\,4]^T$, $\epsilon = 0.05$:**

| Step | $x_1$ | $x_2$ |
|------|--------|--------|
| 0 | −2.5000 | 4.0000 |
| 1 | −3.4188 | −1.4400 |
| 2 | −4.3270 | −1.6938 |
| 3 | −4.6237 | −2.0158 |
| 4 | −4.5531 | −2.4196 |
| 5 | −4.5783 | −2.9068 |
| 6 | −4.5700 | −3.4453 |
| 7 | −4.5728 | −3.9461 |
| 8 | −4.5718 | −4.2911 |
| 9 | −4.5722 | −4.4450 |
| **10** | **−4.5721** | **−4.4885** |

Result: $\mathbf{x}^{(10)} \approx [-4.572,\,-4.489]^T$ → converges toward **global minimum $\mathbf{c}_4$**.

> **Observation:** gradient descent is sensitive to the starting point and learning rate. Different initialisations can lead to different local (or global) minima.

---

### (e) Newton's Method

Update rule: $\mathbf{x}^{(i)} = \mathbf{x}^{(i-1)} - \mathbf{H}(f)(\mathbf{x}^{(i-1)})^{-1}\,\nabla_\mathbf{x} f(\mathbf{x}^{(i-1)})$

Because $\mathbf{H}$ is diagonal, $\mathbf{H}^{-1}$ simply inverts each diagonal entry.

**Case i — start $[0,\,-0.5]^T$:**

| Step | $x_1$ | $x_2$ |
|------|--------|--------|
| 0 | 0.0000 | −0.5000 |
| 1 | −0.7059 | −0.2333 |
| 2 | −0.6042 | −0.1134 |
| 3 | −0.6033 | −0.0560 |
| 4 | −0.6033 | −0.0278 |
| 5 | −0.6033 | −0.0139 |
| **10** | **−0.6033** | **−0.0004** |

Result: converges to $\approx [-0.603,\,0]^T$ → **saddle point $\mathbf{c}_2$** (not a minimum!).

---

**Case ii — start $[-2.5,\,4]^T$:**

| Step | $x_1$ | $x_2$ |
|------|--------|--------|
| 0 | −2.5000 | 4.0000 |
| 1 | 1.3684 | 2.3810 |
| 2 | 3.1422 | 1.3661 |
| 3 | 2.4434 | 0.7543 |
| 4 | 2.2054 | 0.4024 |
| 5 | 2.1758 | 0.2091 |
| **10** | **2.1753** | **0.0068** |

Result: converges to $\approx [2.175,\,0]^T$ → **saddle point $\mathbf{c}_3$** (not a minimum!).

---

### Key Observation

> **Newton's method is attracted to saddle points.** It finds the nearest critical point of *any* type — minimum, maximum, or saddle — because it simply zeroes the gradient without checking the sign of the Hessian. In high-dimensional deep learning models this is a fundamental problem, since the vast majority of critical points are saddle points, not minima.
>
> **Steepest descent** avoids this trap (it does not use curvature information) and can find the global minimum depending on the starting point — but convergence is slow and the result is starting-point dependent.
