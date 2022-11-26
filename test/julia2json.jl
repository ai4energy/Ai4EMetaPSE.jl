using Ai4EMetaPSE
using JSON3
using Test

@testset "@julia2json" begin
    expr = :(function f(x)
        x + 1
    end)
    file = joinpath(@__DIR__, "JsonFiles/julia2jsonTest1.json")
    open(file, "w") do io
        s = @julia2json function f(x)
            x + 1
        end
        JSON3.pretty(io, s)
    end
    ex = json2julia(file)
    @test eval(ex)(1) == eval(expr)(1)
end

@testset "julia2json" begin
    expr = :(function f(x)
        x = x + 1
        x *= 3
        x -= 2
    end)
    file = joinpath(@__DIR__, "JsonFiles/julia2jsonTest2.json")
    open(file, "w") do io
        s = julia2json("function f(x)
            x = x + 1
            x *= 3
            x -= 2
        end")
        JSON3.write(io, s)
    end
    ex = json2julia(file)
    @test eval(ex)(1) == eval(expr)(1)
end

@testset "julia2json" begin
    expr = :(function f(x)
        x = x + 1
        x *= 3
        x -= 2
        begin
            @assert x isa Number
            return x
        end
    end)
    file = joinpath(@__DIR__, "JsonFiles/julia2jsonTest3.json")
    open(file, "w") do io
        s = julia2json(expr)
        JSON3.pretty(io, s)
    end
    ex = json2julia(file)
    @test eval(ex)(1) == eval(expr)(1)
end
