function readjson(io::AbstractString, s::jsonModel)
    str = isfile(io) ? read(io, String) : io
    return JSON3.read!(str, s)
end

```

```
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