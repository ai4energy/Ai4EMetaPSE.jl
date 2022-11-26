# Differential Equations Json Examples

## CommonJson

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
solution = generatecode(str, CommonJson())
```

The generated codes are:

```julia
quote
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:64 =#
    using Pkg
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:65 =#
    pkgNeeds = ["ModelingToolkit", "DifferentialEquations"]
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:66 =#
    alreadyGet = keys((Pkg.project()).dependencies)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:67 =#
    toAdd = [package for package = pkgNeeds if package ∉ alreadyGet]
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:68 =#
    if isempty(toAdd)
        nothing
    else
        Pkg.add(toAdd)
    end
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:69 =#
    using ModelingToolkit, DifferentialEquations
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

## ModelJson

```julia
using Ai4EMetaPSE
str = """{
    "name": "Project Name",
    "pkgs": [
        "ModelingToolkit",
        "DifferentialEquations",
        "Ai4EComponentLib.IncompressiblePipe"
    ],
    "components": [
        {
            "name": "Pump",
            "type": "CentrifugalPump",
            "args": {
                "ω": 5000
            }
        },
        {
            "name": "A",
            "type": "Sink_P",
            "args": {}
        },
        {
            "name": "B",
            "type": "Sink_P",
            "args": {}
        },
        {
            "name": "Pipe1",
            "type": "SimplePipe",
            "args": {
                "L": 2.0
            }
        },
        {
            "name": "Pipe2",
            "type": "SimplePipe",
            "args": {
                "L": 7.0
            }
        },
        {
            "name": "Pipe3",
            "type": "SimplePipe",
            "args": {
                "L": 7.0
            }
        },
        {
            "name": "Pipe4",
            "type": "SimplePipe",
            "args": {
                "L": 9.0
            }
        },
        {
            "name": "Pipe5",
            "type": "SimplePipe",
            "args": {
                "L": 5.0
            }
        },
        {
            "name": "Pipe6",
            "type": "SimplePipe",
            "args": {
                "L": 4.0
            }
        },
        {
            "name": "Pipe7",
            "type": "SimplePipe",
            "args": {
                "L": 5.0
            }
        },
        {
            "name": "Pipe8",
            "type": "SimplePipe",
            "args": {
                "L": 1.0
            }
        },
        {
            "name": "Pipe9",
            "type": "SimplePipe",
            "args": {
                "L": 10.0
            }
        },
        {
            "name": "Pipe10",
            "type": "SimplePipe",
            "args": {
                "L": 2.0
            }
        },
        {
            "name": "Pipe11",
            "type": "SimplePipe",
            "args": {
                "L": 2.0
            }
        },
        {
            "name": "Pipe12",
            "type": "SimplePipe",
            "args": {
                "L": 3.0
            }
        },
        {
            "name": "Pipe13",
            "type": "SimplePipe",
            "args": {
                "L": 2.0
            }
        },
        {
            "name": "Pipe14",
            "type": "SimplePipe",
            "args": {
                "L": 1.0
            }
        },
        {
            "name": "Pipe15",
            "type": "SimplePipe",
            "args": {
                "L": 2.0
            }
        },
        {
            "name": "Pipe16",
            "type": "SimplePipe",
            "args": {
                "L": 3.0
            }
        },
        {
            "name": "Pipe17",
            "type": "SimplePipe",
            "args": {
                "L": 6.0
            }
        },
        {
            "name": "Pipe18",
            "type": "SimplePipe",
            "args": {
                "L": 6.0
            }
        },
        {
            "name": "Pipe19",
            "type": "SimplePipe",
            "args": {
                "L": 6.0
            }
        },
        {
            "name": "Pipe20",
            "type": "SimplePipe",
            "args": {
                "L": 1.0
            }
        },
        {
            "name": "Pipe21",
            "type": "SimplePipe",
            "args": {
                "L": 1.0
            }
        },
        {
            "name": "Pipe22",
            "type": "SimplePipe",
            "args": {
                "L": 7.0
            }
        },
        {
            "name": "Pipe23",
            "type": "SimplePipe",
            "args": {
                "L": 3.0
            }
        },
        {
            "name": "Pipe24",
            "type": "SimplePipe",
            "args": {
                "L": 3.0
            }
        },
        {
            "name": "Pipe25",
            "type": "SimplePipe",
            "args": {
                "L": 2.0
            }
        }
    ],
    "connections": [
        [
            "A.port",
            "Pump.in"
        ],
        [
            "Pump.out",
            "Pipe1.in"
        ],
        [
            "Pipe1.out",
            "Pipe2.in",
            "Pipe5.in"
        ],
        [
            "Pipe2.out",
            "Pipe3.in",
            "Pipe6.in"
        ],
        [
            "Pipe3.out",
            "Pipe4.in",
            "Pipe7.in"
        ],
        [
            "Pipe4.out",
            "Pipe10.out",
            "Pipe14.in"
        ],
        [
            "Pipe5.out",
            "Pipe11.in",
            "Pipe12.in"
        ],
        [
            "Pipe6.out",
            "Pipe8.in",
            "Pipe9.in"
        ],
        [
            "Pipe7.out",
            "Pipe9.out",
            "Pipe10.in"
        ],
        [
            "Pipe12.out",
            "Pipe8.out",
            "Pipe13.in"
        ],
        [
            "Pipe13.out",
            "Pipe14.out",
            "Pipe15.in"
        ],
        [
            "Pipe11.out",
            "Pipe19.in",
            "Pipe16.in"
        ],
        [
            "Pipe16.out",
            "Pipe17.in",
            "Pipe20.in"
        ],
        [
            "Pipe17.out",
            "Pipe18.in",
            "Pipe21.in"
        ],
        [
            "Pipe18.out",
            "Pipe15.out",
            "Pipe22.in"
        ],
        [
            "Pipe19.out",
            "Pipe20.out",
            "Pipe23.in"
        ],
        [
            "Pipe21.out",
            "Pipe22.out",
            "Pipe24.in"
        ],
        [
            "Pipe23.out",
            "Pipe24.out",
            "Pipe25.in"
        ],
        [
            "B.port",
            "Pipe25.out"
        ]
    ],
    "u0": [],
    "timespan": [
        0,
        0
    ],
    "solver": "Rosenbrock23"
}"""
solution = generatecode(str, ModelJson())
```

