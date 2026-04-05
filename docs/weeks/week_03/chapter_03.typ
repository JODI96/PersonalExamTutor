// ============================================================
// Week 3 — Chapter 3: Numerical Computation
// Topics: Numerical Problems, Gradient-Based Optimization,
//         Jacobian, Hessian, Taylor Approximation
// Date: 2026-03-02
// PDF: pdfs/week_03/DL_L03_NumericalComputation.pdf
// ============================================================

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

== Chapter 3: Numerical Computation

// ── PART 1: General Methodology ──────────────────────────────
=== Part 1 — General Methodology

- _Used for:_ framing all of deep learning as an optimisation problem

Training a neural network = minimising the cross-entropy between the empirical data distribution $hat(p)$ and the model distribution $p_"model"(bold(x); bold(theta))$:

#formula-box[
  $ hat(p)(bold(x)) = frac(1, m) sum_(i=1)^m delta(bold(x) - bold(x)^((i))) $

  $ min_(bold(theta)) H(hat(p)_"data",\, p_"model"(bold(theta))) $

  The optimal parameter vector: $bold(x)^* = arg min f(bold(x))$
]

#tip-box[
  *Key insight:* Minimising the cross-entropy $H(P, Q)$ is equivalent to minimising $D_"KL"(P || Q)$, since $H(P)$ is constant with respect to the model parameters. Learning is fundamentally an optimisation problem.
]

// ── PART 2: Numerical Problems ───────────────────────────────
=== Part 2 — Numerical Problems

- _Used for:_ understanding why naive implementations of ML algorithms fail in practice

Computers store real numbers with finite precision — this causes three main classes of problems:

#formula-box[
  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.5pt + luma(180),
    inset: 8pt,
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    [*Problem*], [*Cause*], [*Effect*],
    [*Quantization*], [Finite bits → discrete levels], [Rounding errors accumulate],
    [*Underflow*], [Small values rounded to 0], [Downstream $1/x$ or $log(x)$ blows up],
    [*Overflow*], [Large values rounded to $infinity$], [No further computation possible],
  )
]

*Condition number* — measures sensitivity of a function $f(bold(x)) = bold(A)^(-1) bold(x)$ to small input errors:

#formula-box[
  $ "Condition number" = max_(i,j) abs(lambda_i / lambda_j) $

  - $approx 1$ → well conditioned (errors stay small)
  - $>> 1$ → ill conditioned (errors amplified, e.g. $> 10\,000$)
]

#warn-box[
  Poor conditioning is especially dangerous in linear regression: small measurement noise in $bold(x)$ can produce wildly different parameter estimates $hat(bold(beta)) = bold(A)^(-1) bold(x)$.
]

// ── PART 3: Softmax Stabilisation ────────────────────────────
=== Part 3 — Softmax Stabilisation

- _Used for:_ multi-class classification output layers; illustrates how to make numerically unstable functions safe

#formula-box[
  *Softmax:* $quad "softmax"(bold(x))_i = frac(exp(x_i), sum_(j=1)^n exp(x_j))$
]

*Problem:* if all inputs equal large positive $c$ → $exp(c)$ overflows ($infinity/infinity$); large negative $c$ → underflows ($0/0$).

*Fix — subtract the maximum:*

#formula-box[
  $ bold(z) = bold(x) - max_i x_i $
  $ "softmax"(bold(x))_i = "softmax"(bold(z))_i quad "  (identical output, numerically safe)" $
]

Why it works:
- Largest entry of $bold(z)$ is 0 → $exp(0) = 1$ → denominator $> 1$ → no $0/0$
- All other entries negative → $exp < 1$ → no overflow

#warn-box[
  *log-softmax* needs separate stabilisation: even a numerically stable softmax can underflow to 0, then $log(0) = -infinity$. Modern frameworks (PyTorch, JAX) handle this automatically — but beware if computing by hand.
]

// ── PART 4: Gradient-Based Optimisation ──────────────────────
=== Part 4 — Gradient-Based Optimisation

- _Used for:_ training every gradient-based ML model; the core algorithm of deep learning

*Scalar case* $y = f(x)$: derivative $f'(x)$ = slope. Moving in the direction of the slope decreases $f$:

#formula-box[
  $ f(x + epsilon) approx f(x) + epsilon f'(x) $
]

*Algorithm — Gradient Descent:*
1. Initialise at some point $bold(x)^((0))$
2. Compute gradient $nabla_(bold(x)) f(bold(x))$
3. Step in the *negative* gradient direction: $bold(x)' = bold(x) - epsilon nabla_(bold(x)) f(bold(x))$
4. Repeat until $nabla_(bold(x)) f(bold(x)) = bold(0)$

*Critical points* — where $f'(x) = 0$ (gradient descent halts):

