abstract type jsonModel end

macro genJsonStruct(name, dic)
    ex = Expr(:block)
    dic = eval(dic)
    for (fieldname, metaStruct) in dic
        push!(ex.args, :($(fieldname)::$(metaStruct) = $(eval(metaStruct)())))
    end
    esc(quote
        Base.@kwdef mutable struct $name <: jsonModel
            $(ex)
        end
        StructTypes.StructType(::Type{$(name)}) = StructTypes.Mutable()
    end)
end

include("jsonStructs/CommonJson.jl")


function readjson(io::String, s::jsonModel)
    str = read(io, String)
    return JSON3.read!(str, s)
end

# function pretreatment end

# function pretreatment(jm::CommonTemplate)
#     equations = String[]
#     for eq in jm.equations
#         push!(equations, replace(eq, "=" => "~"))
#     end
#     jm.equations = equations
#     return jm
# end

# function json2script(io::String)


# end


