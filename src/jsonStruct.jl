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


function readjson(io::String, s::jsonModel = CommonJson())
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



# eval(:(@time begin
#     x = 1.0
#     y = 2.0
# end))
# dump(:(Dict()))
# res = :(@time)
# ex = Expr(:block)
# push!(ex.args,:(x=1),:(x=2))
# push!(res.args,ex)
# eval(res)
# dump(res)

