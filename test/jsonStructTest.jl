using Ai4EMetaPSE
using Test
@testset "readjson" begin
    file = joinpath(@__DIR__, "JsonFiles\\CommonJson.json")
    @test typeof(CommonJson()) <: Ai4EMetaPSE.jsonModel
    @test typeof(readjson(file, CommonJson())) <: CommonJson
end
