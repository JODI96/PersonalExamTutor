# Week 2 — Exercises

**Topic:** Probability and Information Theory
**Source:** Deep Learning (Goodfellow, Bengio, Courville) — Lesson 2, Chapter 3
**Date:** 2026-02-23

> Try all exercises before looking at `solutions.md`!

---

## Exercise 1 — Bernoulli Distribution

Given a Bernoulli distributed random variable $x$ with $P(x = 1) = \frac{3}{4}$ and $P(x = 0) = \frac{1}{4}$.

**(a)** Sketch the probability mass function $P_x(x)$.

**(b)** Find the expected value of $x$, i.e. $\mathbb{E}_x[x]$.

**(c)** Find the variance of $x$, i.e. $\text{Var}_x(x)$.

---

## Exercise 2 — Uniform Distribution (Continuous)

Given a uniformly distributed continuous random variable $x$ between $-0.5$ and $1$.

**(a)** Sketch the probability density function $f_x(x)$.

**(b)** Find the expected value of $x$, i.e. $\mathbb{E}_x[x]$.

**(c)** Find the variance of $x$, i.e. $\text{Var}_x(x)$.

---

## Exercise 3 — Bayes' Theorem (Cab Problem)

There are 5000 yellow and 100 red cabs in a city. In a hit-and-run accident, a witness saw a red cab. What is the probability that it was actually a red cab, given that witnesses state the car's colour correctly in 95% of cases?

---

## Exercise 4 — Classification with Naive Bayes

Given are the following sets of samples from two different classes $c_1$ and $c_2$:

$$S_1 = \{5.3,\ 5.7,\ 6.1,\ 6.3,\ 6.6\}, \qquad S_2 = \{6.2,\ 6.5,\ 6.9,\ 7.7,\ 8.0,\ 8.3,\ 8.9\}$$

**(a)** Estimate the mean and variance of both classes. Sketch their PDFs assuming the samples are normally distributed.

Recall:
$$m = \frac{1}{N}\sum_{i=1}^{N} x_i \qquad \sigma^2 = \frac{1}{N-1}\sum_{i=1}^{N}(x_i - m)^2$$

**(b)** Estimate the prior probabilities $P(y = c_i)$ for both classes.

**(c)** Assign the new samples $x_1 = 5$ and $x_2 = 7$ to the class with the highest posterior probability.

Recall the Gaussian PDF:
$$p(x \mid y = c_i) = \sqrt{\frac{1}{2\pi\sigma_i^2}} \exp\!\left(-\frac{(x - m_i)^2}{2\sigma_i^2}\right)$$

**(d)** Calculate the entropy $H(x \mid y)$ of $x$ given $y = c_1$ and $y = c_2$ respectively.

Recall the entropy of a Gaussian:
$$H(x) = \frac{1}{2}\left(\log(2\pi\sigma^2) + 1\right)$$
