using Ai4EMetaPSE
using Test
using JSON3
@testset "Ai4EMetaPSE.jl" begin
    # Write your tests here.
end

str = read("./test/JsonFiles/ReadTest.json",String)
res = JSON3.read(str)

res["unit_definition"]
typeof("""{"a": 1, "b": "hello, world"}""")
