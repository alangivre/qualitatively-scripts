__precompile__()
using SpecialFunctions
start = time()
g=open("/home/agivre/tercerpaper3/aarchivos6/integrals","w") do g
	########CDFs for the TF Amplitude and Frequency
	#####amplitude
	#y is I_ext
	dy=0.01

	cdfa=zeros(11,11)
	cdff=zeros(11,11)
	for j=0:10
		for i=0:10
			x=j*10
			q=i*0.1
			integral=0.0
			for y=0.0:dy:1.0
				a=1/2*(1+erf(1/(10*sqrt(2))*(x-100*y^8/(y^8+0.5^8))))
				beta=2/(gamma(q+1)*gamma(2-q))*y^q*(1-y)^(1-q)
				integral=integral+a*beta*dy
			end
			cdfa[i+1,j+1]=integral
		end
	end
	#####frequency

	integral=0.0
	for j=1:10
		for i=1:10
			x=j+5
			q=i*0.1
			integral=0.0
			for y=0.0:dy:1.0
        			b=1-exp(-exp(4*y)/45*(x-5))
        			beta=2/(gamma(q+1)*gamma(2-q))*y^q*(1-y)^(1-q)
        			integral=integral+b*beta*dy
			end
			cdff[i+1,j+1]=integral
		end
	end
	println(g,cdfa,"\n",cdff)
end
elapsed = time() - start
println("Tiempo: ",elapsed)