#formula-box[
  #table(
    columns: (auto, 1fr),
    stroke: 0.5pt + luma(180),
    inset: 8pt,
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    [*Type*], [*Description*],
    [Local minimum], [Both directions go up],
    [Local maximum], [Both directions go down],
    [Saddle point], [$f'(x) = 0$ but neither min nor max],
  )
]

#tip-box[
  In deep learning, we never find the *global* minimum — the loss landscape has millions of saddle points and local minima. The goal is to be "good enough": a local minimum with low enough loss value.
]

// ── PART 5: Gradient in Multiple Dimensions ───────────────────
=== Part 5 — Gradient in Multiple Dimensions

- _Used for:_ optimising neural network parameters $bold(theta)$ which are always high-dimensional vectors

For $f: RR^n -> RR$ (vector input, scalar output):

#formula-box[
  *Partial derivative:* slope of $f$ when changing $x_i$ only:
  $ frac(partial, partial x_i) f(bold(x)) $

  *Gradient:* vector of all partial derivatives (same size as $bold(x)$):
  $ nabla_(bold(x)) f(bold(x)) = mat(frac(partial f(bold(x)), partial x_1); frac(partial f(bold(x)), partial x_2); dots.v; frac(partial f(bold(x)), partial x_n)) $

  *Directional derivative* in unit direction $bold(u)$:
  $ frac(partial, partial alpha) f(bold(x) + alpha bold(u)) = bold(u)^T nabla_(bold(x)) f(bold(x)) quad "at" alpha = 0 $
]

The direction that *minimises* the directional derivative is the *negative gradient* direction (where $cos theta = -1$, i.e. $theta = 180 degree$):

#formula-box[
  *Gradient descent update rule:*
  $ bold(x)' = bold(x) - epsilon nabla_(bold(x)) f(bold(x)) $

  - $epsilon$ too small → learning takes forever
  - $epsilon$ too large → chance of stepping over a minimum
]

// ── PART 6: Jacobian Matrices ─────────────────────────────────
=== Part 6 — Jacobian Matrices

- _Used for:_ backpropagation through vector-to-vector layers; computing gradients of the softmax

For functions $f: RR^m -> RR^n$ (vector input *and* vector output):

#formula-box[
  *Jacobian matrix* $bold(J) in RR^(n times m)$:
  $ J_(i,j) = frac(partial, partial x_j) f(bold(x))_i $

  Example for $n = m = 2$:
  $ bold(J) = mat(frac(partial f_1, partial x_1), frac(partial f_1, partial x_2); frac(partial f_2, partial x_1), frac(partial f_2, partial x_2)) $
]

#tip-box[
  The Jacobian is the generalisation of the gradient to vector-valued functions. Row $i$ of $bold(J)$ = gradient of output $f_i(bold(x))$.
]

// ── PART 7: Second Derivatives and the Hessian ────────────────
=== Part 7 — Second Derivatives and the Hessian

- _Used for:_ Newton's method; understanding curvature; second-order optimisation; diagnosing saddle points

*Curvature* is the slope of the slope:

#formula-box[
  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.5pt + luma(180),
    inset: 8pt,
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    [*Curvature*], [*Slope behaviour*], [*GD step quality*],
    [Negative ($f'' < 0$)], [Slope gets smaller], [Too small (pessimistic)],
    [Zero ($f'' = 0$)], [Slope stays constant], [Just right],
    [Positive ($f'' > 0$)], [Slope gets larger], [Too large (optimistic)],
  )
]

*Hessian matrix* — matrix of all second-order partial derivatives:

#formula-box[
  $ bold(H)(f)(bold(x))_(i,j) = frac(partial^2, partial x_i partial x_j) f(bold(x)) $

  Example for $n = 2$:
  $ bold(H) = mat(frac(partial^2 f, partial x_1^2), frac(partial^2 f, partial x_1 partial x_2); frac(partial^2 f, partial x_2 partial x_1), frac(partial^2 f, partial x_2^2)) $

  *Symmetry:* $H_(i,j) = H_(j,i)$ → eigendecomposition with real eigenvalues: $bold(H) = bold(V) bold(Lambda) bold(V)^T$
]

*Directional second derivative* in direction $bold(d)$: $quad bold(d)^T bold(H) bold(d)$

Curvature in direction $bold(d)$ is a weighted sum of eigenvalues:
$ bold(d)^T bold(H) bold(d) = sum_i (cos theta_i)^2 lambda_i $

- Maximum curvature = $lambda_"max"$ in direction of $bold(v)_"max"$
- Minimum curvature = $lambda_"min"$ in direction of $bold(v)_"min"$

// ── PART 8: Taylor Approximation & Critical Point Test ────────
=== Part 8 — Taylor Approximation and Second Derivative Test

- _Used for:_ Newton's method; understanding when gradient descent overshoots; classifying critical points

*2nd-order Taylor approximation:*

