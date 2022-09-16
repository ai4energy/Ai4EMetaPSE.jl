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
    end)
end


@genJsonStruct CommonJson Dict{Symbol,Symbol}([
    :name => :MetaName
    :variables => :MetaEquations
    :parameters => :MetaVariables
    :equations => :MetaParameters
    :u0 => :MetaInit
    :timespan => :MetaTimespan
    :solver => :MetaSolver
])

Base.@kwdef mutable struct CommonTemplate <: jsonModel
    name::String = ""
    variables::Vector{String} = String[]
    parameters::Vector{String} = String[]
    equations::Vector{String} = String[]
    u0::Vector{String} = String[]
    timespan::Vector{Int} = Int[]
    solver::String = ""
end

Base.@kwdef mutable struct ModelTemplate <: jsonModel
    name::String = ""
    model::Vector{String} = String[]
    componentsInclude::Vector{String} = String[]
    components::Vector{String} = String[]
    connections::Vector{String} = String[]
    u0::Vector{String} = String[]
    timespan::Vector{Int} = Int[]
    solver::String = ""
end

Base.@kwdef mutable struct ComponentsTemplate <: jsonModel
    name::String = ""
    componentsInclude::Vector{String} = String[]
    varibles::Vector{String} = String[]
    parameters::Vector{String} = String[]
    equations::Vector{String} = String[]
    components::Vector{Int} = String[]
end


StructTypes.StructType(::Type{CommonTemplate}) = StructTypes.Mutable()
StructTypes.StructType(::Type{ModelTemplate}) = StructTypes.Mutable()
StructTypes.StructType(::Type{ComponentsTemplate}) = StructTypes.Mutable()

function readjson(io::String, s::jsonModel=CommonTemplate())
    str = read(io, String)
    return JSON3.read!(str, s)
end

function pretreatment end

function pretreatment(jm::CommonTemplate)
    equations = String[]
    for eq in jm.equations
        push!(equations, replace(eq, "=" => "~"))
    end
    jm.equations = equations
    return jm
end

function json2script(io::String)


end


