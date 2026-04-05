// ============================================================
// Week 2 — Chapter 2: Probability and Information Theory
// Topics: Random Variables, Distributions, Bayes, Entropy, KL-Divergence
// Date: 2026-02-23
// PDF: pdfs/week_02/DL_L02_Probability_InformationTheory.pdf
// ============================================================

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

== Chapter 2: Probability and Information Theory

// ── PART 1: Random Variables ─────────────────────────────────
=== Part 1 — Random Variables

- _Used for:_ describing uncertain quantities; modelling data distributions; defining loss functions

A *random variable* $x$ can take on different values with associated probabilities.

#formula-box[
  #table(
    columns: (auto, auto, auto, auto),
    stroke: none,
    inset: 6pt,
    [*Type*], [*Values*], [*Described by*], [*Notation*],
    [Discrete], [Countable set], [Probability Mass Function (PMF)], [$P(x = k)$],
    [Continuous], [Real interval], [Probability Density Function (PDF)], [$p(x)$],
  )
]

*PMF* (discrete) — probability at each exact value:
$ P(x = k) >= 0 quad sum_k P(x = k) = 1 $

*PDF* (continuous) — probability density; integrate over an interval to get probability:
$ p(x) >= 0 quad integral_{-infinity}^{infinity} p(x) d x = 1 quad P(a <= x <= b) = integral_a^b p(x) d x $

#warn-box[$p(x)$ is a *density*, not a probability. $p(x) > 1$ is valid! Only the integral over an interval gives probability.]

// ── PART 2: Key Distributions ────────────────────────────────
=== Part 2 — Key Distributions

*Bernoulli* — single binary outcome ($x in {0, 1}$):
- _Used for:_ modelling coin flips, binary classification outputs, gates in LSTMs
#formula-box[
  $ P(x = 1) = phi, quad P(x = 0) = 1 - phi $
  $ bb(E)[x] = phi quad op("Var")(x) = phi(1 - phi) $
]
Example: $phi = 3/4$ → $bb(E)[x] = 3/4$, $op("Var")(x) = 3/16$.

*Uniform* (continuous) — equal probability over interval $[a, b]$:
- _Used for:_ initialising weights, random sampling, baseline distributions
#formula-box[
  $ p(x) = frac(1, b - a) quad x in [a, b], quad "else" 0 $
  $ bb(E)[x] = frac(a + b, 2) quad op("Var")(x) = frac((b-a)^2, 12) $

  _Derived from integration:_ $bb(E)[x] = integral_a^b x dot frac(1, b-a) d x = frac(a+b, 2)$ (the midpoint of $[a, b]$)
]
Example: $x in [-0.5, 1]$ → $p(x) = 2/3$, $bb(E)[x] = 1/4$, $op("Var")(x) = 3/16$.

*Gaussian (Normal)* — bell curve, most important distribution in ML:
- _Used for:_ modelling real-valued data, noise, weight initialisation, latent spaces in VAEs
#formula-box[
  $ p(x) = frac(1, sqrt(2 pi sigma^2)) exp(-frac((x - mu)^2, 2 sigma^2)) $
  $ bb(E)[x] = mu quad op("Var")(x) = sigma^2 $
]

*Standard Normal:* $mu = 0$, $sigma = 1$. Notation: $x tilde cal(N)(mu, sigma^2)$.

#tip-box[
  *Why Gaussian?* The Central Limit Theorem: sums of many independent random variables converge to a Gaussian. Most real-world noise is approximately Gaussian.
]

*Exponential* — models time between events; heavy tail to the right:
$ p(x) = lambda exp(-lambda x), quad x >= 0 quad bb(E)[x] = 1/lambda $

*Laplace* — like Gaussian but with heavier tails; used in L1 regularisation:
$ p(x) = frac(1, 2 b) exp(-frac(|x - mu|, b)) $

// ── PART 3: Expectations & Variance ──────────────────────────
=== Part 3 — Expectations and Variance

- _Used for:_ computing loss function values, quantifying spread, deriving gradient updates

#formula-box[
  *Discrete:* $quad bb(E)[f(x)] = sum_x f(x) P(x)$

  *Continuous:* $quad bb(E)[f(x)] = integral f(x) p(x) d x$

  *Variance:* $quad op("Var")(x) = bb(E)[x^2] - (bb(E)[x])^2 = bb(E)[(x - bb(E)[x])^2]$
]

Key properties:
- $bb(E)[a x + b] = a\, bb(E)[x] + b$ — linearity
- $op("Var")(a x) = a^2 op("Var")(x)$
- $op("Var")(x + y) = op("Var")(x) + op("Var")(y)$ only if $x, y$ are independent

*Covariance* — measures linear dependence between two variables:
$ op("Cov")(x, y) = bb(E)[(x - bb(E)[x])(y - bb(E)[y])] = bb(E)[x y] - bb(E)[x] bb(E)[y] $

// ── PART 4: Bayes' Theorem ────────────────────────────────────
=== Part 4 — Bayes' Theorem

- _Used for:_ updating beliefs given evidence; Naive Bayes classifiers; probabilistic inference in all Bayesian models

