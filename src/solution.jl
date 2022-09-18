mutable struct MetaSolution
    script::Expr
    jm::jsonModel
    MetaSolution(jm::jsonModel) = new(Expr(:block), jm)
end

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
    push!(ex.args, :(der(t) = Differential(t)), :(eqs = []))
    for s in getproperty(f, :equations)
        s = replace(s, "=" => "~")
        vect_ex = Expr(:vect, Meta.parse(s))
        push!(ex.args, :(append!(eqs, $(vect_ex))))
    end
    push!(solution.script.args, ex)
    return (ex, solution)
end


process(metastruct::MetaModel, solution::MetaSolution) = (metastruct)(solution)


