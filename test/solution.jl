using Ai4EMetaPSE
using Test

@testset "solution funcs" begin
    file = joinpath(@__DIR__, "JsonFiles\\CommonJson.json")
    solution = MetaSolution(readjson(file, CommonJson()))
    @test(Ai4EMetaPSE.process(solution.jm.equations, solution)[1].head == :block)
    @test Ai4EMetaPSE.process(solution.jm.parameters, solution)[1].args[1] == Symbol("@parameters")
    @test Ai4EMetaPSE.process(solution.jm.variables, solution)[1].args[1] == Symbol("@variables")
    @test Ai4EMetaPSE.process(solution.jm.u0, solution)[1].args[1] == Symbol("init")
    @test Ai4EMetaPSE.process(solution.jm.timespan, solution)[1].args[1] == Symbol("timespan")
end

@testset "generatecode" begin
    file = joinpath(@__DIR__, "JsonFiles\\CommonJson.json")
    solution = generatecode(file, CommonJson(); write2File="s.jl")
    @test true
end
