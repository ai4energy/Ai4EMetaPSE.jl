Base.@kwdef mutable struct ComponentsTemplate <: jsonModel
    name::String = ""
    componentsInclude::Vector{String} = String[]
    varibles::Vector{String} = String[]
    parameters::Vector{String} = String[]
    equations::Vector{String} = String[]
    components::Vector{Int} = String[]
end