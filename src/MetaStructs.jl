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
        end
        export $structName
        $(structName)() = $(structName)($(matchType(datatype)))
    end
    eval(s)
end

function structTypes(datatype::DataType)
    if datatype <: Vector
        return :ArrayType
    elseif datatype <: String
        return :StringType
    elseif datatype <: Number
        return :NumberType
    else
        return :NullType
    end
end

for (structName, datatype) in MetaStructs
    s = quote
        StructTypes.StructType(::Type{$(structName)}) = StructTypes.$(structTypes(datatype))()
    end
    eval(s)
end
