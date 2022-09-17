using Ai4EMetaPSE
using SafeTestsets
using JSON3

@safetestset "MetaStructsTest" begin include("MetaStructsTest.jl") end

@safetestset "jsonStructTest" begin include("jsonStructTest.jl") end


