using Ai4EMetaPSE
using SafeTestsets
using JSON3

@safetestset "MetaStructsTest" begin include("MetaStructsTest.jl") end

@safetestset "jsonStructTest" begin include("jsonStructTest.jl") end

@safetestset "solution" begin include("solution.jl") end

@safetestset "juli2json" begin include("julia2json.jl") end