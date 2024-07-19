# qualitatively-scripts
Scripts for paper "Qualitatively Distinct Signaling in Cells"

Run script.sh, inside choose the script you intend to run.

The scripts are in julia.

Fig. 2 comes from run1k.jl.
Fig. 3b comes from run2k.jl.
Fig. 3a comes from run24N.jl, run26N.jl and run24N2.jl.
These call the core scripts, which run jfijoT.jl (a simulation for a fixed input) and then compute the Mutual Information, through Jackknife method, in InfoIOJN.jl.

Fig. 4 comes from integrals.jl.

The data is saved in files folder.

Givré, A., Colman-Lerner, A., & Dawson, S. P. (2024). Qualitatively Distinct Signaling in Cells: The Informational Landscape of Amplitude and Frequency Encoding. arXiv [q-Bio.CB]. Retrieved from http://arxiv.org/abs/2401.04089
