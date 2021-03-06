"population.size.curve"=function(state,data,lag=0){
	X=c((length(data)-36):length(data))

	Y=data[X]
	last.element = data[length(data)]
	model <- lm(Y ~ X)
	newx=c((length(data)+1):(length(data)+(60+lag)))-1
	int = model$coefficients[1]
	coeff1 = ifelse(is.na(model$coefficients[2]),0,model$coefficients[2])
	coeff2 = ifelse(is.na(model$coefficients[3]),0,model$coefficients[3])
	coeff3 = ifelse(is.na(model$coefficients[4]),0,model$coefficients[4])
	coeff4 = ifelse(is.na(model$coefficients[5]),0,model$coefficients[5])
	coeff5 = ifelse(is.na(model$coefficients[6]),0,model$coefficients[6])
	coeff6 = ifelse(is.na(model$coefficients[7]),0,model$coefficients[7])
	newdata2=int+coeff1*newx + coeff2*newx^2 + coeff3*newx^3 +coeff4*newx^4 + coeff5*newx^5 + coeff6*newx^6
	height.adjust = newdata2[1]-last.element
	newdata2 = newdata2 - height.adjust
	
	newdata=c(data,newdata2)
	#plot(as.ts(newdata),col="blue")
	#lines(as.ts(data),col="black")
	first.value = newdata[1]
	sreturn = get.sreturn(newdata)
	#plot(as.ts(sreturn))
	sreturn2 = smoother(cbind(sreturn,sreturn),iterations=1)[,1]
	#plot(as.ts(sreturn2))
	
	newdata = get.orig.data(first.value,sreturn2)
	#plot(as.ts(get.sreturn(newdata)))
structure(list(newdata=newdata,data = data,total=sum(newdata)))

}