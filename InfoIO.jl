function InfoIO(maxarea,disinput,disarea,Realiz,hinput,houtput)
    if maxarea!=0
        epsilon=0.000001

        histograma=zeros(Int(maximum(disinput))+1,Int(maximum(disarea))+1)
        probabilidadinput=zeros(Int(maximum(disinput))+1,1)
        probabilidadoutput=zeros(Int(maximum(disarea))+1,1)
        probabilidadinputoutput=zeros(Int(maximum(disinput))+1,Int(maximum(disarea))+1)

        for i in 1:length(disinput)
            histograma[Int(disinput[i])+1,Int(disarea[i])+1]+=1
        end

        #histograma[histograma.<2].=0 ###this eliminates outliers

        for j in 1:size(histograma,2)
            probabilidadoutput[j]=sum(histograma[:,j])/sum(histograma)
        end
   
        for k in 1:size(histograma,1)
            probabilidadinput[k]=sum(histograma[k,:])/sum(histograma)
        end
        
        probabilidadinputoutput=histograma/sum(histograma)
        #Hinput=log(hinput)
        ########Maximum Likelihood
        HinputML=-sum(probabilidadinput.*log.(probabilidadinput.+epsilon))
        HareaML=-sum(probabilidadoutput.*log.(probabilidadoutput.+epsilon))
        HambasML=-sum(probabilidadinputoutput.*log.(probabilidadinputoutput.+epsilon))

        #println(Hinput/log(2),"\n",HareaML/log(2),"\n",HambasML/log(2),"\n",(Hinput+HareaML-HambasML)/log(2))
        IML=(HinputML+HareaML-HambasML)/log(2)
        IMM=0.0###outdated calculation
    else
        IML=0.0
        IMM=0.0
    end
    I=[IML,IMM]
    return(I)
end

