include("AUC.jl")
using SpecialFunctions
using Random

function jfijo(tupla)
	t=tupla[1]
	k1=tupla[2]
	k2=tupla[3]
	n=tupla[4]
	Kd=tupla[5]
	d1=tupla[6]
	d2=tupla[7]
	AM=tupla[8]
	dt=tupla[9]
	Realiz=tupla[10]
	ruido=tupla[11]
	M=tupla[12]
	Tmax=tupla[13]
	Tmin=tupla[14]
        Tcell=tupla[15]
        input=tupla[16]
	T=tupla[17]
	j=tupla[18]
	

	sigma=zeros(1,length(t))                
#########transcription factor
    	P1=zeros(1,length(t))                   
        ##########promoter
	areavector=zeros(Realiz,1)
        areavector1=zeros(Realiz,1)
        areavector2=zeros(Realiz,1)
	 
	if AM==1                                
            ##########j/M regulates amplitude modulation
            sigma=abs.([ones(1,floor(Int,length(t)*Tmax/T)) zeros(1,ceil(Int,length(t)*(1-Tmax/T)))]*input[1]*100+randn(1,length(t))*ruido)
         else
            if AM==0                            
                ##########j/M regulates duration modulation
                sigma=abs.([ones(1,floor(Int,length(t)*input[1]*Tmax/T)) zeros(1,ceil(Int,length(t)*(1-input[1]*Tmax/T)))]*100+randn(1,length(t))*ruido)
            else
                pulso=1                         
                ##########j/M regulates frequency modulation
                l=0
                m=0
                for k=1:length(t)
                    if pulso==1
                        sigma[k]=abs(100+randn()*ruido) 
                        l=l+1
                    else
                        m=m+1
                        sigma[k]=abs(randn()*ruido)
                        if m>=1. /dt*(Tcell-1) && (rand()<dt*1. /Tcell*input[1]) ####I assume Tcell around 4 min (5 in total)
                            pulso=1
                            m=0
                        end
                    end
                    if l>=Tmin/dt
                        l=0
                        pulso=0
                    end
                end
            end
        end

        for k=2:length(t)
            P1[k]=P1[k-1]+((k1*sigma[k]^n)/(Kd^n+sigma[k]^n)-((k1*sigma[k]^n)/(Kd^n+sigma[k]^n)+d1)*P1[k-1])*dt
            ######promoter
        end

	#tupla=[(t,k2,n,Kd,d1,d2,sigma,P1,dt,i) for i in 1:Realiz]
	#areavector=hcat(pmap(AUC::typeof(AUC),tupla)...)
        for i=1:Realiz
	    tupla=(t,k2,n,Kd,d1,d2,sigma,P1,dt,i,dt)
            areavector[i]=AUC(tupla)
            #########the protein production is calculated here
        end
	return (areavector)
end
