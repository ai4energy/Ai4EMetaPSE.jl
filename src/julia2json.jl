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

function julia2json(str::String)
    _julia2josn(Meta.parse(str))
end

function julia2json(str::Expr)
    _julia2josn(str)
end

macro julia2json(ex)
    return _julia2josn(ex)
end

# function SimplePipe(; name, R=100, T=300)
#     a = true
#     @named inlet = FlowPort(T=T)
#     @named outlet = FlowPort(T=T)
#     sts = @variables T [connect = Flow]
#     ps = @parameters begin
#         R = R
#     end
#     eqs = [
#         inlet.p - outlet.p ~ R * inlet.qm * abs(inlet.qm)
#         inlet.qm + outlet.qm ~ 0
#     ]
#     compose(ODESystem(eqs, t, [], ps; name=name), inlet, outlet)
# end




