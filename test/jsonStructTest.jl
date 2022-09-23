using Ai4EMetaPSE
using Test

@testset "CommonJson" begin
    file = joinpath(@__DIR__, "JsonFiles\\CommonJson.json")
    @test typeof(CommonJson()) <: Ai4EMetaPSE.jsonModel
    @test typeof(readjson(file, CommonJson())) <: CommonJson
end

@testset "ModelJson" begin
    file = joinpath(@__DIR__, "JsonFiles\\ModelJson.json")
    @test typeof(ModelJson()) <: Ai4EMetaPSE.jsonModel
    @test typeof(readjson(file, ModelJson())) <: ModelJson
end

@testset "MetaSolution" begin
    file = joinpath(@__DIR__, "JsonFiles\\CommonJson.json")
    solution = MetaSolution(readjson(file, CommonJson()))
    @test typeof(solution.jm) <: CommonJson
    file = joinpath(@__DIR__, "JsonFiles\\ModelJson.json")
    solution = MetaSolution(readjson(file, ModelJson()))
    @test typeof(solution.jm) <: ModelJson
end
