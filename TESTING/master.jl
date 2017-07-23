 # Pkg.add("ParallelDataTransfer")
# @everywhere using ParallelTemperingCPP
@everywhere using ParallelDataTransfer
# W. SEWLAL 1383337 # 2015-12-03
include("ParallelTemperingCPP.jl")

const gamma_temperatures = Array{Float64, 1}(4)
const G = length(gamma_temperatures)
gamma_temperatures[1:G] = [1.0, 1.0 + 1e-4, 1.0 + 2e-4, 1.0 + 3e-4]
@broadcast G = getfrom(1, :G)
@broadcast const gamma_temperatures = getfrom(1, :gamma_temperatures)

@everywhere info(G)
@everywhere info(gamma_temperatures)
# @broadcast G = length(getfrom(1, :gamma_temperatures))


pathTMPStream = "/home/wikash/Documents/Simulations/"


# gamma = SharedArray(Int32, G, init = S -> S[Base.localindexes(S)] = myid())
# mygamma = SharedArray(Float64, G, pids=workers())
# @everywhere gamma = SharedArray(Int32, G)

@everywhere include("parallel-startup.jl")
@everywhere using PTstartup

@broadcast setIndexMyGamma(idWorker)
@broadcast setMyPathTMPStream(getfrom(1, :pathTMPStream))
@broadcast getIndexMyGamma()
@broadcast getMyPathTMPStream()

# @everywhere println(getMyGamma())
# @everywhere println(getMyPathTMPStream())

# @everywhere info(id)
# @everywhere info(G)
# @everywhere info(workerid)
# @everywhere info(mygamma)

# @everywhere @time sleep(3)
# @everywhere info(gamma[2])
# @parallel for i=1:4
# gamma[2] = id
# end


# include("MH-main-functions.jl")
# export MetropolisHastings, MHproposeNiAi!, MHsaveResults, MHloadResults

# include("PT-main-functions.jl")
# export parallelTempering, PTreport, PTsaveResults, PTloadResults
# @everywhere a = SharedArray(Float64,10)
# @parallel for i=1:10
#   a[i] = i
# end
# info(a)


# mygamma::Array{Float64, 1}(4)

# gamma_temperatures[1] = 1.0
# gamma_temperatures[2] = 1 + 1e-4
# gamma_temperatures[3] = 1 + 2e-4
# gamma_temperatures[4] = 1 + 3e-4
# info(gamma_temperatures)

