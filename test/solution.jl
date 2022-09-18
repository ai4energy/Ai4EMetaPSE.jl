using Ai4EMetaPSE
using Test

@testset "solution.jl" begin
    file = joinpath(@__DIR__, "JsonFiles\\CommonJson.json")
    solution = MetaSolution(readjson(file, CommonJson()))
    @test Ai4EMetaPSE.process(solution.jm.parameters, solution)[1].head == :(@parameters begin
        σ = 1.0
        ρ = 3.0
        β = 5.0
    end).head
end