The generated codes are:

```julia
quote
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:64 =#
    using Pkg
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:65 =#
    pkgNeeds = ["ModelingToolkit", "DifferentialEquations", "Ai4EComponentLib"]
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:66 =#
    alreadyGet = keys((Pkg.project()).dependencies)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:67 =#
    toAdd = [package for package = pkgNeeds if package ∉ alreadyGet]
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:68 =#
    if isempty(toAdd)
        nothing
    else
        Pkg.add(toAdd)
    end
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:69 =#
    using ModelingToolkit, DifferentialEquations, Ai4EComponentLib.IncompressiblePipe
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pump = CentrifugalPump(ω = 5000)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named A = Sink_P()
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named B = Sink_P()
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe1 = SimplePipe(L = 2)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe2 = SimplePipe(L = 7)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe3 = SimplePipe(L = 7)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe4 = SimplePipe(L = 9)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe5 = SimplePipe(L = 5)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe6 = SimplePipe(L = 4)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe7 = SimplePipe(L = 5)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe8 = SimplePipe(L = 1)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe9 = SimplePipe(L = 10)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe10 = SimplePipe(L = 2)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe11 = SimplePipe(L = 2)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe12 = SimplePipe(L = 3)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe13 = SimplePipe(L = 2)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe14 = SimplePipe(L = 1)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe15 = SimplePipe(L = 2)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe16 = SimplePipe(L = 3)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe17 = SimplePipe(L = 6)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe18 = SimplePipe(L = 6)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe19 = SimplePipe(L = 6)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe20 = SimplePipe(L = 1)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe21 = SimplePipe(L = 1)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe22 = SimplePipe(L = 7)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe23 = SimplePipe(L = 3)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe24 = SimplePipe(L = 3)
    #= d:\postgraduate\project\develop\Ai4EMetaPSE.jl\src\solution.jl:120 =# @named Pipe25 = SimplePipe(L = 2)
    components = [Pump, A, B, Pipe1, Pipe2, Pipe3, Pipe4, Pipe5, Pipe6, Pipe7, Pipe8, Pipe9, Pipe10, Pipe11, Pipe12, Pipe13, Pipe14, Pipe15, Pipe16, Pipe17, Pipe18, Pipe19, Pipe20, Pipe21, Pipe22, Pipe23, Pipe24, Pipe25]
    eqs = [connect(A.port, Pump.in), connect(Pump.out, Pipe1.in), connect(Pipe1.out, Pipe2.in, Pipe5.in), connect(Pipe2.out, Pipe3.in, Pipe6.in), connect(Pipe3.out, Pipe4.in, Pipe7.in), connect(Pipe4.out, Pipe10.out, Pipe14.in), connect(Pipe5.out, Pipe11.in, Pipe12.in), connect(Pipe6.out, Pipe8.in, Pipe9.in), connect(Pipe7.out, Pipe9.out, Pipe10.in), connect(Pipe12.out, Pipe8.out, Pipe13.in), connect(Pipe13.out, Pipe14.out, Pipe15.in), connect(Pipe11.out, Pipe19.in, Pipe16.in), connect(Pipe16.out, Pipe17.in, Pipe20.in), connect(Pipe17.out, Pipe18.in, Pipe21.in), connect(Pipe18.out, Pipe15.out, Pipe22.in), connect(Pipe19.out, Pipe20.out, Pipe23.in), connect(Pipe21.out, Pipe22.out, Pipe24.in), connect(Pipe23.out, Pipe24.out, Pipe25.in), connect(B.port, Pipe25.out)]
    init = Dict()
    timespan = (0.0, 0.0)
    Project_Name = solve(ODEProblem(structural_simplify(compose(ODESystem(eqs, t; name = :Model), components; name = :system)), init, timespan), Rosenbrock23())
end
```

