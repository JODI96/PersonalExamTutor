# Week 10 — Exercises

> Quelle: DATANA_03_EX_Preprocessing_Part_2(2).pptx, DATANA_10_EX_Preprocessing_Pt2_Pt3.pdf, DATANA_10_EX_LSG_Preprocessing_Pt2_Pt3_Solution.pdf

---

--- Folie 1 ---
Preprocessing & Visualization (2) Exercises
6 May 2026
Studiengang Wirtschaftsingenieurwesen
Exercises in Data Science
Prof Dr. Daniel P. Politze

--- Folie 2 ---
Binning
Given Dataset: 13,20,22,36,45,54,61,64,70 (n = 9)
Smoothing by bin means (bin depth of 3): 1. Sort dataset2. Divide data into groups (of the size of the bin depth).3. Calculate the average of the groups.
Solution dataset (rounded): 18, 18, 18, 45, 45, 45, 65, 65, 65
What is the purpose of smoothing?
The goal is to reduce the impact of outliers and "smooth" the data.
Fluctuations are reduced, and trends become more visible
6 May 2026
2

--- Folie 3 ---
Correlation
6 May 2026
3
Calculate the correlation coefficient: Calculate the mean of the X valuesCalculate the mean of the Y values
Calculation of differences:

--- Folie 4 ---
Correlation
6 May 2026
4
Product of Differences:  


Squares of Differences



Substituting into the formula:

--- Folie 5 ---
What can be said about this graph?
Positive Correlation
The two numbers do show a correlation, but one does not explain the other
Correlation ≠ Causality
What would a negative correlation look like?
6 May 2026
5

--- Folie 6 ---
Chi Square
6 May 2026
6
OST wants to determine whether there is a relationship between the field of study and the preferred mode of commuting to OST. For this purpose, 200 students were surveyed.

--- Folie 7 ---
Chi Square
6 May 2026
7
= The observed value in the cell
       = The expected value in the cell
     = Number of columns in the table
     = Number of rows in the table

--- Folie 8 ---
Chi Square
6 May 2026
8
Calculate the sums of rows and columns

--- Folie 9 ---
Chi Square
6 May 2026
9

--- Folie 10 ---
Chi Square
6 May 2026
10

--- Folie 11 ---
Chi Square
6 May 2026
11
Degrees of freedom  =					 r = rows, c = columns
(3-1) * (2-1) = 2
Compare value for alpha = 0.05  9 > 5.991
Null hypothesis is rejected  There is a relationship between the field of study and the mode of transportation

--- Folie 12 ---
6. Mai 2026
12
Min-Max Normalization
Normalization

--- Folie 13 ---
6. Mai 2026
13
Normalization by Decimal Scaling

--- Folie 14 ---
6. Mai 2026
14
Z-Score Normalization

--- Folie 15 ---
6. Mai 2026
15
Z-Score Normalisierung

--- Folie 16 ---
6. Mai 2026
16
Discretization
Do an equidepth binning on the attribute Age. When done the attribute should hold just 3 distinct values. Decide on meaningful labels for the created bins. Always specify the bins' lower and upper boundaries.

How should we start?

--- Folie 17 ---
6. Mai 2026
17
Discretization
Making 3 Bins with same depth  {7,7,8,9},{11,12,13,22}{22,36,38,64}
Proposing Label for each bin  Children, Youths, Adults
What do we do if new data comes in? Example Age 10 or 22 ?

--- Folie 18 ---
6. Mai 2026
18
Discretization
Make sure that there are no gaps between the bins
Make sure that there are no overlaps between the bins.
0-10
11-21
>21
Children
Youths
Adults

--- Folie 19 ---
6. Mai 2026
19
Discretization
How do an equiwidth binning on the attribute Age – again with 3 bins. What would be meaningful labels for the bins this time? Again specify the bins' lower and upper boundaries.

How do we start?

--- Folie 20 ---
6. Mai 2026
20
Discretization

--- Folie 21 ---
6. Mai 2026
21
Discretization
Make sure that there are no gaps between the bins
Make sure that there are no overlaps between the bins.
0-25
26-45
>45
Children
Youths
Adults

--- Folie 22 ---
22
Stratified Sampling
Use a sample size of 5 and the strata “youth”, “middle-aged” and “senior”. Assume that everyone belongs to the category youth who’s in the range of 0-19, for the group middle aged everyone in the range of 20-51 and everyone above 51 is categorized as senior. 
Given Dataset: 13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25, 30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70

