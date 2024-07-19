include("InfoIO.jl")
function InfoIOJN(maxarea,disinput,disarea,Realiz,hinput,houtput)

           ndp=10
           listadepuntos=zeros(1,ndp)
           listasumadepuntos=zeros(1,ndp)
           sumadepuntos=sum(1/i for i = 1:ndp)
           listadepuntos=[1/(i*sumadepuntos) for i = 1:ndp]

           for i=2:ndp
                listasumadepuntos[i]=listadepuntos[i-1]+listasumadepuntos[i-1]
           end
           listasumadepuntos=floor.(Int,listasumadepuntos*Realiz)
           listasumadepuntos=[listasumadepuntos Realiz]
           listainversadepuntos=1 ./(listadepuntos.*Realiz)

           listainputjacknife=[disinput[listasumadepuntos[i]+1:listasumadepuntos[i+1],:] for i=1:ndp]
           listaareajacknife=[disarea[listasumadepuntos[i]+1:listasumadepuntos[i+1],:] for i=1:ndp]

           infondp=zeros(ndp)
           for i=1:ndp
               listainputjacknifei=listainputjacknife[i]
               listaareajacknifei=listaareajacknife[i]

               x0=InfoIO(maxarea,listainputjacknifei[:],listaareajacknifei[:],Realiz,hinput,houtput)

               infondp[i]=x0[1]
           end
           infondpvec=vec(infondp)

           p0=[0.5,0.5]
           @.model(x,p)=p[1]+p[2]*x
           fit0 = curve_fit(model, listainversadepuntos, infondpvec, p0)
           IJN=fit0.param[1]
         
           return(IJN)
end
