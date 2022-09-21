using Ai4EMetaPSE
using Test

@testset "earseMeta()" begin
    Ai4EMetaPSE.earseMeta(:MetaStruct) == :struct
end

@testset "matchType()" begin
    @test Ai4EMetaPSE.matchType(Vector{Int}) == Int64[]
    @test Ai4EMetaPSE.matchType(String) == ""
    @test Ai4EMetaPSE.matchType(Float64) == Float64(0)
end