How do we start?
Data Reduction
6. Mai 2026

--- Folie 23 ---
6. Mai 2026
23
Stratified Sampling
Categorize the data:
Youth  (13,15,16,16,19) 5 valuesMiddle-Aged  (20,20,21,22,22,25,25,25,25,30,33,33,35,35,35,35,36,40,45,46) 20 ValuesSenior  (52,70) 2 Values
How do we know much samples we have to take from each category?

--- Folie 24 ---
6. Mai 2026
24
Stratified Sampling

---

 
 
Informatik 
 
 
Übungsunterlagen zu Data Analytics 
Prof. Dr. Daniel Politze 
 
Data Analytics – Theoretical Exercises 
FS 2025 
Seite 1 
 
Theoretical Exercises – Sheet 2 
 
 
1. Recap the values for the attribute age from Exercise Sheet 2. The data tuples were 13, 15, 16, 16, 19, 20, 
20, 21, 22, 22, 25, 25, 25, 25, 30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70 (in increasing order). 
 
a. Use smoothing by bin means (use a bin of depth 3) 
 
b. What is the effect of smoothing for the given data? 
 
c. What other methods are there for smoothing? 
 
d. How might you determine outliers in the data? 
 
2. Suppose that a hospital tested the age and the glucose level data for 6 randomly selected adults as follows: 
 
age
43 
21 
25 
42 
57 
59 
glucose
99 
65 
79 
75 
87 
81 
 
a. Draw a scatter plot based on these two attributes. 
 
b. Calculate the correlation coefficient by hand and interpret the result. 
 
3. Given is the following data that shows the observed number of fines in relation to the size of the car: 
 
Carsize
NrOfFines
Compact 
Luxury 
1 or less 
30 
0 
2 or 3 
20 
10 
more than 3 
10 
30 
 
Excerpt from a chi-square distribution table: 
 
 
 
a. Calculate the marginal distributions and the expected values if Carsize and NoOfFines would be 
independent. 
 
b. Check if Carsize and NrOfFines depend on each other (use DOF = 2, α=0.1) 
 
 
 
 

 
 
Informatik 
 
 
Übungsunterlagen zu Data Analytics 
Prof. Dr. Daniel Politze 
 
Data Analytics – Theoretical Exercises 
FS 2025 
Seite 2 
 
4. Shortly discuss issues to consider when merging data from different sources. 
 
5. What are the value ranges of the following normalization methods? 
 
a. min-max normalization 
 
b. normalization by decimal scaling 
 
c. z-score normalization 
 
6. Remember the data for the attribute age. The age values for the data tuples are:  
13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25, 30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70 
(in increasing order). 
 
a. Use min-max normalization to transform the value 35 for age onto the range [0,1] and [-1,1] 
 
b. Use normalization by decimal scaling to transform the value of 35. 
 
c. Use z-score normalization to transform the value of 35, where the standard deviation of age is 12.94 
 
d. Comment on which normalization method you would prefer to use for the given data and why. 
 
 
7. Why do we need normalization what is the difference in normalization instead of just keeping the data in its 
base format? 
 
8. Theme park visitors have been recorded as by various criteria including their age: 
 
No
1 
2 
3 
4 
5 
6 
7 
8 
9 
10 
11 
12 
Age
7 
22 
9 
12 
22 
36 
11 
13 
38 
64 
7 
8 
 
a. Do an equidepth binning on the attribute Age. When done the attribute should hold just 3 distinct values. 
Decide on meaningful labels for the created bins. Always specify the bins' lower and upper boundaries. 
 
b. Now do an equiwidth binning on the attribute Age – again with 3 bins. What would be meaningful labels 
for the bins this time? Again specify the bins' lower and upper boundaries. 
 
c. Which discrete value for the attribute "Age" will the following unknown instances get assigned? 
 
Age
equidepth
equiwidth
8 years 
 
 
10 years 
 
 
22 years 
 
 
45 years 
 
 
6 years 
 
 
70 years 
 
 
 
 
9. Use the data from exercise 3 and sketch examples of each of the following sample techniques: SRSWOR, 
SRSWR and stratified sampling. Use a sample size of 5 and the strata “youth”, “middle-aged” and “senior”. 
 
 
 
