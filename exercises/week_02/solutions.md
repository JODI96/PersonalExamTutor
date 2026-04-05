# Week 2 — Solutions

**Topic:** Probability and Information Theory
**Source:** Deep Learning (Goodfellow, Bengio, Courville) — Lesson 2, Chapter 3

> Only read this after you have genuinely tried the problems!

---

## Exercise 1 — Bernoulli Distribution

$$P(x=1) = \tfrac{3}{4}, \quad P(x=0) = \tfrac{1}{4}$$

### (a) Probability Mass Function

The PMF has two spikes — one at each possible value of $x$:

```
P_x(x)
  1 |
3/4 |              •
1/2 |
1/4 |    •
    +----+----------> x
         0          1
```

$P_x(0) = \frac{1}{4}$, $P_x(1) = \frac{3}{4}$, zero everywhere else.

---

### (b) Expected Value

$$\mathbb{E}_x[x] = \sum_x x\, P(x = x) = 0 \cdot P(x=0) + 1 \cdot P(x=1)$$

$$= 0 \cdot \frac{1}{4} + 1 \cdot \frac{3}{4}$$

$$\boxed{\mathbb{E}_x[x] = \frac{3}{4}}$$

---

### (c) Variance

**Method 1 — via $\mathbb{E}[x^2]$:**

**Step 1 — Compute $\mathbb{E}[x^2]$:**
$$\mathbb{E}_x[x^2] = \sum_x x^2\, P(x=x) = 0^2 \cdot \frac{1}{4} + 1^2 \cdot \frac{3}{4} = \frac{3}{4}$$

**Step 2 — Apply variance formula:**
$$\text{Var}_x(x) = \mathbb{E}[x^2] - (\mathbb{E}[x])^2 = \frac{3}{4} - \left(\frac{3}{4}\right)^2 = \frac{3}{4} - \frac{9}{16} = \frac{12}{16} - \frac{9}{16}$$

$$\boxed{\text{Var}_x(x) = \frac{3}{16}}$$

**Method 2 — direct definition** $\text{Var}(x) = \mathbb{E}[(x - \mathbb{E}[x])^2]$:

$$= \left(0 - \frac{3}{4}\right)^2 \cdot \frac{1}{4} + \left(1 - \frac{3}{4}\right)^2 \cdot \frac{3}{4} = \frac{9}{16} \cdot \frac{1}{4} + \frac{1}{16} \cdot \frac{3}{4} = \frac{9}{64} + \frac{3}{64} = \frac{12}{64} = \frac{3}{16} \checkmark$$

---

## Exercise 2 — Uniform Distribution (Continuous)

$x \sim \mathcal{U}(-0.5,\, 1)$, interval length $= 1 - (-0.5) = 1.5$.

### (a) Probability Density Function

The PDF is constant over $[-0.5, 1]$ and zero outside. Height must integrate to 1:

$$f_x(x) = \frac{1}{b - a} = \frac{1}{1 - (-0.5)} = \frac{1}{1.5} = \frac{2}{3}$$

```
f_x(x)
2/3 |    ___________
    |   |           |
    +---+-----------+-----> x
      -0.5           1
```

---

### (b) Expected Value

$$\mathbb{E}_x[x] = \int x\, f_x(x)\, dx = \int_{-0.5}^{1} x \cdot \frac{2}{3}\, dx = \left[\frac{x^2}{3}\right]_{-0.5}^{1} = \frac{1}{3} - \frac{(-0.5)^2}{3} = \frac{1}{3} - \frac{1}{12} = \frac{4}{12} - \frac{1}{12}$$

$$\boxed{\mathbb{E}_x[x] = \frac{1}{4}}$$

> Alternatively: midpoint of $[-0.5, 1]$ is $\frac{-0.5 + 1}{2} = 0.25 = \frac{1}{4}$ ✓

---

### (c) Variance

**Step 1 — Compute $\mathbb{E}[x^2]$:**

