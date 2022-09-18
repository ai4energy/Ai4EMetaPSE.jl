using Ai4EMetaPSE
using Test

@testset "solution.jl" begin
    file = joinpath(@__DIR__, "JsonFiles\\CommonJson.json")
    solution = MetaSolution(readjson(file, CommonJson()))
    @test(Ai4EMetaPSE.process(solution.jm.equations, solution)[1].head == :block)
    @test Ai4EMetaPSE.process(solution.jm.parameters, solution)[1].args[1] == Symbol("@parameters")
    @test Ai4EMetaPSE.process(solution.jm.variables, solution)[1].args[1] == Symbol("@variables")
end

# file = joinpath(@__DIR__, "JsonFiles\\CommonJson.json")
# solution = MetaSolution(readjson(file, CommonJson()))
# Ai4EMetaPSE.process(solution.jm.equations, solution)[1].head
