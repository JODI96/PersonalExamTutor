# Week 4 — Exercises

**Generiert:** 2026-04-23  
> Versuche alle Aufgaben selbst bevor du `solutions.md` anschaust!

---

# Übungsaufgaben – Woche 4: Machine Learning Basics

---

## Exercise 1 — Overfitting, Underfitting und Modellkapazität

Ein Datenwissenschaftler möchte die Außentemperatur $y$ aus einem Sensorwert $x$ vorhersagen. Er testet drei Modelle:

- **Modell A**: $\hat{y} = w_1 x + b$ (lineare Regression, 2 Parameter)
- **Modell B**: $\hat{y} = w_1 x + w_2 x^2 + w_3 x^3 + b$ (kubisch, 4 Parameter)
- **Modell C**: Polynom 15. Ordnung (16 Parameter)

Er erhält folgende Fehlerwerte:

| Modell | $\text{MSE}_\text{train}$ | $\text{MSE}_\text{test}$ |
|--------|--------------------------|--------------------------|
| A      | 4.80                     | 4.95                     |
| B      | 1.20                     | 1.35                     |
| C      | 0.001                    | 12.70                    |

**(a)** Welches Modell zeigt **Underfitting**, welches **Overfitting**, und welches hat eine **angemessene Kapazität**? Begründe anhand der Tabellenwerte.

**(b)** Erkläre qualitativ, warum unter der i.i.d.-Annahme gilt:
$$\mathbb{E}[\text{MSE}_\text{train}] = \mathbb{E}[\text{MSE}_\text{test}]$$
Warum beobachtet man trotzdem den großen Unterschied bei Modell C?

**(c)** Der Datenwissenschaftler möchte Modell C durch **Weight Decay** (Regularisierung) verbessern. Der neue Trainingsverlust ist:
$$J(\mathbf{w}) = \text{MSE}_\text{train} + \lambda \, \mathbf{w}^\top \mathbf{w}$$
Beschreibe qualitativ, was bei $\lambda = 0$ und bei $\lambda \to \infty$ passiert. Wie beeinflusst $\lambda$ den Bias-Variance-Tradeoff?

**(d)** Um das optimale $\lambda$ zu finden, teilt er seinen Datensatz auf. Welche drei Teilmengen werden benötigt, und welche Rolle spielt jede? Warum darf $\lambda$ **nicht** anhand des Testsets gewählt werden?

---

## Exercise 2 — Bias und Varianz von Schätzern

Gegeben sei eine Menge von $m$ i.i.d. Stichproben $\{x^{(1)}, \ldots, x^{(m)}\}$, die gleichmäßig auf dem Intervall $[0.4,\ 1.8]$ verteilt sind.

**(a)** Berechne den wahren Mittelwert $\mu$ der Verteilung analytisch.

**(b)** Zeige, dass der Stichprobenmittelwert
$$\hat{\mu}_m = \frac{1}{m} \sum_{i=1}^{m} x^{(i)}$$
ein **unverzerrter** Schätzer für $\mu$ ist, d.h. zeige dass $\text{bias}(\hat{\mu}_m) = 0$.

**(c)** Nun wird versehentlich jeder Messwert **quadriert**, bevor der Mittelwert berechnet wird:
$$\tilde{\mu}_m = \frac{1}{m} \sum_{i=1}^{m} \left(x^{(i)}\right)^2$$
Berechne $\mathbb{E}[\tilde{\mu}_m]$ und den **Bias** dieses Schätzers bezüglich $\mu$.

*Hinweis: Für eine Gleichverteilung auf $[a, b]$ gilt $\mathbb{E}[X^2] = \frac{a^2 + ab + b^2}{3}$.*

**(d)** Der Standardfehler des Stichprobenmittelwerts $\hat{\mu}_m$ einer Normalverteilung mit Standardabweichung $\sigma$ beträgt $\sigma / \sqrt{m}$. Was passiert mit dem Standardfehler, wenn die Stichprobengröße von $m = 25$ auf $m = 100$ erhöht wird? Was bedeutet das für die Qualität des Schätzers?

---

## Exercise 3 — Bias-Variance-Tradeoff und MSE-Zerlegung

Ein ML-Modell schätzt einen Parameter $\theta = 3.0$. Zwei Schätzer $\hat{\theta}_A$ und $\hat{\theta}_B$ werden auf vielen unabhängigen Datensätzen ausgewertet und zeigen folgende Eigenschaften:

| Schätzer | $\mathbb{E}[\hat{\theta}]$ | $\text{Var}(\hat{\theta})$ |
|----------|---------------------------|---------------------------|
| $\hat{\theta}_A$ | 3.0 | 0.81 |
| $\hat{\theta}_B$ | 3.6 | 0.16 |

**(a)** Berechne den **Bias** für beide Schätzer:
$$\text{bias}(\hat{\theta}) = \mathbb{E}[\hat{\theta}] - \theta$$

**(b)** Der mittlere quadratische Fehler (MSE) eines Schätzers lässt sich zerlegen als:
$$\text{MSE}(\hat{\theta}) = \text{bias}(\hat{\theta})^2 + \text{Var}(\hat{\theta})$$
Berechne den MSE für beide Schätzer. Welcher Schätzer ist besser geeignet?

**(c)** Ordne die beiden Schätzer konzeptuell einem **Modell mit zu hoher Kapazität** und einem **Modell mit zu niedriger Kapazität** zu. Begründe deine Antwort.

**(d)** Erkläre in eigenen Worten, was **Konsistenz** eines Schätzers bedeutet. Welche zwei Bedingungen müssen erfüllt sein? Sind $\hat{\theta}_A$ und $\hat{\theta}_B$ konsistente Schätzer (ohne Berücksichtigung der Stichprobengröße)?

---

## Exercise 4 — Lineare Regression und analytische Lösung

Gegeben sei ein 1-dimensionaler Datensatz mit $m = 4$ Trainingspunkten:

$$\{(x^{(1)}, y^{(1)})\} = \{(1,\ 2),\ (2,\ 3),\ (3,\ 5),\ (4,\ 6)\}$$

Das Modell sei eine lineare Regression **ohne** Bias-Term: $\hat{y} = w_1 x$.

**(a)** Schreibe den Trainings-MSE explizit als Funktion von $w_1$ auf:
$$\text{MSE}_\text{train}(w_1) = \frac{1}{m} \sum_{i=1}^{m} \left(\hat{y}^{(i)} - y^{(i)}\right)^2$$

**(b)** Berechne die analytische Lösung $\hat{w}_1 = \arg\min_{w_1} \text{MSE}_\text{train}$, indem du den Gradienten berechnest, auf null setzt und nach $w_1$ auflöst.

**(c)** Nun soll ein **Bias-Term** $b$ hinzugefügt werden: $\hat{y} = w_1 x + b$. Beschreibe die Methode, wie dieser Bias-Term in die Designmatrix $\mathbf{X}$ integriert werden kann, sodass das Modell weiterhin als $\hat{y} = \mathbf{w}^\top \mathbf{x}$ geschrieben werden kann. Schreibe die erweiterte Matrix $\mathbf{X}$ für den gegebenen Datensatz auf.

**(d)** Erkläre, warum die analytische Lösung in **Deep Learning** in der Praxis nicht verwendet werden kann, obwohl sie für lineare Regression existiert. Welche Alternative wird stattdessen eingesetzt?