#formula-box[
  $ f(bold(x)) approx f(bold(x)^((0))) + (bold(x) - bold(x)^((0)))^T bold(g) + frac(1, 2)(bold(x) - bold(x)^((0)))^T bold(H) (bold(x) - bold(x)^((0))) $

  where $bold(g) = nabla f(bold(x)^((0)))$ and $bold(H) = bold(H)(f)(bold(x)^((0)))$.

  After one gradient descent step $bold(x)^((0)) - epsilon bold(g)$:
  $ f(bold(x)^((0)) - epsilon bold(g)) approx f(bold(x)^((0))) - epsilon bold(g)^T bold(g) + frac(1, 2) epsilon^2 bold(g)^T bold(H) bold(g) $
]

The third term $frac(1, 2) epsilon^2 bold(g)^T bold(H) bold(g)$ governs whether the step actually decreases $f$:
- $bold(g)^T bold(H) bold(g) <= 0$ → larger $epsilon$ always helps
- $bold(g)^T bold(H) bold(g) > 0$ → strong curvature can *increase* $f$; must use small $epsilon$

*Second derivative test:*

#formula-box[
  #table(
    columns: (auto, auto, 1fr),
    stroke: 0.5pt + luma(180),
    inset: 8pt,
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    [*Critical point type*], [*1D: $f''(x)$*], [*nD: Eigenvalues of $bold(H)$*],
    [Local minimum], [$> 0$], [All positive],
    [Local maximum], [$< 0$], [All negative],
    [Saddle point], [$= 0$], [Mixed (some $+$, some $-$)],
  )
]

*Newton's method* — uses the Hessian to take a single optimal step to the critical point:

#formula-box[
  $ bold(x)^((i)) = bold(x)^((i-1)) - bold(H)(f)(bold(x)^((i-1)))^(-1) nabla_(bold(x)) f(bold(x)^((i-1))) $
]

#warn-box[
  Newton's method converges to *any* critical point — including saddle points! In high dimensions (1M parameters), even if 999'999 eigenvalues are positive and just 1 is negative, the point is still a saddle — not a minimum. Steepest descent often works better in practice.
]

// ── PART 9: Condition Number of the Hessian ───────────────────
=== Part 9 — Condition Number and Poor Conditioning

- _Used for:_ diagnosing slow convergence; motivating adaptive learning rate methods

#formula-box[
  $ "Condition number of Hessian" = max_(i,j) abs(lambda_i / lambda_j) $
]

#formula-box[
  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.5pt + luma(180),
    inset: 8pt,
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    [*Condition number*], [*Curvature*], [*Effect on GD*],
    [Small ($approx 1$)], [Similar in all directions], [Large $epsilon$ fine, fast convergence],
    [Large ($>> 1$)], [High in one direction, low in another], [Must use small $epsilon$ → zigzag, slow progress],
  )
]

The loss landscape with a high condition number looks like an elongated ellipse — gradient descent zigzags along the steep direction while making tiny progress in the flat direction. This motivates adaptive optimisers (Adam, RMSProp) to be discussed later.

// ── CHEAT SHEET ──────────────────────────────────────────────
=== Cheat Sheet

#cheat-box[
  *WEEK 3 — NUMERICAL COMPUTATION CHEAT SHEET*

  #v(0.4em)

  *Numerical problems:*
  - Underflow: small values → 0 (triggers division/log errors)
  - Overflow: large values → $infinity$
  - Softmax fix: subtract max before applying exp
  - Condition number = $max |lambda_i / lambda_j|$; large → ill conditioned

  *Gradient descent:*
  $ bold(x)' = bold(x) - epsilon nabla_(bold(x)) f(bold(x)) $
  - Gradient points in direction of steepest *ascent*
  - Negative gradient = steepest *descent*
  - Terminates at critical points where $nabla_(bold(x)) f = bold(0)$

  *Partial / directional derivatives:*
  - Gradient: $nabla_(bold(x)) f$ — vector of all partials
  - Directional: $frac(partial, partial alpha) f(bold(x) + alpha bold(u)) = bold(u)^T nabla_(bold(x)) f(bold(x))$

  *Jacobian* ($f: RR^m -> RR^n$): $J_(i,j) = frac(partial, partial x_j) f(bold(x))_i in RR^(n times m)$

  *Hessian* ($f: RR^n -> RR$): $H_(i,j) = frac(partial^2, partial x_i partial x_j) f$ — symmetric, real eigenvalues

  *2nd order Taylor:*
  $ f(bold(x)) approx f(bold(x)^((0))) + (bold(x) - bold(x)^((0)))^T bold(g) + frac(1, 2)(bold(x) - bold(x)^((0)))^T bold(H)(bold(x) - bold(x)^((0))) $

  *Second derivative test:*
  - Min: $f'' > 0$ / all $lambda > 0$
  - Max: $f'' < 0$ / all $lambda < 0$
  - Saddle: $f'' = 0$ / mixed $lambda$

  *Newton's method:*
  $ bold(x)^((i)) = bold(x)^((i-1)) - bold(H)^(-1) nabla f $ — fast but attracted to saddle points!
]
