using Random
using LsqFit
using SpecialFunctions
include("jfijoT.jl")
include("InfoIOJN.jl")


function core(k1,k2,n,Kd,d1,d2,AM,nq,q,qk)                                  
############mutual information between input and output. The input is run LINEARLY
#########beta=6, a+b=4

    dt=0.1  #time resolution of the simulation
    T=100  #length of the simulation
    Tmax=10 #maximum length of the pulse
    Tmin=1  #for the spikes in frequency modulation
    Tcell=5
    t=0:dt:T

    ruido=10   ##additive noise
    #############number of realizations
    #Realiz=floor(Int,20^2*nbis/log(nbis))
    Realiz=200
    #############discretization
    h=200
    #############number of inputs
    Realiz2=100
    M=Realiz2
 
    k=54
    ab=4 ####alpha+beta    

    area=zeros(Realiz,Realiz2)
    input=zeros(Realiz,Realiz2)
    input2=zeros(Realiz,Realiz2)
    invbeta(u)=minimum(filter((x)->(beta_inc(1.01+q*(ab-2.02),(ab-1.01)-q*(ab-2.02),x,1-x)[1]>=u),0.:1/Realiz2:1.))
    ######invbeta is the inverse of the CDF of the Beta Distribution.


    for j=1:Realiz2
        #tupla=(t,k1,k2,n,Kd,d1,d2,AM,dt,Realiz,ruido,M,Tmax,Tmin,T,j)
        #area[:,j]=jfijo(tupla)
        for i=1:Realiz
           input2[i,j]=invbeta(j/M)   ####input2 is the input. The discretization for the Mutual Information will be done on this variable.
           if AM==2
                input[i,j]=1/k*exp(nq*invbeta(j/M))   ######This is for Frequency Modulation. nq is Beta
           else
                input[i,j]=1/(1+(0.5*qk/invbeta(j/M))^nq)       #######This is Amplitude Modulation. 0.5*qk is EC50, nq is Hill
           end
        end
    end


    tupla=[(t,k1,k2,n,Kd,d1,d2,AM,dt,Realiz,ruido,M,Tmax,Tmin,Tcell,input[:,j],T,j) for j in 1:Realiz2]
    triple=[]
    triple=pmap(jfijo::typeof(jfijo),tupla)
    for i=1:Realiz
       for j=1:Realiz2
           area[i,j]=triple[j][i]
       end
    end




#########################################################  information calculation starts here


    hinput2=Realiz2
    houtput=h
    epsilon=0.000001
    ########discretization
    maxarea=maximum(area)
    maxinput2=maximum(input2)
    disinput2=floor.((input2.+epsilon)*hinput2/maxinput2)
    disarea=floor.(area*houtput/maxarea)
    IJN=0.0
    
    IJN=InfoIOJN(maxarea,disinput2,disarea,Realiz,hinput2,houtput)


    return(IJN)
end
