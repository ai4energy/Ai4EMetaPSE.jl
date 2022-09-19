abstract type jsonModel end

macro genJsonStruct(name, pairs)
    ex = Expr(:block)
    pairs = eval(pairs)
    for (fieldname, metaStruct) in pairs
        push!(ex.args, :($(fieldname)::$(metaStruct) = $(eval(metaStruct)())))
    end
    esc(quote
        Base.@kwdef mutable struct $name <: jsonModel
            $(ex)
        end
        StructTypes.StructType(::Type{$(name)}) = StructTypes.Mutable()
        export $name
    end)
end

include("jsonStructs/CommonJson.jl")


