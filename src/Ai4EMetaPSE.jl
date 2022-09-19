module Ai4EMetaPSE

using JSON3
using StructTypes

include("MetaStructs.jl")
include("jsonStruct.jl")
include("solution.jl")
include("generateCode.jl")
# Write your package code here.

export readjson, generatecode

end

