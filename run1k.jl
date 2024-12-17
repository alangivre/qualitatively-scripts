#using Blosc
__precompile__()
start = time()
using Distributed
using ClusterManagers
addprocs_slurm(parse(Int,ENV["SLURM_NTASKS"]))
@everywhere using DelimitedFiles
@everywhere using StatsBase
@everywhere using Statistics
@everywhere using LatinHypercubeSampling
@everywhere include("ab4core.jl")
@everywhere include("ab4solouno.jl")



g=open("/home/agivre/paper3scripts/files/ab4paratablaR1k","w") do g
    ########scanning the parameter p for Amplitude, EC50=0.5, Hill=1.5 
    #####a+b=4
    AM=1
    nq=1.5
    qk=1
    resultado=solouno(AM,nq,qk)
    println(g,"115","\n",resultado,"\n\n")


    ########scanning the parameter p for Amplitude, EC50=0.5, Hill=1
    ####a+b=4
    AM=1
    nq=1
    qk=1
    resultado=solouno(AM,nq,qk)
    println(g,"11","\n",resultado,"\n\n")



    ########scanning the parameter p for Amplitude, EC50=0.5, Hill=2
    ####a+b=4
    AM=1
    nq=2
    qk=1
    resultado=solouno(AM,nq,qk)
    println(g,"12","\n",resultado,"\n\n")




########scanning the parameter p for Amplitude, EC50=0.5, Hill=8
######a+b=4
    AM=1
    nq=8
    qk=1
    resultado=solouno(AM,nq,qk)
    println(g,"18","\n",resultado,"\n\n")



########scanning the parameter p for Amplitude, EC50=0.05, Hill=8
#####a+b=4
    AM=1
    nq=8
    qk=0.1
    resultado=solouno(AM,nq,qk)
    println(g,"18k01","\n",resultado,"\n\n")



########scanning the parameter p for Amplitude, EC50=0.25, Hill=8
########a+b=4
    AM=1
    nq=8
    qk=0.5
    resultado=solouno(AM,nq,qk)
    println(g,"18k05","\n",resultado,"\n\n")



########scanning the parameter p for Amplitude, EC50=5, Hill=8
#######a+b=4
    AM=1
    nq=8
    qk=10
    resultado=solouno(AM,nq,qk)
    println(g,"18k10","\n",resultado,"\n\n")



########scanning the parameter p for Amplitude, EC50=0.75, Hill=8
######a+b=4
    AM=1
    nq=8
    qk=1.5
    resultado=solouno(AM,nq,qk)
    println(g,"18k15","\n",resultado,"\n\n")



########scanning the parameter p for Amplitude, EC50=1, Hill=8
#######a+b=4
    AM=1
    nq=8
    qk=2
    resultado=solouno(AM,nq,qk)
    println(g,"18k2","\n",resultado,"\n\n")


end
elapsed = time() - start
println("Tiempo: ",elapsed)

