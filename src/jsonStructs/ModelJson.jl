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