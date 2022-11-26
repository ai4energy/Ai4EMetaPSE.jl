using JSON3

function exDispatch() end

exDispatch(ex::Expr) = _julia2josn(ex)
exDispatch(ex::LineNumberNode) = Dict{Symbol,Dict{Symbol,Any}}(:LINENUMBERNODE => Dict{Symbol,Any}(:line => ex.line, :file => ex.file))
exDispatch(ex::QuoteNode) = Dict{Symbol,Symbol}(:QUOTENODE => ex.value)
exDispatch(ex::String) = Dict{Symbol,String}(:STRING => ex)
exDispatch(ex::Symbol) = ex
exDispatch(ex::Number) = ex
exDispatch(ex::Bool) = ex

function _julia2josn(ex::Expr)
    d = Dict{Symbol,Any}()
    d[:head] = ex.head
    d[:args] = map(x -> exDispatch(x), ex.args)
    return d
end

"""
$(TYPEDSIGNATURES)

julia2json converts a Julia expression to a JSON string.

# Examples:

julia2json accepts a string or an expression.

```julia
ex = \"function f(x)
x + 1
end\" |> julia2json
JSON3.pretty(file, ex)
```

```julia
ex = :(function f(x)
x + 1
end) |> julia2json
JSON3.pretty(file, ex)
```

julia2json can also be used as a macro

```julia
s = @julia2json function f(x)
    x + 1
end
JSON3.pretty(file, s)
```
"""
function julia2json(str::String)
    _julia2josn(Meta.parse(str))
end

function julia2json(str::Expr)
    _julia2josn(str)
end

macro julia2json(ex)
    return _julia2josn(ex)
end