$$\mathbb{E}_x[x^2] = \int_{-0.5}^{1} x^2 \cdot \frac{2}{3}\, dx = \left[\frac{2x^3}{9}\right]_{-0.5}^{1} = \frac{2}{9} - \frac{2(-0.5)^3}{9} = \frac{2}{9} + \frac{0.25}{9} = \frac{2}{9} + \frac{1}{36} = \frac{8}{36} + \frac{1}{36} = \frac{9}{36} = \frac{1}{4}$$

**Step 2 — Apply variance formula:**

$$\text{Var}_x(x) = \mathbb{E}[x^2] - (\mathbb{E}[x])^2 = \frac{1}{4} - \left(\frac{1}{4}\right)^2 = \frac{1}{4} - \frac{1}{16} = \frac{4}{16} - \frac{1}{16}$$

$$\boxed{\text{Var}_x(x) = \frac{3}{16}}$$

> General formula for uniform: $\text{Var} = \frac{(b-a)^2}{12} = \frac{(1.5)^2}{12} = \frac{2.25}{12} = \frac{3}{16}$ ✓

---

## Exercise 3 — Bayes' Theorem (Cab Problem)

**Goal:** find $P(c = r \mid w = r)$ — probability the cab was red, given the witness said red.

**Step 1 — Identify the prior and likelihoods:**

$$P(c = r) = \frac{100}{5000 + 100} = \frac{100}{5100} \approx 0.0196$$

$$P(c = y) = \frac{5000}{5100} \approx 0.9804$$

$$P(w = r \mid c = r) = 0.95 \quad \text{(witness correct on red)}$$

$$P(w = r \mid c = y) = 0.05 \quad \text{(witness wrong on yellow)}$$

**Step 2 — Compute $P(w = r)$ via the law of total probability:**

$$P(w = r) = P(w = r \mid c = r)\,P(c = r) + P(w = r \mid c = y)\,P(c = y)$$

$$= 0.95 \cdot \frac{100}{5100} + 0.05 \cdot \frac{5000}{5100} = \frac{95}{5100} + \frac{250}{5100} = \frac{345}{5100} \approx 0.0676$$

**Step 3 — Apply Bayes' rule:**

$$P(c = r \mid w = r) = \frac{P(c = r)\, P(w = r \mid c = r)}{P(w = r)} = \frac{0.0196 \times 0.95}{0.0676}$$

$$\boxed{P(c = r \mid w = r) \approx 27.54\%}$$

> **Intuition:** Red cabs are so rare (only 2% of the fleet) that even a 95%-accurate witness is usually wrong — the overwhelming base rate of yellow cabs dominates.

---

## Exercise 4 — Classification with Naive Bayes

$$S_1 = \{5.3,\ 5.7,\ 6.1,\ 6.3,\ 6.6\} \quad (N_1=5) \qquad S_2 = \{6.2,\ 6.5,\ 6.9,\ 7.7,\ 8.0,\ 8.3,\ 8.9\} \quad (N_2=7)$$

### (a) Mean and Variance

**Step 1 — Compute means:**

$$m_1 = \frac{5.3 + 5.7 + 6.1 + 6.3 + 6.6}{5} = \frac{30}{5} = \boxed{6}$$

$$m_2 = \frac{6.2 + 6.5 + 6.9 + 7.7 + 8.0 + 8.3 + 8.9}{7} = \frac{52.5}{7} = \boxed{7.5}$$

**Step 2 — Compute variances** (sample variance, $N-1$ denominator):

$$\sigma_1^2 = \frac{(5.3-6)^2 + (5.7-6)^2 + (6.1-6)^2 + (6.3-6)^2 + (6.6-6)^2}{5-1}$$
$$= \frac{0.49 + 0.09 + 0.01 + 0.09 + 0.36}{4} = \frac{1.04}{4} = \boxed{0.26} \quad \Rightarrow \sigma_1 \approx 0.51$$

