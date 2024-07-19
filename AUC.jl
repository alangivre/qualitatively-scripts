using Random
function AUC(tupla)
  #######area under the curve
  t=tupla[1]
  k2=tupla[2]
  n=tupla[3]
  Kd=tupla[4]
  d1=tupla[5]
  d2=tupla[6]
  sigma=tupla[7]
  P1=tupla[8]
  dt=tupla[9]::Float64
  i=tupla[10]::Int64
  dt=tupla[11]
 
  x=0
  resultado=0.0

  for k = 2:length(t)
    r=rand()
    if (r>1-dt*d2*x)
        x=x-1                 
	#######jump backwards
    elseif (r<dt*P1[k]*(k2*sigma[k]^n)/(Kd^n+sigma[k]^n))
        x=x+1                 
	#######jump forward
    end
     resultado=resultado+x*dt    
     #######integrating
  end
  return(resultado)
end
