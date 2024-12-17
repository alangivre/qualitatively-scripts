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



g=open("/home/agivre/paper3scripts/files/ab4paratablaR2k","w") do g
########scanning the parameter p for Frequency, Beta=1
########a+b=4
    AM=2
    nq=1
    qk=1
    resultado=solouno(AM,nq,qk)
    println(g,"21","\n",resultado,"\n\n")

########scanning the parameter p for Frequency, Beta=2
######a+b=4
    AM=2
    nq=2
    qk=1
    resultado=solouno(AM,nq,qk)
    println(g,"22","\n",resultado,"\n\n")


########scanning the parameter p for Frequency, Beta=3
#####a+b=4
    AM=2
    nq=3
    qk=1
    resultado=solouno(AM,nq,qk)
    println(g,"23","\n",resultado,"\n\n")



########scanning the parameter p for Frequency, Beta=4
######a+b=4
    AM=2
    nq=4
    qk=1
    resultado=solouno(AM,nq,qk)
    println(g,"\n","24",resultado,"\n\n")



########scanning the parameter p for Frequency, Beta=6
######a+b=4
    AM=2
    nq=6
    qk=1
    resultado=solouno(AM,nq,qk)
    println(g,"\n","26",resultado,"\n\n")

end
elapsed = time() - start
println("Tiempo: ",elapsed)

