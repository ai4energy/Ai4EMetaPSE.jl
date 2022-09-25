module Ai4EMetaPSE

using JSON3
using StructTypes
using DocStringExtensions

include("MetaStructs.jl")
include("jsonStruct.jl")
include("solution.jl")
include("generateCode.jl")
# Write your package code here.

export readjson, generatecode

end

