# Week 4 — Solutions

**Generiert:** 2026-04-23  
> Nur lesen nachdem du die Aufgaben ernsthaft versucht hast!

---

# Musterlösungen – Woche 4: Machine Learning Basics

---

## Exercise 1 — Overfitting, Underfitting und Modellkapazität

### (a) Klassifikation der Modelle

**Step 1 —** Analyse von Modell A (lineare Regression, 2 Parameter)

Wie in der Vorlesung besprochen: Underfitting liegt vor, wenn die Trainingskapazität zu klein ist, um die Daten zu beschreiben – erkennbar an **großen Fehlern in Training UND Test**.

$$\text{MSE}_\text{train}^{(A)} = 4.80, \quad \text{MSE}_\text{test}^{(A)} = 4.95$$

Beide Fehler sind groß, der Gap ist klein ($\Delta = 0.15$). Das Modell ist zu simpel, um die zugrunde liegende Datengenerierungsverteilung $p_\text{data}$ zu erfassen.

$$\boxed{\text{Modell A} \Rightarrow \textbf{Underfitting}}$$

**Step 2 —** Analyse von Modell B (kubisch, 4 Parameter)

$$\text{MSE}_\text{train}^{(B)} = 1.20, \quad \text{MSE}_\text{test}^{(B)} = 1.35$$

Kleiner Trainingsfehler, kleiner Testfehler, kleiner Gap ($\Delta = 0.15$). Die Kapazität passt zur Komplexität der Daten.

$$\boxed{\text{Modell B} \Rightarrow \textbf{Angemessene Kapazität}}$$

**Step 3 —** Analyse von Modell C (Polynom 15. Ordnung, 16 Parameter)

$$\text{MSE}_\text{train}^{(C)} = 0.001, \quad \text{MSE}_\text{test}^{(C)} = 12.70$$

Trainingsfehler nahezu null, aber enormer Gap ($\Delta = 12.699$). Das Modell hat die Trainingsdaten auswendig gelernt, generalisiert aber nicht.

$$\boxed{\text{Modell C} \Rightarrow \textbf{Overfitting}}$$

---

### (b) i.i.d.-Annahme und der beobachtete Unterschied

**Step 1 —** Erklärung der i.i.d.-Gleichheit

Wie in der Vorlesung besprochen gelten zwei Annahmen:
- **Independent**: Die Datenpunkte sind unabhängig voneinander
- **Identically distributed**: Training- und Testdaten stammen aus der **gleichen** Verteilung $p_\text{data}(x)$

Da beide Datensätze aus der identischen Verteilung gezogen werden, gilt für den **Erwartungswert** (gemittelt über alle möglichen Datensätze):

$$\mathbb{E}[\text{MSE}_\text{train}] = \mathbb{E}[\text{MSE}_\text{test}]$$

**Step 2 —** Erklärung des beobachteten Gaps bei Modell C

Die Gleichung gilt für den **Erwartungswert über alle möglichen Trainingssets**. In der Praxis:

- Der Optimierungsalgorithmus minimiert **aktiv** den $\text{MSE}_\text{train}$ auf dem **spezifischen** Trainingsdatensatz
- Ein Modell mit zu hoher Kapazität (16 Parameter für wenige Datenpunkte) lernt die **zufälligen Besonderheiten** und das **Rauschen** des Trainingsdatensatzes
- Diese zufälligen Besonderheiten sind im Testset **nicht** vorhanden

$$\boxed{\text{Das Modell memorisiert die Trainingsdaten statt die wahre } p_\text{data} \text{ zu lernen}}$$

---

### (c) Weight Decay und Bias-Variance-Tradeoff

**Step 1 —** Analyse des regularisierten Verlustes

$$J(\mathbf{w}) = \underbrace{\text{MSE}_\text{train}}_{\text{Datenanpassung}} + \underbrace{\lambda \, \mathbf{w}^\top \mathbf{w}}_{\text{Regularisierung}}$$

