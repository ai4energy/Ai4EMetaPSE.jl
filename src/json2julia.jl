dictDispatch = Dict{Vector{String},Function}(
    ["STRING"] => (x) -> x["STRING"],
    ["head", "args"] => (x) -> try
        _json2julia(x)
    catch e
        println("Error: ", e)
        println("At: ", x)
    end,
    ["QUOTENODE"] => (x) -> QuoteNode(Symbol(x["QUOTENODE"])),
    ["LINENUMBERNODE"] => (x) -> LineNumberNode(x["LINENUMBERNODE"]["line"], x["LINENUMBERNODE"]["file"]),
)

function _json2julia(d::Dict)
    head = Symbol(d["head"])
    args = map(d["args"]) do arg
        arg isa Dict ? dictDispatch[collect(keys(arg))](arg) : (arg isa String ? Symbol(arg) : arg)
    end
    return Expr(head, args...)
end

"""
$(TYPEDSIGNATURES)

json2julia converts a JSON string to a Julia expression.

# Examples:

```julia    
file = joinpath(@__DIR__, "JsonFiles/julia2jsonTest1.json")
ex = json2julia(file)
```

"""
function json2julia(io::AbstractString)
    str = length(io) < 256 && isfile(io) ? read(io, String) : io
    ex = JSON3.read(str, Dict)
    return _json2julia(ex)
end

