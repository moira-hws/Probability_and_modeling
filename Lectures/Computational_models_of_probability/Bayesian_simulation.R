# prior probability of disease, P(A)
p_disease <- 0.01

# sensitivity: P(B|A) aka true positive
p_true_positive <- 0.95

# specificity: aka true negative
p_true_negative <- .99

# false positive rate: P(B|NOT A)
p_false_positive <- 0.01

# complement of prior probability: P(NOT A)
p_disease_complement = 1 - p_disease

# total ("marginal") probability of a positive test -- this is the denominator
p_positive <- (p_disease * p_true_positive) +
  (p_false_positive* p_disease_complement)

# posterior probability: P(Disease | Positive)
p_disease_given_positive <- (p_pos_given_disease * p_disease) / p_positive

# print the result
round(p_disease_given_positive, 4)


