function readjson(io::String, s::jsonModel=CommonJson())
    str = read(io, String)
    return JSON3.read!(str, s)
end

```

```
function generatecode(io::String, type::jsonModel; write2File::Union{String,Nothing}=nothing)
    type = readjson(io, type)
    fields = fieldnames(typeof(type))
    solution = MetaSolution(type)
    for field in fields
        process(getproperty(solution.jm, field), solution)
    end
    isnothing(write2File) ? nothing : write(write2File, string(solution.script))
    return solution
end
