begin
    begin
        #= d:\postgraduate\project\develop\Ai4EMetaPSE\src\solution.jl:48 =#
        using Pkg
        #= d:\postgraduate\project\develop\Ai4EMetaPSE\src\solution.jl:49 =#
        pkgNeeds = ["ModelingToolkit", "DifferentialEquations"]
        #= d:\postgraduate\project\develop\Ai4EMetaPSE\src\solution.jl:50 =#
        alreadyGet = keys((Pkg.project()).dependencies)
        #= d:\postgraduate\project\develop\Ai4EMetaPSE\src\solution.jl:51 =#
        toAdd = [package for package = pkgNeeds if package ∉ alreadyGet]
        #= d:\postgraduate\project\develop\Ai4EMetaPSE\src\solution.jl:52 =#
        if isempty(toAdd)
            nothing
        else
            Pkg.add(toAdd)
        end
        #= d:\postgraduate\project\develop\Ai4EMetaPSE\src\solution.jl:53 =#
        using ModelingToolkit, DifferentialEquations
    end
    #= none:1 =# @variables begin
            t
            x(t) = begin
                    #= none:1 =#
                    1.0
                end
            y(t) = begin
                    #= none:1 =#
                    1.0
                end
            z(t) = begin
                    #= none:1 =#
                    2.0
                end
        end
    #= none:1 =# @parameters begin
            σ = 1.0
            ρ = 3.0
            β = 5.0
        end
    begin
        der = Differential(t)
        eqs = []
        append!(eqs, [der(x) ~ σ * (y - x)])
        append!(eqs, [der(y) ~ x * (ρ - z) - y])
        append!(eqs, [der(z) ~ x * y - β * z])
    end
    init = Dict(x => 1.0, y => 2.0, z => 3.0)
    timespan = (0.0, 1.0)
    Name = solve(ODEProblem(structural_simplify(ODESystem(eqs, t; name = :Model)), init, timespan), Rosenbrock23())
end