$$\sigma_2^2 = \frac{(6.2-7.5)^2 + (6.5-7.5)^2 + (6.9-7.5)^2 + (7.7-7.5)^2 + (8.0-7.5)^2 + (8.3-7.5)^2 + (8.9-7.5)^2}{7-1}$$
$$= \frac{1.69 + 1.00 + 0.36 + 0.04 + 0.25 + 0.64 + 1.96}{6} = \frac{5.94}{6} = \boxed{0.99} \quad \Rightarrow \sigma_2 \approx 0.995$$

> $c_1$ is a narrow Gaussian centred at 6; $c_2$ is a wider Gaussian centred at 7.5.

---

### (b) Prior Probabilities

Based on sample counts:

$$\boxed{P(y = c_1) = \frac{N_1}{N_1 + N_2} = \frac{5}{12}} \qquad \boxed{P(y = c_2) = \frac{N_2}{N_1 + N_2} = \frac{7}{12}}$$

---

### (c) Classification via Posterior

**Decision rule:** assign $x$ to $c_1$ if $P(y=c_1)\,p(x \mid y=c_1) > P(y=c_2)\,p(x \mid y=c_2)$.

The denominator $p(x)$ is identical for both classes and cancels.

**Evaluate Gaussian PDFs** at each test point:

$$p(x \mid y = c_i) = \sqrt{\frac{1}{2\pi\sigma_i^2}}\exp\!\left(-\frac{(x-m_i)^2}{2\sigma_i^2}\right)$$

**For $x_1 = 5$:**

$$p(5 \mid c_1) = \sqrt{\frac{1}{2\pi \cdot 0.26}}\exp\!\left(-\frac{(5-6)^2}{2 \cdot 0.26}\right) \approx 0.1144$$

$$p(5 \mid c_2) = \sqrt{\frac{1}{2\pi \cdot 0.99}}\exp\!\left(-\frac{(5-7.5)^2}{2 \cdot 0.99}\right) \approx 0.0171$$

$$\frac{5}{12} \cdot 0.1144 = 0.0476 \quad > \quad \frac{7}{12} \cdot 0.0171 = 0.0100$$

$$\boxed{x_1 = 5 \;\to\; c_1}$$

**For $x_2 = 7$:**

$$p(7 \mid c_1) \approx 0.1144 \qquad p(7 \mid c_2) \approx 0.3534$$

$$\frac{5}{12} \cdot 0.1144 = 0.0476 \quad < \quad \frac{7}{12} \cdot 0.3534 = 0.2061$$

$$\boxed{x_2 = 7 \;\to\; c_2}$$

---

### (d) Entropy of Gaussian Classes

For a Gaussian random variable with variance $\sigma^2$, the differential entropy is:

$$H(x) = \frac{1}{2}\left(\log(2\pi\sigma^2) + 1\right) \quad \text{(in nats, using natural log)}$$

**Class $c_1$** ($\sigma_1^2 = 0.26$):

$$H(x \mid y = c_1) = \frac{1}{2}\left(\ln(2\pi \cdot 0.26) + 1\right) = \frac{1}{2}\left(\ln(1.6336) + 1\right) \approx \frac{1}{2}(0.4908 + 1)$$

$$\boxed{H(x \mid y = c_1) \approx 0.7454 \text{ nats}}$$

**Class $c_2$** ($\sigma_2^2 = 0.99$):

$$H(x \mid y = c_2) = \frac{1}{2}\left(\ln(2\pi \cdot 0.99) + 1\right) = \frac{1}{2}\left(\ln(6.2200) + 1\right) \approx \frac{1}{2}(1.8278 + 1)$$

$$\boxed{H(x \mid y = c_2) \approx 1.4139 \text{ nats}}$$

> $c_2$ has higher entropy because it has larger variance — more uncertainty about where a sample will land.
> The nat (natural unit) uses $\ln$ instead of $\log_2$; 1 nat $\approx$ 1.443 bits.
