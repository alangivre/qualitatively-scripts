#!/bin/bash
#SBATCH --partition=batch  #Seleccione los nodos para el trabajo de todos el conjunto de nodos de cómputo del cluster

#SBATCH -o Ires  #Nombre del archivo de salida
#SBATCH -J oshea  #Nombre del trabajo
#SBATCH --ntasks=32  #Numero de procesos
export JULIA_WORKER_TIMEOUT=600 

julia integrals.jl
