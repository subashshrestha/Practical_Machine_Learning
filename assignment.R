a=read.csv('pml-training.csv',na.strings=c('','NA'))
b=a[,!apply(a,2,function(x) any(is.na(x)) )]
c=b[,-c(1:7)]
install.packages('randomForest')
library('randomForest')
install.packages('caret')
library('caret')
install.packages('e1071')
library('e1071')
subGrps=createDataPartition(y=c$classe, p=0.6, list=FALSE)
subTraining=c[subGrps,]
subTesting=c[-subGrps, ]
dim(subTraining);dim(subTesting)

model=randomForest(classe~., data=subTraining, method='class')
pred=predict(model,subTesting, type='class')
z=confusionMatrix(pred,subTesting$classe)
save(z,file='test.RData')

load(test.RData)
z$table

z$overall[1]
dim(c)

d=read.csv('pml-testing.csv',na.strings=c('','NA'))
e=d[,!apply(d,2,function(x) any(is.na(x)) )]
f=e[,-c(1:7)]
dim(f)

predicted=predict(model,f,type='class')
save(predicted,file='predicted.RData')
load('predicted.RData')

predicted
