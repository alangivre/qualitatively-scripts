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
@everywhere include("ab4coreN2.jl")
@everywhere include("ab4solouno.jl")



g=open("/home/agivre/paper3scripts/files/ab4paratablaR24N2","w") do g
########scanning the parameter p for Frequency, Beta=4, k=e^4
######a+b=4
    AM=2
    nq=4
    qk=1
    resultado=solouno(AM,nq,qk)
    println(g,resultado)
end
elapsed = time() - start
println("Tiempo: ",elapsed)

