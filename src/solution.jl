mutable struct MetaSolution
    script::Expr
    jm::jsonModel
    MetaSolution(jm::jsonModel) = new(Expr(:block), jm)
end

export MetaSolution

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

function (f::MetaName)(::MetaSolution)
    s = replace(getproperty(f, :name), " " => "_")
    return Symbol(s)
end

function (f::MetaPkgs)(solution::MetaSolution)
    usings = Expr(:using)
    for pkg in getproperty(f, :pkgs)
        push!(usings.args, Expr(:., Symbol(pkg)))
    end
    ex = quote
        using Pkg
        pkgNeeds = $(getproperty(f, :pkgs))
        alreadyGet = keys(Pkg.project().dependencies)
        toAdd = [package for package in pkgNeeds if package ∉ alreadyGet]
        isempty(toAdd) ? nothing : Pkg.add(toAdd)
        $(usings)
    end
    push!(solution.script.args, ex)
    return (ex, solution)
end

function (f::MetaInit)(solution::MetaSolution)
    ex = :(Dict())
    for s in getproperty(f, :init)
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

function (f::MetaSolver)(solution::MetaSolution)
    ex = :(ODEProblem(structural_simplify(ODESystem(eqs, t; name=:Model)), init, timespan))
    ex = isempty(getproperty(f, :solver)) ? :(solve($(ex))) : :(solve($(ex), $(Symbol(getproperty(f, :solver)))()))
    name = solution.jm.name
    ex = Expr(:(=), name(solution), ex)
    push!(solution.script.args, ex)
    return (ex, solution)
end

process(metastruct::MetaModel, solution::MetaSolution) = (metastruct)(solution)


