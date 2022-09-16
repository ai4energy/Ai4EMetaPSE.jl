using Ai4EMetaPSE
using Test
using JSON3
@testset "Ai4EMetaPSE.jl" begin
    # Write your tests here.
end
t = CommonTemplate()
str = read!(joinpath(@__DIR__, "JsonFiles/CommoTemplate.json"), t)
res = JSON3.read(str)
res["unit_definition"]
typeof("""{"a": 1, "b": "hello, world"}""")