## ComponentsJson

```julia
using Ai4EMetaPSE
str = """{
    "name":"TransitionPipe",
    "args":[
        "λ1=1.0",
        "λ2=1.0",
        "λ3=1.0", 
        "n=10", 
        "f=0.016", 
        "D=0.2", 
        "L=100", 
        "T=300", 
        "pins=0.56e6", 
        "pouts=0.56e6"
    ], 
    "custom_Code":[
        "RT = 287.11 * T",
        "A0 = pi / 4 * D^2",
        "c10 = RT / A0",
        "c20 = c10 * f / 2 / D",
        "dx=L/n",
        "qms = sqrt(abs(pins^2 - pouts^2) / (f * L * RT / D / A0 / A0))",
        "pms = map(i->sqrt(pins^2 * (1 - (i-1) / n) + pouts^2 * (i-1) / n),1:n+1)"
    ],
    "components":[
        {
            "name": "inlet",
            "type": "FlowPort",
            "args": {
                "T": 300
            }
        },
        {
            "name": "outlet",
            "type": "FlowPort",
            "args": {
                "T": 300
            }
        }
    ],
    "variablesInclude":[],
    "variables": [
        "qm[1:n](t)=qms",
        "p[1:n+1](t)=pms"
    ],
    "parameters": [
        "A = A0*λ2",
        "c1 = c10*λ1",
        "c2 = c20*λ3",
        "dx = L / n",
        "f = f"
    ],
    "equations": [
        "[der(p[i]) = c1 * (qm[i-1] - qm[i]) / dx for i = 2:n]",
        "[der(qm[i]) = (c1 * qm[i]^2 / (0.5 * (p[i+1] + p[i]))^2 - A) * (p[i+1] - p[i]) / dx + c1 * qm[i] / (0.5 * (p[i+1] + p[i])) * (qm[i-1] - qm[i+1]) / dx - c2 * qm[i] * abs(qm[i]) / (0.5 * (p[i+1] + p[i])) for i = 2:n-1]",
        "p[1] = inlet.p",
        "p[n+1] = outlet.p",
        "qm[n] = -outlet.qm",
        "qm[1] = inlet.qm",
        "der(qm[1]) = (c1 * qm[1]^2 / (0.5 * (p[2] + p[1]))^2 - A) * (p[2] - p[1]) / dx + c1 * qm[1] / (0.5 * (p[2] + p[1])) * (3 * qm[1] - 4 * qm[2] + qm[3]) / dx - c2 * qm[1] * abs(qm[1]) / (0.5 * (p[2] + p[1]))",
        "der(qm[n]) = (c1 * qm[n]^2 / (0.5 * (p[n+1] + p[n]))^2 - A) * (p[n+1] - p[n]) / dx + c1 * qm[n] / (0.5 * (p[n+1] + p[n])) * (-3 * qm[n] + 4 * qm[n-1] - qm[n-2]) / dx - c2 * qm[n] * abs(qm[n]) / (0.5 * (p[n+1] + p[n]))"
    ]
}"""
solution = generatecode(str, ComponentsJson())
```

