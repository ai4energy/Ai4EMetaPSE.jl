Base.@kwdef struct CommonTemplate
    name::String = ""
    variables::Vector{String} = String[]
    parameters::Vector{String} = String[]
    equations::Vector{String} = String[]
    u0::Vector{String} = String[]
    timespan::Vector{Int} = Int[]
    solver::String = ""
end

StructTypes.StructType(::Type{CommonTemplate}) = StructTypes.Struct()