**Step 2 —** Grenzfälle analysieren (wie in der Vorlesung, Tabelle zu Weight Decay)

| $\lambda$ | Kapazität | Begründung |
|-----------|-----------|------------|
| $\lambda = 0$ | Hoch | Keine Regularisierung, Modell C verhält sich wie zuvor: Overfitting |
| $\lambda \to \infty$ | $\approx 0$ | $\mathbf{w}^\top \mathbf{w}$ muss $\to 0$, alle Gewichte werden gegen null gezwungen, massive Underfitting |

**Step 3 —** Einfluss auf den Bias-Variance-Tradeoff

Wie in der Vorlesung (Fig. 5.6) besprochen:

$$\text{MSE}(\hat{\theta}) = \underbrace{\text{bias}(\hat{\theta})^2}_{\uparrow \text{ mit } \lambda} + \underbrace{\text{Var}(\hat{\theta})}_{\downarrow \text{ mit } \lambda}$$

$$\boxed{\lambda \uparrow \;\Rightarrow\; \text{Bias} \uparrow, \; \text{Varianz} \downarrow \quad \text{(und umgekehrt für } \lambda \downarrow \text{)}}$$

Es gibt ein **optimales** $\lambda$, das den Gesamtfehler (Generalisierungsfehler) minimiert.

---

### (d) Datensatz-Aufteilung und Rolle des Validierungssets

**Step 1 —** Die drei benötigten Teilmengen (aus der Vorlesung: "A third dataset is required")

| Teilmenge | Typischer Anteil | Verwendung |
|-----------|-----------------|------------|
| **Training** | 60% | Lernen der Parameter $\mathbf{w}$ durch Minimierung von $J(\mathbf{w})$ |
| **Validation** | 20% | Wahl des Hyperparameters $\lambda$, **nicht** Teil des Lernens von $\mathbf{w}$ |
| **Test** | 20% | **Einmalige** Schätzung des Generalisierungsfehlers am Ende |

**Step 2 —** Warum $\lambda$ **nicht** am Testset gewählt werden darf

Wie in der Vorlesung definiert: "Hyperparameters are parameters that are **not learned** by the algorithm." Der Testfehler ist unser **unabhängiger Schätzer** des echten Generalisierungsfehlers.

Würde man $\lambda$ anhand des Testsets optimieren:
- Der Testfehler würde **unterschätzen** was auf echten neuen Daten passiert
- Das Testset wäre "verbraucht" – es kann nicht mehr als unabhängiger Schätzer dienen
- Man würde effektiv auf dem Testset **trainieren** (auf $\lambda$)

$$\boxed{\text{Testset wird exakt \textbf{einmal} verwendet – zur finalen Bewertung, nie zur Selektion}}$$

---

## Exercise 2 — Bias und Varianz von Schätzern

### (a) Wahrer Mittelwert der Gleichverteilung

**Step 1 —** Identifikation der Verteilung

Die Stichproben sind gleichverteilt auf $[a, b] = [0.4,\ 1.8]$, also:

$$p(x^{(i)}) = \begin{cases} \frac{1}{b-a} = \frac{1}{1.4}, & 0.4 \leq x^{(i)} \leq 1.8 \\ 0, & \text{sonst} \end{cases}$$

**Step 2 —** Berechnung des Erwartungswerts (Integral)

$$\mu = \int_{0.4}^{1.8} x \cdot \frac{1}{1.4} \, dx = \frac{1}{1.4} \cdot \left[\frac{x^2}{2}\right]_{0.4}^{1.8}$$

$$= \frac{1}{1.4} \cdot \frac{1.8^2 - 0.4^2}{2} = \frac{1}{1.4} \cdot \frac{3.24 - 0.16}{2} = \frac{1}{1.4} \cdot \frac{3.08}{2} = \frac{3.08}{2.8}$$

**Step 3 —** Vereinfachung mit der Formel für die Gleichverteilung

$$\mu = \frac{a + b}{2} = \frac{0.4 + 1.8}{2} = \frac{2.2}{2}$$

