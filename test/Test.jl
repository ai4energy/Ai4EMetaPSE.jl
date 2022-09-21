using StructTypes

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