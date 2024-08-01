function solouno(AM,nq,qk)
######################LINEAR IMPUT
    input=zeros(6)
    resultado=["a","a","a"]
    resultado[1]="a<-c("    ######This is to read in R
    resultado[2]="b<-c("
    resultado[3]="I<-c("



    input[1]=1
    input[2]=10
    input[3]=10
    input[4]=40
    input[5]=0.01
    d2=0.12



    m=10  ######10 total realizations
    #m=100
    p=6

    inputi=zeros(m,7)

    #####Latin Hypercube Sampling

    X=randomLHC(m,p)
    #inputi[:,1]=k1min*(k1max/k1min) .^ (X[:,1]/m)
    #inputi[:,2]=k2min*(k2max/k2min) .^ (X[:,2]/m)
    #inputi[:,3]=nmin*(nmax/nmin) .^ (X[:,3]/m)
    #inputi[:,4]=Kdmin*(Kdmax/Kdmin) .^ (X[:,4]/m)
    #inputi[:,5]=d1min*(d1max/d1min) .^ (X[:,5]/m)
    inputi[:,6]=X[:,6]/m



    for i=1:m
             ####Here one parameter are being varied: p (the mode for the beta distribution)
             input[6]=inputi[i,6]

             I= core(input[1],input[2],input[3],input[4],input[5],d2,AM,nq,input[6],qk)
             inputi[i,7]=I

             resultado[1]=string(resultado[1],inputi[i,6],",")
             resultado[3]=string(resultado[3],inputi[i,7],",")
     end

     resultado[1]=string(chop(resultado[1]),")")
     resultado[3]=string(chop(resultado[3]),")")

     resultado[2]="b<-numeric(length(a))"

    
     return(resultado)
end
