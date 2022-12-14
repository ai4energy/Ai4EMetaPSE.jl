abstract type MetaModel end

MetaStructs = Dict{Symbol,DataType}([
    :MetaName => String
    :MetaPkgs => Vector{String}
    :MetaEquations => Vector{String}
    :MetaVariables => Vector{String}
    :MetaParameters => Vector{String}
    :MetaInit => Vector{String}
    :MetaTimespan => Vector{Float64}
    :MetaSolver => String
    :MetaComponents => Vector{Dict{String,Any}}
    :MetaConnections => Vector{Vector{String}}
    :MetaArgs => Vector{String}
    :MetaCustom_Code => Vector{String}
    :MetaVariablesInclude => Vector{String}
])

function matchType(datatype::DataType)
    return datatype <: Union{Vector,Dict} ? datatype() : (datatype <: String ? "" : datatype(0))
end

function earseMeta(structName::Symbol)
    structName = replace(string(structName), "Meta" => "")
    return Symbol(lowercase(structName))
end

for (structName, datatype) in MetaStructs
    s = quote
        struct $structName <: MetaModel
            $(earseMeta(structName))::$(datatype)
        end
        export $structName
        $(structName)() = $(structName)($(matchType(datatype)))
    end
    eval(s)
end

# function structTypes(datatype::DataType)
#     if datatype <: Vector
#         return :ArrayType
#     elseif datatype <: String
#         return :StringType
#     elseif datatype <: Dict
#         return :DictType
#     elseif datatype <: Number
#         return :NumberType
#     else
#         return :NullType
#     end
# end

function structTypes() end
structTypes(::Type{<:Vector}) = :ArrayType
structTypes(::Type{<:String}) = :StringType
structTypes(::Type{<:Dict}) = :DictType
structTypes(::Type{<:Number}) = :NumberType
structTypes(::Type{<:Union{}}) = :NullType

for (structName, datatype) in MetaStructs
    s = quote
        StructTypes.StructType(::Type{$(structName)}) = StructTypes.$(structTypes(datatype))()
    end
    eval(s)
end
