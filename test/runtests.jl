using Ai4EMetaPSE
using Test
using JSON3

@testset "Ai4EMetaPSE.jl" begin
    include("jsonTest.jl")
end

@testset "MetaStructsTest" begin
    include("MetaStructsTest.jl")
end

# str = read(joinpath(@__DIR__, "JsonFiles/CommoTemplate.json"), String)
# StructTypes.StructType(::Type{Ai4EMetaPSE.CommonTemplate}) = StructTypes.Mutable()
# struc = JSON3.read!(str, Ai4EMetaPSE.CommonTemplate())

