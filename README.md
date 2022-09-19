# Ai4EMetaPSE

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jake484.github.io/Ai4EMetaPSE.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jake484.github.io/Ai4EMetaPSE.jl/dev/)
[![Build Status](https://github.com/jake484/Ai4EMetaPSE.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jake484/Ai4EMetaPSE.jl/actions/workflows/CI.yml)

Ai4EMetaPSE.jl parses a json file that include differential equations and generate julia solution code based on [Sciml Ecosystem](https://sciml.ai/).

## Install

```
using Pkg
Pkg.add("Ai4EMetaPSE")
```

## Example

**JSON File**:

```json
{
    "name": "Name",
    "pkgs": [
        "ModelingToolkit",
        "DifferentialEquations"
    ],
    "variables": [
        "x(t) = 1.0",
        "y(t) = 1.0",
        "z(t) = 2.0"
    ],
    "parameters": [
        "σ = 1.0",
        "ρ = 3.0",
        "β = 5.0" 
    ],
    "equations": [
        "der(x) = σ*(y - x)",
        "der(y) = x*(ρ - z) - y",
        "der(z) = x*y - β*z"
    ],
    "u0": [
        "x => 1.0",
        "y => 2.0",
        "z => 3.0"
    ],
    "timespan": [0,1],
    "solver": "Rosenbrock23"
}
```

Using Ai4EMetaPSE to parse json file:

```julia
using Ai4EMetaPSE
str = """{
    "name": "Name",
    "pkgs": [
        "ModelingToolkit",
        "DifferentialEquations"
    ],
    "variables": [
        "x(t) = 1.0",
        "y(t) = 1.0",
        "z(t) = 2.0"
    ],
    "parameters": [
        "σ = 1.0",
        "ρ = 3.0",
        "β = 5.0" 
    ],
    "equations": [
        "der(x) = σ*(y - x)",
        "der(y) = x*(ρ - z) - y",
        "der(z) = x*y - β*z"
    ],
    "u0": [
        "x => 1.0",
        "y => 2.0",
        "z => 3.0"
    ],
    "timespan": [0,1],
    "solver": "Rosenbrock23"
}"""
solution = generatecode(str, CommonJson(); write2File="s.jl")
```

In current folder, `s.jl` will be generated and solution codes are:

```julia
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
```
