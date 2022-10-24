function readjson(io::AbstractString, s::jsonModel)
    # if Sys.islinux()
    #     str = length(io) < 255 && isfile(io) ? read(io, String) : io
    # elseif Sys.iswindows()
    #     str = isfile(io) ? read(io, String) : io
    # end
    str = length(io) < 256 && isfile(io) ? read(io, String) : io
    return JSON3.read!(str, s)
end

"""
$(TYPEDSIGNATURES)

To read the json file and return [`MetaSolution`](@ref) type

* `io`: Json file name or json strings
* `type`: The type of json, `CommonJson` , `ModelJson` and so on.
* `write2File`: The name of script to be generated or nothing. If passing nothing, it will not generate script. `Default`: nothing

# Examples:

```julia
str = \"\"\"{
    "name": "Name",
    "pkgs": [
        "ModelingToolkit",
        "DifferentialEquations"
    ],
    "variables": [
        "x(t) = 1.0",
        "y(t) = 1.0",
        "z(t) = 2.0"
    ],
    "parameters": [
        "σ = 1.0",
        "ρ = 3.0",
        "β = 5.0" 
    ],
    "equations": [
        "der(x) = σ*(y - x)",
        "der(y) = x*(ρ - z) - y",
        "der(z) = x*y - β*z"
    ],
    "u0": [
        "x => 1.0",
        "y => 2.0",
        "z => 3.0"
    ],
    "timespan": [0,1],
    "solver": "Rosenbrock23"
}\"\"\"
solution = generatecode(str, CommonJson(); write2File="s.jl")
```

"""
function generatecode(io::AbstractString, type::jsonModel; write2File::Union{String,Nothing}=nothing)
    type = readjson(io, type)
    fields = fieldnames(typeof(type))
    solution = MetaSolution(type)
    for field in fields
        process(getproperty(solution.jm, field), solution)
    end
    isnothing(write2File) ? nothing : write(write2File, join(map(x -> string(x) * '\n', solution.script.args)))
    return solution
end


"""
$(TYPEDSIGNATURES)

To get the script in [`MetaSolution`](@ref)

* `solution`: the result from `generatecode`

"""
getscript(solution::MetaSolution) = solution.script

"""
$(TYPEDSIGNATURES)

To `eval` the script in [`MetaSolution`](@ref) at `Main`

* `solution`: the result from `generatecode`

"""
evalSolution(solution::MetaSolution) = Base.eval(Main, solution.script)

