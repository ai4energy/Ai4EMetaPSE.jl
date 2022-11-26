module Ai4EMetaPSE

using JSON3
using StructTypes
using DocStringExtensions

include("MetaStructs.jl")
include("jsonStruct.jl")
include("solution.jl")
include("generateCode.jl")
include("julia2json.jl")
include("json2julia.jl")

export readjson, generatecode, evalSolution

export julia2json, json2julia, @julia2json


end

