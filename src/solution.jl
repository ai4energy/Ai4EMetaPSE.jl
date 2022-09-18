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
    structs = getproperty(solution.jm, sym)
    for s in getproperty(structs, sym)
        push!(blocks.args, Meta.parse(s))
    end
    push!(ex.args, blocks)
    push!(solution.script.args, ex)
    return (ex, solution)
end

process(metastruct::MetaModel, solution::MetaSolution) = (metastruct)(solution)