$$\boxed{\mu = 1.1}$$

---

### (b) Unverzerrter Schätzer: Stichprobenmittelwert

**Step 1 —** Berechnung des Erwartungswertes von $\hat{\mu}_m$

Wie in der Vorlesung beim Bernoulli- und Gaußbeispiel: Linearität des Erwartungswertes verwenden.

$$\mathbb{E}[\hat{\mu}_m] = \mathbb{E}\left[\frac{1}{m} \sum_{i=1}^{m} x^{(i)}\right] = \frac{1}{m} \sum_{i=1}^{m} \mathbb{E}\left[x^{(i)}\right]$$

**Step 2 —** Da alle Stichproben i.i.d. sind, gilt $\mathbb{E}[x^{(i)}] = \mu = 1.1$ für jedes $i$:

$$\mathbb{E}[\hat{\mu}_m] = \frac{1}{m} \sum_{i=1}^{m} \mu = \frac{1}{m} \cdot m \cdot \mu = \mu = 1.1$$

**Step 3 —** Berechnung des Bias (Definition aus der Vorlesung):

$$\text{bias}(\hat{\mu}_m) = \mathbb{E}[\hat{\mu}_m] - \mu = 1.1 - 1.1 = 0$$

$$\boxed{\text{bias}(\hat{\mu}_m) = 0 \;\Rightarrow\; \hat{\mu}_m \text{ ist ein \textbf{unverzerrter} Schätzer für } \mu}$$

---

### (c) Verzerrter Schätzer: quadrierte Messwerte

**Step 1 —** Berechnung von $\mathbb{E}[\tilde{\mu}_m]$ mit Linearität des Erwartungswertes

$$\mathbb{E}[\tilde{\mu}_m] = \mathbb{E}\left[\frac{1}{m} \sum_{i=1}^{m} \left(x^{(i)}\right)^2\right] = \frac{1}{m} \sum_{i=1}^{m} \mathbb{E}\left[\left(x^{(i)}\right)^2\right] = \mathbb{E}\left[X^2\right]$$

**Step 2 —** Anwendung des gegebenen Hinweises für die Gleichverteilung auf $[a, b]$:

$$\mathbb{E}[X^2] = \frac{a^2 + ab + b^2}{3} = \frac{(0.4)^2 + (0.4)(1.8) + (1.8)^2}{3}$$

$$= \frac{0.16 + 0.72 + 3.24}{3} = \frac{4.12}{3}$$

$$\mathbb{E}[\tilde{\mu}_m] = \frac{4.12}{3} \approx 1.3733$$

**Step 3 —** Berechnung des Bias:

$$\text{bias}(\tilde{\mu}_m) = \mathbb{E}[\tilde{\mu}_m] - \mu = \frac{4.12}{3} - 1.1 = \frac{4.12}{3} - \frac{3.3}{3} = \frac{0.82}{3}$$

$$\boxed{\text{bias}(\tilde{\mu}_m) = \frac{0.82}{3} \approx 0.2733 \;\Rightarrow\; \tilde{\mu}_m \text{ ist ein \textbf{verzerrter} Schätzer}}$$

