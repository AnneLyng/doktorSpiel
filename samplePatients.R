gender <- sample(c("Male","Female"),100,replace=TRUE)
age <- rnorm(100,mean=65,sd=10)
hypertension <- sample(c(0,0,0,1),100,replace=TRUE)
diabetes <- sample(c(0,0,0,1),100,replace=TRUE)
vascular <- sample(c(0,0,0,1),100,replace=TRUE)
prestroke <- sample(c(0,0,0,1),100,replace=TRUE)

patients <- data.frame(gender=gender, age=age, hypertension, diabetes=diabetes,
                       vascular=vascular,prestroke=prestroke)
write.table(patients,file="~/Documents/research/doktorSpiel/patients.txt")

