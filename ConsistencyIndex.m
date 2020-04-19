function confidenceInterval=ConsistencyIndex(A)
RI=[0 0 .58 .9 1.12 1.24 1.32 1.41 1.45];%defining the Random Index
row = prod(A,2).^(1/3);%taking the third root of the products of the rows
thirdRoot=sum(row);%taking the sum of row
priorityVector=row/thirdRoot;%dividing row by third root to get the priority vector
column = sum(A,1);%summing the columns
lambdaMax=sum(column*priorityVector);%multiplying the column by the priority vector
consistencyIndex=abs((lambdaMax-length(A))/(length(A)-1));%finding the consistency index
confidenceInterval=consistencyIndex/RI(length(A));%dividing the consistency index by the random index
end
