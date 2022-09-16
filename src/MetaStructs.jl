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

for (structName,datatype) in MetaStructs
    s = quote
        struct $structName <: MetaModel
            $(Symbol(lowercase(string(structName)[5:end])))::$(datatype)
            $(structName)() =  new($(datatype <: Vector ? datatype() : (datatype <: String ? "" : datatype(0))))
        end
    end
    eval(s)
end