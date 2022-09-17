abstract type MetaModel end

MetaStructs = Dict{Symbol,DataType}([
    :MetaName => String
    :MetaEquations => Vector{String}
    :MetaVariables => Vector{String}
    :MetaParameters => Vector{String}
    :MetaInit => Vector{String}
    :MetaTimespan => Vector{Float64}
    :MetaSolver => String
])

function matchType(datatype::DataType)
    return datatype <: Vector ? datatype() : (datatype <: String ? "" : datatype(0))
end

function earseMeta(structName::Symbol)
    structName = replace(string(structName), "Meta" => "")
    return Symbol(lowercase(structName))
end

for (structName, datatype) in MetaStructs
    s = quote
        struct $structName <: MetaModel
            $(earseMeta(structName))::$(datatype)
            $(structName)() = new($(matchType(datatype)))
        end
    end
    eval(s)
end


for (structName, datatype) in MetaStructs
    s = quote
        struct $structName <: MetaModel
            $(Symbol(lowercase(string(structName)[5:end])))::$(datatype)
            $(structName)() = new($(datatype <: Vector ? datatype() : (datatype <: String ? "" : datatype(0))))
        end
    end
    eval(s)
end

# StructTypes.StructType(::Type{CommonTemplate}) = StructTypes.Mutable()
# StructTypes.StructType(::Type{ModelTemplate}) = StructTypes.Mutable()
# StructTypes.StructType(::Type{ComponentsTemplate}) = StructTypes.Mutable()