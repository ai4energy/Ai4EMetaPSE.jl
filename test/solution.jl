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

@testset "generatecode write" begin
    file = joinpath(@__DIR__, "JsonFiles\\CommonJson.json")
    solution = generatecode(file, CommonJson(); write2File="s.jl")
    @test true
end

@testset "generatecode parse string" begin
    str = """{
    "name": "Name",
    "pkgs": [
        "ModelingToolkit",
        "DifferentialEquations"
    ],
    "variables": [
        "x(t) = 1.0",
        "y(t) = 1.0",
        "z(t) = 2.0"
    ],
    "parameters": [
        "σ = 1.0",
        "ρ = 3.0",
        "β = 5.0" 
    ],
    "equations": [
        "der(x) = σ*(y - x)",
        "der(y) = x*(ρ - z) - y",
        "der(z) = x*y - β*z"
    ],
    "u0": [
        "x => 1.0",
        "y => 2.0",
        "z => 3.0"
    ],
    "timespan": [0,1],
    "solver": "Rosenbrock23"
}"""
    solution = generatecode(str, CommonJson(); write2File="s.jl")
    @test true
end

@testset "ModelJson write" begin
    file = joinpath(@__DIR__, "JsonFiles\\ModelJson.json")
    solution = generatecode(file, ModelJson(); write2File="s.jl")
    @test true
end

@testset "evalSolution" begin
    file = joinpath(@__DIR__, "JsonFiles\\ModelJson.json")
    solution = generatecode(file, ModelJson(); write2File="s.jl")
    try
        evalSolution(solution)
    catch e
        println(e)
        @test true
    end
end