The generated codes are:

```julia
function TransitionPipe(; name, λ1 = 1.0, λ2 = 1.0, λ3 = 1.0, n = 10, f = 0.016, D = 0.2, L = 100, T = 300, pins = 560000.0, pouts = 560000.0)
    begin
        RT = 287.11T
        A0 = (pi / 4) * D ^ 2
        c10 = RT / A0
        c20 = ((c10 * f) / 2) / D
        dx = L / n
        qms = sqrt(abs(pins ^ 2 - pouts ^ 2) / ((((f * L * RT) / D) / A0) / A0))
        pms = map((i->begin
                        #= none:1 =#
                        sqrt(pins ^ 2 * (1 - (i - 1) / n) + (pouts ^ 2 * (i - 1)) / n)
                    end), 1:n + 1)
    end
    #= c:\Users\A\Desktop\git\Ai4EMetaPSE.jl\src\solution.jl:127 =# @named inlet = FlowPort(T = 300)
    #= c:\Users\A\Desktop\git\Ai4EMetaPSE.jl\src\solution.jl:127 =# @named outlet = FlowPort(T = 300)
    components = [inlet, outlet]
    #= none:1 =# @variables begin
            t
            (qm[1:n])(t) = begin
                    #= none:1 =#
                    qms
                end
            (p[1:n + 1])(t) = begin
                    #= none:1 =#
                    pms
                end
        end
    #= none:1 =# @parameters begin
            A = A0 * λ2
            c1 = c10 * λ1
            c2 = c20 * λ3
            dx = L / n
            f = f
        end
    begin
        der = Differential(t)
        eqs = []
        append!(eqs, [[der(p[i]) ~ (c1 * (qm[i - 1] - qm[i])) / dx for i = 2:n]])
        append!(eqs, [[der(qm[i]) ~ ((((c1 * qm[i] ^ 2) / (0.5 * (p[i + 1] + p[i])) ^ 2 - A) * (p[i + 1] - p[i])) / dx + (((c1 * qm[i]) / (0.5 * (p[i + 1] + p[i]))) * (qm[i - 1] - qm[i + 1])) / dx) - (c2 * qm[i] * abs(qm[i])) / (0.5 * (p[i + 1] + p[i])) for i = 2:n - 1]])
        append!(eqs, [p[1] ~ inlet.p])
        append!(eqs, [p[n + 1] ~ outlet.p])
        append!(eqs, [qm[n] ~ -(outlet.qm)])
        append!(eqs, [qm[1] ~ inlet.qm])
        append!(eqs, [der(qm[1]) ~ ((((c1 * qm[1] ^ 2) / (0.5 * (p[2] + p[1])) ^ 2 - A) * (p[2] - p[1])) / dx + (((c1 * qm[1]) / (0.5 * (p[2] + p[1]))) * ((3 * qm[1] - 4 * qm[2]) + qm[3])) / dx) - (c2 * qm[1] * abs(qm[1])) / (0.5 * (p[2] + p[1]))])
        append!(eqs, [der(qm[n]) ~ ((((c1 * qm[n] ^ 2) / (0.5 * (p[n + 1] + p[n])) ^ 2 - A) * (p[n + 1] - p[n])) / dx + (((c1 * qm[n]) / (0.5 * (p[n + 1] + p[n]))) * ((-3 * qm[n] + 4 * qm[n - 1]) - qm[n - 2])) / dx) - (c2 * qm[n] * abs(qm[n])) / (0.5 * (p[n + 1] + p[n]))])
        compose(ODESystem(eqs, t, sts, ps; name = name), components)
    end
end
```