#formula-box[
  $ P(A | B) = frac(P(B | A)\, P(A), P(B)) $

  - $P(A)$ — *prior*: belief before seeing evidence
  - $P(B | A)$ — *likelihood*: probability of evidence given hypothesis
  - $P(A | B)$ — *posterior*: updated belief after evidence
  - $P(B)$ — *marginal* (normalisation constant)
]

*Law of total probability* (for computing $P(B)$):
$ P(B) = sum_i P(B | A_i) P(A_i) $

*Example — cab problem:*
5000 yellow cabs, 100 red cabs; witness accuracy 95%. Find $P(c=r | w=r)$:

$ P(c=r) = 100/5100 approx 0.0196 $
$ P(w=r) = 0.95 dot 100/5100 + 0.05 dot 5000/5100 approx 0.0676 $
$ P(c=r | w=r) = frac(0.0196 dot 0.95, 0.0676) approx 27.5% $

#warn-box[
  *Base rate neglect:* even with a 95%-accurate witness, the answer is only ~27.5%. Red cabs are so rare that most "red" reports are still wrong yellow cabs. Always account for the prior!
]

*Bayesian classification* — assign $x$ to the class with highest posterior:
$ "assign to" c_i quad "if" quad P(y=c_i) p(x | y=c_i) > P(y=c_j) p(x | y=c_j) $

The denominator $p(x)$ is the same for all classes and cancels.

// ── PART 5: Information Theory ────────────────────────────────
=== Part 5 — Information Theory

- _Used for:_ cross-entropy loss (classifier training), measuring model uncertainty, defining KL divergence for VAEs

*Self-information* — surprise of a single outcome:
#formula-box[
  $ I(x) = -log P(x) $
  Rare events → large $I(x)$ (more surprising). Common events → small $I(x)$.
]

Log base: $log_2$ = bits; $ln$ = nats. Deep learning typically uses nats.

*Shannon Entropy* — expected surprise (average information content):
#formula-box[
  *Discrete:* $quad H(x) = -sum_x P(x) log P(x) = bb(E)[-log P(x)]$

  *Gaussian:* $quad H(x) = frac(1, 2)(log(2 pi sigma^2) + 1)$
]

Higher variance → higher entropy. Uniform distribution has maximum entropy.

Example:
- $sigma_1^2 = 0.26$ → $H(x | y=c_1) = 0.5(ln(2 pi dot 0.26) + 1) approx 0.745$ nats
- $sigma_2^2 = 0.99$ → $H(x | y=c_2) = 0.5(ln(2 pi dot 0.99) + 1) approx 1.414$ nats

*Cross-Entropy* — entropy of distribution $P$ measured under model $Q$:
#formula-box[
  $ H(P, Q) = -sum_x P(x) log Q(x) = H(P) + D_("KL")(P || Q) $
]
Used as the standard loss for classification (comparing true labels $P$ to model predictions $Q$).

*KL Divergence* — measures how much $Q$ differs from $P$:
#formula-box[
  $ D_("KL")(P || Q) = sum_x P(x) log frac(P(x), Q(x)) >= 0 $
]

#warn-box[
  $D_("KL")(P || Q) eq.not D_("KL")(Q || P)$ — KL divergence is *asymmetric*. It is not a distance metric!
  - $D_("KL")(P||Q) = 0$ iff $P = Q$ everywhere.
  - Minimising $H(P, Q)$ over $Q$ is equivalent to minimising $D_("KL")(P||Q)$ (since $H(P)$ is constant).
]

#tip-box[
  *Cross-entropy loss in practice:*
  $ cal(L) = -sum_k y_k log hat(y)_k $
  where $y_k$ = true label (one-hot), $hat(y)_k$ = softmax output. This is exactly $H(P, Q)$.
]

// ── CHEAT SHEET ──────────────────────────────────────────────
=== Cheat Sheet

#cheat-box[
  *WEEK 2 — PROBABILITY & INFORMATION THEORY CHEAT SHEET*

  #v(0.4em)

  *Random Variables:*
  - Discrete → PMF: $sum P(x) = 1$
  - Continuous → PDF: $integral p(x) d x = 1$; $p(x)$ can exceed 1!

  *Key Distributions:*
  - Bernoulli($phi$): $bb(E)=phi$, $op("Var")=phi(1-phi)$
  - Uniform$[a,b]$: $p=1/(b-a)$, $bb(E)=(a+b)/2$, $op("Var")=(b-a)^2/12$
  - Gaussian$(mu, sigma^2)$: $p = frac(1, sqrt(2 pi sigma^2)) exp(-frac((x-mu)^2, 2 sigma^2))$

  *Expectation & Variance:*
  - $bb(E)[f(x)] = sum f(x) P(x)$ or $integral f(x) p(x) d x$
  - $op("Var")(x) = bb(E)[x^2] - (bb(E)[x])^2$

  *Bayes:* $P(A|B) = frac(P(B|A) P(A), P(B))$ — always account for the prior!

  *Classification:* assign to $c_i$ if $P(c_i) p(x|c_i)$ is largest.

  *Entropy:*
  - Discrete: $H = -sum P log P$
  - Gaussian: $H = frac(1,2)(log(2 pi sigma^2) + 1)$

  *Cross-entropy:* $H(P,Q) = -sum P log Q = H(P) + D_("KL")(P||Q)$

  *KL-Divergence:* $D_("KL")(P||Q) = sum P log frac(P, Q) >= 0$; asymmetric!
]
