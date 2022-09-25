"""
$(TYPEDFIELDS)

The solution type.

* `script`: the generated code
* `jm`: store json file imformation

"""
mutable struct MetaSolution
    script::Expr
    jm::jsonModel
    MetaSolution(jm::jsonModel) = new(Expr(:block), jm)
end

export MetaSolution

getpro(f::MetaModel) = getproperty(f, earseMeta(Symbol(typeof(f))))

function (f::T where {T<:Union{MetaVariables,MetaParameters}})(solution::MetaSolution)
    T = typeof(f)
    sym = earseMeta(Symbol(T))
    ex = Meta.parse("@$(sym)")
    blocks = Expr(:block)
    if T <: MetaVariables
        push!(blocks.args, :(t))
    end
    for s in getproperty(f, sym)
        push!(blocks.args, Meta.parse(s))
    end
    push!(ex.args, blocks)
    push!(solution.script.args, ex)
    return (ex, solution)
end

function (f::MetaEquations)(solution::MetaSolution)
    ex = Expr(:block)
    push!(ex.args, :(der = Differential(t)), :(eqs = []))
    for s in getproperty(f, :equations)
        s = replace(s, "=" => "~")
        vect_ex = Expr(:vect, Meta.parse(s))
        push!(ex.args, :(append!(eqs, $(vect_ex))))
    end
    push!(solution.script.args, ex)
    return (ex, solution)
end

function (f::MetaName)(::Union{MetaSolution,jsonModel})
    s = replace(getproperty(f, :name), " " => "_")
    return Symbol(s)
end

function earseSubModule(modulename::String)
    ind = findfirst('.', modulename)
    return isnothing(ind) ? modulename : modulename[1:ind-1]
end

function (f::MetaPkgs)(solution::MetaSolution)
    usings = Expr(:using)
    for pkg in getpro(f)
        push!(usings.args, Expr(:., map(x -> Symbol(x), split(pkg, "."))...))
    end
    ex = quote
        using Pkg
        pkgNeeds = $(map(x -> earseSubModule(x), getpro(f)))
        alreadyGet = keys(Pkg.project().dependencies)
        toAdd = [package for package in pkgNeeds if package ∉ alreadyGet]
        isempty(toAdd) ? nothing : Pkg.add(toAdd)
        $(usings)
    end
    push!(solution.script.args, ex.args...)
    return (ex, solution)
end

function (f::MetaInit)(solution::MetaSolution)
    ex = :(Dict())
    for s in getpro(f)
        push!(ex.args, Meta.parse(s))
    end
    ex = Expr(:(=), :init, ex)
    push!(solution.script.args, ex)
    return (ex, solution)
end

function (f::MetaTimespan)(solution::MetaSolution)
    ex = :(())
    append!(ex.args, getproperty(f, :timespan))
    ex = Expr(:(=), :timespan, ex)
    push!(solution.script.args, ex)
    return (ex, solution)
end

function solversExpr(f::MetaSolver, jm::CommonJson)
    ex = :(ODEProblem(structural_simplify(ODESystem(eqs, t; name=:Model)), init, timespan))
    ex = isempty(getproperty(f, :solver)) ? :(solve($(ex))) : :(solve($(ex), $(Symbol(getproperty(f, :solver)))()))
    name = jm.name
    return Expr(:(=), name(jm), ex)
end

function solversExpr(f::MetaSolver, jm::ModelJson)
    ex = :(ODEProblem(structural_simplify(compose(ODESystem(eqs, t; name=:Model), components; name=:system)), init, timespan))
    ex = isempty(getproperty(f, :solver)) ? :(solve($(ex))) : :(solve($(ex), $(Symbol(getproperty(f, :solver)))()))
    name = jm.name
    return Expr(:(=), name(jm), ex)
end

function (f::MetaSolver)(solution::MetaSolution)
    ex = solversExpr(f, solution.jm)
    push!(solution.script.args, ex)
    return (ex, solution)
end

function (f::MetaComponents)(solution::MetaSolution)
    ex = Expr(:block)
    cps = Expr(:vect)
    for conponent in getpro(f)
        sym_name = Symbol(getindex(conponent, "name"))
        sym_type = Symbol(getindex(conponent, "type"))
        sym_args = [Expr(:(kw), Symbol(key), value) for (key, value) in getindex(conponent, "args")]
        push!(ex.args, :(@named $(sym_name) = $(sym_type)($(sym_args...))))
        push!(cps.args, sym_name)
    end
    cps = Expr(:(=), :components, cps)
    push!(solution.script.args, ex.args..., cps)
    return (ex, solution)
end

function (f::MetaConnections)(solution::MetaSolution)
    ex = :([])
    for connection in getproperty(f, :connections)
        push!(ex.args, Expr(:call, :connect, map(x -> Meta.parse(x), connection)...))
    end
    ex = Expr(:(=), :eqs, ex)
    push!(solution.script.args, ex)
    return (ex, solution)
end

process(metastruct::MetaModel, solution::MetaSolution) = (metastruct)(solution)


