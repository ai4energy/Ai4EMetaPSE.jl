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


# using StructTypes
# using JSON3

# struct eq
#     val::Vector{Int64}
# end

# Base.@kwdef mutable struct eqs
#     val::eq = eq([])
# end

# StructTypes.StructType(::Type{eq}) = StructTypes.ArrayType()
# StructTypes.StructType(::Type{eqs}) = StructTypes.Mutable()

# str = """{"val":[1,2,3]}"""

# res = JSON3.read!(str,eqs())