Der Schätzer überschätzt $\mu$ systematisch, weil $\mathbb{E}[X^2] \geq (\mathbb{E}[X])^2$ (Jensen's Ungleichung).

---

### (d) Standardfehler und Stichprobengröße

**Step 1 —** Berechnung für $m = 25$

$$\text{SE}_{25} = \frac{\sigma}{\sqrt{25}} = \frac{\sigma}{5}$$

**Step 2 —** Berechnung für $m = 100$

$$\text{SE}_{100} = \frac{\sigma}{\sqrt{100}} = \frac{\sigma}{10}$$

**Step 3 —** Vergleich der beiden Standardfehler

$$\frac{\text{SE}_{100}}{\text{SE}_{25}} = \frac{\sigma/10}{\sigma/5} = \frac{1}{2}$$

Der Standardfehler **halbiert** sich, wenn die Stichprobengröße vervierfacht wird ($m: 25 \to 100$).

**Step 4 —** Bedeutung für die Schätzerqualität

Wie in der Vorlesung besprochen ("the more samples used for estimating the sample mean, the smaller its standard error"):

$$\boxed{\text{SE} = \frac{\sigma}{\sqrt{m}} \xrightarrow{m \to \infty} 0 \;\Rightarrow\; \text{Mehr Daten} = \text{zuverlässigerer Schätzer mit geringerer Streuung}}$$

---

## Exercise 3 — Bias-Variance-Tradeoff und MSE-Zerlegung

### (a) Bias beider Schätzer

**Step 1 —** Definition des Bias aus der Vorlesung:

$$\text{bias}(\hat{\theta}) = \mathbb{E}[\hat{\theta}] - \theta, \quad \theta = 3.0$$

**Step 2 —** Bias von $\hat{\theta}_A$:

$$\text{bias}(\hat{\theta}_A) = \mathbb{E}[\hat{\theta}_A] - \theta = 3.0 - 3.0 = 0$$

**Step 3 —** Bias von $\hat{\theta}_B$:

$$\text{bias}(\hat{\theta}_B) = \mathbb{E}[\hat{\theta}_B] - \theta = 3.6 - 3.0 = 0.6$$

$$\boxed{\text{bias}(\hat{\theta}_A) = 0 \quad (\text{unverzerrt}), \qquad \text{bias}(\hat{\theta}_B) = 0.6 \quad (\text{verzerrt})}$$

---

### (b) MSE-Zerlegung und Vergleich

**Step 1 —** Anwendung der Zerlegungsformel (aus der Vorlesung):

$$\text{MSE}(\hat{\theta}) = \text{bias}(\hat{\theta})^2 + \text{Var}(\hat{\theta})$$

**Step 2 —** MSE für $\hat{\theta}_A$:

$$\text{MSE}(\hat{\theta}_A) = (0)^2 + 0.81 = 0 + 0.81$$

$$\boxed{\text{MSE}(\hat{\theta}_A) = 0.81}$$

**Step 3 —** MSE für $\hat{\theta}_B$:

$$\text{MSE}(\hat{\theta}_B) = (0.6)^2 + 0.16 = 0.36 + 0.16$$

$$\boxed{\text{MSE}(\hat{\theta}_B) = 0.52}$$

**Step 4 —** Vergleich und Schlussfolgerung

| Schätzer | Bias | Bias² | Varianz | MSE |
|----------|------|-------|---------|-----|
| $\hat{\theta}_A$ | 0 | 0 | 0.81 | **0.81** |
| $\hat{\theta}_B$ | 0.6 | 0.36 | 0.16 | **0.52** |

Obwohl $\hat{\theta}_B$ verzerrt ist, hat er einen **kleineren Gesamt-MSE**. Der Bias-Variance-Tradeoff zeigt: Ein leicht verzerrter Schätzer mit viel kleinerer Varianz kann insgesamt besser sein.

$$\boxed{\hat{\theta}_B \text{ ist trotz Bias besser geeignet, da MSE}(\hat{\theta}_B) = 0.52 < 0.81 = \text{MSE}(\hat{\theta}_A)}$$

---

### (c) Zuordnung zu Modellkapazitäten

**Step 1 —** Konzeptuelle Einordnung (aus der Vorlesung, Fig. 5.6)

Wie in der Vorlesung: "Low capacity → high bias but low variance" und "High capacity → low bias but high variance".

| Schätzer | Bias | Varianz | Analogie |
|----------|------|---------|---------|
| $\hat{\theta}_A$ | niedrig (= 0) | **hoch** (0.81) | **Zu hohe Kapazität** (Overfitting) |
| $\hat{\theta}_B$ | **hoch** (0.6) | niedrig (0.16) | **Zu niedrige Kapazität** (Underfitting) |

$$\boxed{\hat{\theta}_A \leftrightarrow \text{zu hohe Kapazität (hohe Varianz, kein Bias)}, \quad \hat{\theta}_B \leftrightarrow \text{zu niedrige Kapazität (hoher Bias, geringe Varianz)}}$$

---

### (d) Konsistenz eines Schätzers

**Step 1 —** Definition aus der Vorlesung

Ein Schätzer ist **konsistent**, wenn er mit unendlich vielen Daten exakt den wahren Parameter liefert. Formal: $\hat{\theta}_m \xrightarrow{p} \theta$ für $m \to \infty$.

**Step 2 —** Zwei notwendige Bedingungen (aus der Vorlesung):

$$\text{Bedingung 1: (asymptotisch) unverzerrt} \Rightarrow \text{bias}(\hat{\theta}_m) \xrightarrow{m\to\infty} 0$$

$$\text{Bedingung 2: Standardfehler geht gegen 0} \Rightarrow \text{Var}(\hat{\theta}_m) \xrightarrow{m\to\infty} 0$$

**Step 3 —** Konsistenz von $\hat{\theta}_A$ und $\hat{\theta}_B$ ohne Berücksichtigung der Stichprobengröße

Die Tabelle gibt **feste** Bias- und Varianzwerte unabhängig von $m$:

- $\hat{\theta}_A$: Bias = 0 ✓, aber Var = 0.81 ist konstant (geht nicht gegen 0) ✗
- $\hat{\theta}_B$: Bias = 0.6 (geht nicht gegen 0) ✗, Var = 0.16 ist konstant ✗

$$\boxed{\text{Weder } \hat{\theta}_A \text{ noch } \hat{\theta}_B \text{ sind (so angegeben) konsistente Schätzer}}$$

---

## Exercise 4 — Lineare Regression und analytische Lösung

### (a) Trainings-MSE als Funktion von $w_1$

**Step 1 —** Einsetzen der Datenpunkte und der Modellvorhersage $\hat{y}^{(i)} = w_1 x^{(i)}$

$$\text{MSE}_\text{train}(w_1) = \frac{1}{4} \sum_{i=1}^{4} \left(w_1 x^{(i)} - y^{(i)}\right)^2$$

**Step 2 —** Explizites Ausschreiben aller vier Terme:

$$\text{MSE}_\text{train}(w_1) = \frac{1}{4}\Big[(w_1 \cdot 1 - 2)^2 + (w_1 \cdot 2 - 3)^2 + (w_1 \cdot 3 - 5)^2 + (w_1 \cdot 4 - 6)^2\Big]$$

$$\boxed{\text{MSE}_\text{train}(w_1) = \frac{1}{4}\left[(w_1 - 2)^2 + (2w_1 - 3)^2 + (3w_1 - 5)^2 + (4w_1 - 6)^2\right]}$$

---

### (b) Analytische Lösung durch Gradientenberechnung

**Step 1 —** Gradient berechnen (wie in der Vorlesung: "Calculate gradient, set to 0, solve for w")

Zunächst ausmultiplizieren im Zähler (ohne den Faktor $\frac{1}{4}$):

$$\frac{d}{dw_1}\left[(w_1-2)^2\right] = 2(w_1 - 2) \cdot 1$$

$$\frac{d}{dw_1}\left[(2w_1-3)^2\right] = 2(2w_1 - 3) \cdot 2$$

$$\frac{d}{dw_1}\left[(3w_1-5)^2\right] = 2(3w_1 - 5) \cdot 3$$

$$\frac{d}{dw_1}\left[(4w_1-6)^2\right] = 2(4w_1 - 6) \cdot 4$$

**Step 2 —** Gradient aufstellen:

$$\frac{d\,\text{MSE}_\text{train}}{dw_1} = \frac{1}{4}\Big[2(w_1-2) + 4(2w_1-3) + 6(3w_1-5) + 8(4w_1-6)\Big]$$

$$= \frac{1}{4}\Big[2w_1 - 4 + 8w_1 - 12 + 18w_1 - 30 + 32w_1 - 48\Big]$$

$$= \frac{1}{4}\Big[(2+8+18+32)w_1 - (4+12+30+48)\Big]$$

$$= \frac{1}{4}\Big[60\,w_1 - 94\Big]$$

**Step 3 —** Gradient gleich null setzen und nach $w_1$ auflösen:

$$\frac{1}{4}(60\,w_1 - 94) = 0$$

$$60\,w_1 = 94$$

$$w_1 = \frac{94}{60} = \frac{47}{30}$$

$$\boxed{\hat{w}_1 = \frac{47}{30} \approx 1.567}$$

---

### (c) Integration des Bias-Terms in die Designmatrix

**Step 1 —** Motivation (aus der Vorlesung: "add a column of 1's to X instead")

Das Modell $\hat{y} = w_1 x + b$ hat zwei Parameter. Um die einheitliche Vektornotation $\hat{y} = \mathbf{w}^\top \mathbf{x}$ beizubehalten, wird der Parametervektor erweitert:

$$\mathbf{w} = \begin{pmatrix} w_1 \\ b \end{pmatrix}, \qquad \tilde{\mathbf{x}}^{(i)} = \begin{pmatrix} x^{(i)} \\ 1 \end{pmatrix}$$

**Step 2 —** Konstruktion der erweiterten Designmatrix $\mathbf{X}$

Jede Zeile entspricht einem Datenpunkt $(x^{(i)}, 1)$:

$$\mathbf{X} = \begin{pmatrix} x^{(1)} & 1 \\ x^{(2)} & 1 \\ x^{(3)} & 1 \\ x^{(4)} & 1 \end{pmatrix} = \begin{pmatrix} 1 & 1 \\ 2 & 1 \\ 3 & 1 \\ 4 & 1 \end{pmatrix}$$

$$\boxed{\mathbf{X} = \begin{pmatrix} 1 & 1 \\ 2 & 1 \\ 3 & 1 \\ 4 & 1 \end{pmatrix}, \quad \mathbf{w} = \begin{pmatrix} w_1 \\ b \end{pmatrix} \;\Rightarrow\; \hat{\mathbf{y}} = \mathbf{X}\mathbf{w}}$$

---

### (d) Warum analytische Lösung in Deep Learning nicht praktikabel ist

**Step 1 —** Warum sie für lineare Regression funktioniert

Für lineare Regression ist $\text{MSE}_\text{train}(w_1)$ eine **quadratische, konvexe** Funktion in $w_1$. Der Gradient ist linear in $w_1$, das Gleichungssystem hat eine **eindeutige, geschlossene Lösung**:

$$\hat{\mathbf{w}} = (\mathbf{X}^\top \mathbf{X})^{-1} \mathbf{X}^\top \mathbf{y}$$

**Step 2 —** Warum das in Deep Learning scheitert (aus der Vorlesung: "Note: in DL, this is not possible!")

| Problem | Erklärung |
|---------|-----------|
| **Nicht-Linearität** | Aktivierungsfunktionen (ReLU, Sigmoid) machen den Verlust **nicht-konvex** → kein lineares Gleichungssystem lösbar |
| **Dimensionalität** | Moderne Netze haben $10^6$–$10^{12}$ Parameter → Matrix $\mathbf{X}^\top\mathbf{X}$ wäre gigantisch und nicht invertierbar |
| **Datenvolumen** | Mit Millionen Datenpunkten ist die Matrix $\mathbf{X}$ nicht mehr in den Speicher zu laden |

**Step 3 —** Die verwendete Alternative

Wie in der Vorlesung: **Gradient Descent** (und insbesondere **Stochastic Gradient Descent**):

$$\mathbf{w} \leftarrow \mathbf{w} - \eta \cdot \nabla_\mathbf{w} J(\mathbf{w})$$

$$\boxed{\text{In Deep Learning: Gradient Descent statt analytischer Lösung, da } J(\mathbf{w}) \text{ nicht-konvex und hochdimensional ist}}$$