using Ai4EMetaPSE
using SafeTestsets
using JSON3

@safetestset "MetaStructsTest" begin include("MetaStructsTest.jl") end

# str = read(joinpath(@__DIR__, "JsonFiles/CommoTemplate.json"), String)
# StructTypes.StructType(::Type{Ai4EMetaPSE.CommonTemplate}) = StructTypes.Mutable()
# struc = JSON3.read!(str, Ai4EMetaPSE.CommonTemplate())

