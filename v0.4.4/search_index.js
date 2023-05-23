var documenterSearchIndex = {"docs":
[{"location":"Examples/julia2json/#julia2json-Examples","page":"julia2json Examples","title":"julia2json Examples","text":"","category":"section"},{"location":"Examples/julia2json/#julia2json-and-json2julia","page":"julia2json Examples","title":"julia2json and json2julia","text":"","category":"section"},{"location":"Examples/julia2json/","page":"julia2json Examples","title":"julia2json Examples","text":"julia2json converts a Julia expression to a JSON string and json2julia converts a JSON string to a Julia expression.","category":"page"},{"location":"Examples/julia2json/#Examples:","page":"julia2json Examples","title":"Examples:","text":"","category":"section"},{"location":"Examples/julia2json/","page":"julia2json Examples","title":"julia2json Examples","text":"using Ai4EMetaPSE\nusing JSON3\nusing Test\n\nexpr = :(function f(x)\n    x + 1\nend)\nfile = \"s.json\"\nopen(file, \"w\") do io\n    s = @julia2json function f(x)\n        x + 1\n    end\n    JSON3.pretty(io, s)\nend\nex = json2julia(file)\n@test eval(ex)(1) == eval(expr)(1)","category":"page"},{"location":"Examples/julia2json/","page":"julia2json Examples","title":"julia2json Examples","text":"expr = :(function f(x)\n    x + 1\nend)\nfile = \"s.json\"\ns = @julia2json function f(x)\n    x + 1\nend\nJSON3.pretty(file, s)\nex = json2julia(file)\n@test eval(ex)(1) == eval(expr)(1)","category":"page"},{"location":"Examples/julia2json/","page":"julia2json Examples","title":"julia2json Examples","text":"expr = :(function f(x)\n    x = x + 1\n    x *= 3\n    x -= 2\nend)\nfile = \"s.json\"\nopen(file, \"w\") do io\n    s = julia2json(\"function f(x)\n        x = x + 1\n        x *= 3\n        x -= 2\n    end\")\n    JSON3.write(io, s)\nend\nex = json2julia(file)\n@test eval(ex)(1) == eval(expr)(1)\n","category":"page"},{"location":"Examples/julia2json/","page":"julia2json Examples","title":"julia2json Examples","text":"expr = :(function f(x)\n    x = x + 1\n    x *= 3\n    x -= 2\n    begin\n        @assert x isa Number\n        return x\n    end\nend)\nfile = \"s.json\"\nopen(file, \"w\") do io\n    s = julia2json(expr)\n    JSON3.pretty(io, s)\nend\nex = json2julia(file)\n@test eval(ex)(1) == eval(expr)(1)","category":"page"},{"location":"Examples/example/#Differential-Equations-Json-Examples","page":"Differential Equations Json Examples","title":"Differential Equations Json Examples","text":"","category":"section"},{"location":"Examples/example/#CommonJson","page":"Differential Equations Json Examples","title":"CommonJson","text":"","category":"section"},{"location":"Examples/example/","page":"Differential Equations Json Examples","title":"Differential Equations Json Examples","text":"using Ai4EMetaPSE\nstr = \"\"\"{\n    \"name\": \"Name\",\n    \"pkgs\": [\n        \"ModelingToolkit\",\n        \"DifferentialEquations\"\n    ],\n    \"variables\": [\n        \"x(t) = 1.0\",\n        \"y(t) = 1.0\",\n        \"z(t) = 2.0\"\n    ],\n    \"parameters\": [\n        \"σ = 1.0\",\n        \"ρ = 3.0\",\n        \"β = 5.0\" \n    ],\n    \"equations\": [\n        \"der(x) = σ*(y - x)\",\n        \"der(y) = x*(ρ - z) - y\",\n        \"der(z) = x*y - β*z\"\n    ],\n    \"u0\": [\n        \"x => 1.0\",\n        \"y => 2.0\",\n        \"z => 3.0\"\n    ],\n    \"timespan\": [0,1,0.1],\n    \"solver\": \"Rosenbrock23\"\n}\"\"\"\nsolution = generatecode(str, CommonJson())","category":"page"},{"location":"Examples/example/","page":"Differential Equations Json Examples","title":"Differential Equations Json Examples","text":"The generated codes are:","category":"page"},{"location":"Examples/example/","page":"Differential Equations Json Examples","title":"Differential Equations Json Examples","text":"quote\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:64 =#\n    using Pkg\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:65 =#\n    pkgNeeds = [\"ModelingToolkit\", \"DifferentialEquations\"]\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:66 =#\n    alreadyGet = keys((Pkg.project()).dependencies)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:67 =#\n    toAdd = [package for package = pkgNeeds if package ∉ alreadyGet]\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:68 =#\n    if isempty(toAdd)\n        nothing\n    else\n        Pkg.add(toAdd)\n    end\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:69 =#\n    using ModelingToolkit, DifferentialEquations\n    #= none:1 =# @variables begin\n            t\n            x(t) = begin\n                    #= none:1 =#\n                    1.0\n                end\n            y(t) = begin\n                    #= none:1 =#\n                    1.0\n                end\n            z(t) = begin\n                    #= none:1 =#\n                    2.0\n                end\n        end\n    #= none:1 =# @parameters begin\n            σ = 1.0\n            ρ = 3.0\n            β = 5.0\n        end\n    begin\n        der = Differential(t)\n        eqs = []\n        append!(eqs, [der(x) ~ σ * (y - x)])\n        append!(eqs, [der(y) ~ x * (ρ - z) - y])\n        append!(eqs, [der(z) ~ x * y - β * z])\n    end\n    init = Dict(x => 1.0, y => 2.0, z => 3.0)\n    timespan = (0.0, 1.0)\n    Name = solve(ODEProblem(structural_simplify(ODESystem(eqs, t; name = :Model)), init, timespan), Rosenbrock23())\nend","category":"page"},{"location":"Examples/example/#ModelJson","page":"Differential Equations Json Examples","title":"ModelJson","text":"","category":"section"},{"location":"Examples/example/","page":"Differential Equations Json Examples","title":"Differential Equations Json Examples","text":"using Ai4EMetaPSE\nstr = \"\"\"{\n    \"name\": \"Project Name\",\n    \"pkgs\": [\n        \"ModelingToolkit\",\n        \"DifferentialEquations\",\n        \"Ai4EComponentLib.IncompressiblePipe\"\n    ],\n    \"components\": [\n        {\n            \"name\": \"Pump\",\n            \"type\": \"CentrifugalPump\",\n            \"args\": {\n                \"ω\": 5000\n            }\n        },\n        {\n            \"name\": \"A\",\n            \"type\": \"Sink_P\",\n            \"args\": {}\n        },\n        {\n            \"name\": \"B\",\n            \"type\": \"Sink_P\",\n            \"args\": {}\n        },\n        {\n            \"name\": \"Pipe1\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 2.0\n            }\n        },\n        {\n            \"name\": \"Pipe2\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 7.0\n            }\n        },\n        {\n            \"name\": \"Pipe3\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 7.0\n            }\n        },\n        {\n            \"name\": \"Pipe4\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 9.0\n            }\n        },\n        {\n            \"name\": \"Pipe5\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 5.0\n            }\n        },\n        {\n            \"name\": \"Pipe6\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 4.0\n            }\n        },\n        {\n            \"name\": \"Pipe7\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 5.0\n            }\n        },\n        {\n            \"name\": \"Pipe8\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 1.0\n            }\n        },\n        {\n            \"name\": \"Pipe9\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 10.0\n            }\n        },\n        {\n            \"name\": \"Pipe10\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 2.0\n            }\n        },\n        {\n            \"name\": \"Pipe11\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 2.0\n            }\n        },\n        {\n            \"name\": \"Pipe12\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 3.0\n            }\n        },\n        {\n            \"name\": \"Pipe13\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 2.0\n            }\n        },\n        {\n            \"name\": \"Pipe14\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 1.0\n            }\n        },\n        {\n            \"name\": \"Pipe15\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 2.0\n            }\n        },\n        {\n            \"name\": \"Pipe16\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 3.0\n            }\n        },\n        {\n            \"name\": \"Pipe17\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 6.0\n            }\n        },\n        {\n            \"name\": \"Pipe18\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 6.0\n            }\n        },\n        {\n            \"name\": \"Pipe19\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 6.0\n            }\n        },\n        {\n            \"name\": \"Pipe20\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 1.0\n            }\n        },\n        {\n            \"name\": \"Pipe21\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 1.0\n            }\n        },\n        {\n            \"name\": \"Pipe22\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 7.0\n            }\n        },\n        {\n            \"name\": \"Pipe23\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 3.0\n            }\n        },\n        {\n            \"name\": \"Pipe24\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 3.0\n            }\n        },\n        {\n            \"name\": \"Pipe25\",\n            \"type\": \"SimplePipe\",\n            \"args\": {\n                \"L\": 2.0\n            }\n        }\n    ],\n    \"connections\": [\n        [\n            \"A.port\",\n            \"Pump.in\"\n        ],\n        [\n            \"Pump.out\",\n            \"Pipe1.in\"\n        ],\n        [\n            \"Pipe1.out\",\n            \"Pipe2.in\",\n            \"Pipe5.in\"\n        ],\n        [\n            \"Pipe2.out\",\n            \"Pipe3.in\",\n            \"Pipe6.in\"\n        ],\n        [\n            \"Pipe3.out\",\n            \"Pipe4.in\",\n            \"Pipe7.in\"\n        ],\n        [\n            \"Pipe4.out\",\n            \"Pipe10.out\",\n            \"Pipe14.in\"\n        ],\n        [\n            \"Pipe5.out\",\n            \"Pipe11.in\",\n            \"Pipe12.in\"\n        ],\n        [\n            \"Pipe6.out\",\n            \"Pipe8.in\",\n            \"Pipe9.in\"\n        ],\n        [\n            \"Pipe7.out\",\n            \"Pipe9.out\",\n            \"Pipe10.in\"\n        ],\n        [\n            \"Pipe12.out\",\n            \"Pipe8.out\",\n            \"Pipe13.in\"\n        ],\n        [\n            \"Pipe13.out\",\n            \"Pipe14.out\",\n            \"Pipe15.in\"\n        ],\n        [\n            \"Pipe11.out\",\n            \"Pipe19.in\",\n            \"Pipe16.in\"\n        ],\n        [\n            \"Pipe16.out\",\n            \"Pipe17.in\",\n            \"Pipe20.in\"\n        ],\n        [\n            \"Pipe17.out\",\n            \"Pipe18.in\",\n            \"Pipe21.in\"\n        ],\n        [\n            \"Pipe18.out\",\n            \"Pipe15.out\",\n            \"Pipe22.in\"\n        ],\n        [\n            \"Pipe19.out\",\n            \"Pipe20.out\",\n            \"Pipe23.in\"\n        ],\n        [\n            \"Pipe21.out\",\n            \"Pipe22.out\",\n            \"Pipe24.in\"\n        ],\n        [\n            \"Pipe23.out\",\n            \"Pipe24.out\",\n            \"Pipe25.in\"\n        ],\n        [\n            \"B.port\",\n            \"Pipe25.out\"\n        ]\n    ],\n    \"u0\": [],\n    \"timespan\": [\n        0,\n        0,\n        0\n    ],\n    \"solver\": \"Rosenbrock23\"\n}\"\"\"\nsolution = generatecode(str, ModelJson())","category":"page"},{"location":"Examples/example/","page":"Differential Equations Json Examples","title":"Differential Equations Json Examples","text":"The generated codes are:","category":"page"},{"location":"Examples/example/","page":"Differential Equations Json Examples","title":"Differential Equations Json Examples","text":"quote\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:64 =#\n    using Pkg\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:65 =#\n    pkgNeeds = [\"ModelingToolkit\", \"DifferentialEquations\", \"Ai4EComponentLib\"]\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:66 =#\n    alreadyGet = keys((Pkg.project()).dependencies)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:67 =#\n    toAdd = [package for package = pkgNeeds if package ∉ alreadyGet]\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:68 =#\n    if isempty(toAdd)\n        nothing\n    else\n        Pkg.add(toAdd)\n    end\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:69 =#\n    using ModelingToolkit, DifferentialEquations, Ai4EComponentLib.IncompressiblePipe\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pump = CentrifugalPump(ω = 5000)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named A = Sink_P()\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named B = Sink_P()\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe1 = SimplePipe(L = 2)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe2 = SimplePipe(L = 7)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe3 = SimplePipe(L = 7)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe4 = SimplePipe(L = 9)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe5 = SimplePipe(L = 5)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe6 = SimplePipe(L = 4)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe7 = SimplePipe(L = 5)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe8 = SimplePipe(L = 1)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe9 = SimplePipe(L = 10)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe10 = SimplePipe(L = 2)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe11 = SimplePipe(L = 2)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe12 = SimplePipe(L = 3)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe13 = SimplePipe(L = 2)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe14 = SimplePipe(L = 1)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe15 = SimplePipe(L = 2)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe16 = SimplePipe(L = 3)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe17 = SimplePipe(L = 6)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe18 = SimplePipe(L = 6)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe19 = SimplePipe(L = 6)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe20 = SimplePipe(L = 1)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe21 = SimplePipe(L = 1)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe22 = SimplePipe(L = 7)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe23 = SimplePipe(L = 3)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe24 = SimplePipe(L = 3)\n    #= d:\\postgraduate\\project\\develop\\Ai4EMetaPSE.jl\\src\\solution.jl:120 =# @named Pipe25 = SimplePipe(L = 2)\n    components = [Pump, A, B, Pipe1, Pipe2, Pipe3, Pipe4, Pipe5, Pipe6, Pipe7, Pipe8, Pipe9, Pipe10, Pipe11, Pipe12, Pipe13, Pipe14, Pipe15, Pipe16, Pipe17, Pipe18, Pipe19, Pipe20, Pipe21, Pipe22, Pipe23, Pipe24, Pipe25]\n    eqs = [connect(A.port, Pump.in), connect(Pump.out, Pipe1.in), connect(Pipe1.out, Pipe2.in, Pipe5.in), connect(Pipe2.out, Pipe3.in, Pipe6.in), connect(Pipe3.out, Pipe4.in, Pipe7.in), connect(Pipe4.out, Pipe10.out, Pipe14.in), connect(Pipe5.out, Pipe11.in, Pipe12.in), connect(Pipe6.out, Pipe8.in, Pipe9.in), connect(Pipe7.out, Pipe9.out, Pipe10.in), connect(Pipe12.out, Pipe8.out, Pipe13.in), connect(Pipe13.out, Pipe14.out, Pipe15.in), connect(Pipe11.out, Pipe19.in, Pipe16.in), connect(Pipe16.out, Pipe17.in, Pipe20.in), connect(Pipe17.out, Pipe18.in, Pipe21.in), connect(Pipe18.out, Pipe15.out, Pipe22.in), connect(Pipe19.out, Pipe20.out, Pipe23.in), connect(Pipe21.out, Pipe22.out, Pipe24.in), connect(Pipe23.out, Pipe24.out, Pipe25.in), connect(B.port, Pipe25.out)]\n    init = Dict()\n    timespan = (0.0, 0.0)\n    Project_Name = solve(ODEProblem(structural_simplify(compose(ODESystem(eqs, t; name = :Model), components; name = :system)), init, timespan), Rosenbrock23())\nend","category":"page"},{"location":"Examples/example/#ComponentsJson","page":"Differential Equations Json Examples","title":"ComponentsJson","text":"","category":"section"},{"location":"Examples/example/","page":"Differential Equations Json Examples","title":"Differential Equations Json Examples","text":"using Ai4EMetaPSE\nstr = \"\"\"{\n    \"name\":\"TransitionPipe\",\n    \"args\":[\n        \"λ1=1.0\",\n        \"λ2=1.0\",\n        \"λ3=1.0\", \n        \"n=10\", \n        \"f=0.016\", \n        \"D=0.2\", \n        \"L=100\", \n        \"T=300\", \n        \"pins=0.56e6\", \n        \"pouts=0.56e6\"\n    ], \n    \"custom_Code\":[\n        \"RT = 287.11 * T\",\n        \"A0 = pi / 4 * D^2\",\n        \"c10 = RT / A0\",\n        \"c20 = c10 * f / 2 / D\",\n        \"dx=L/n\",\n        \"qms = sqrt(abs(pins^2 - pouts^2) / (f * L * RT / D / A0 / A0))\",\n        \"pms = map(i->sqrt(pins^2 * (1 - (i-1) / n) + pouts^2 * (i-1) / n),1:n+1)\"\n    ],\n    \"components\":[\n        {\n            \"name\": \"inlet\",\n            \"type\": \"FlowPort\",\n            \"args\": {\n                \"T\": 300\n            }\n        },\n        {\n            \"name\": \"outlet\",\n            \"type\": \"FlowPort\",\n            \"args\": {\n                \"T\": 300\n            }\n        }\n    ],\n    \"variablesInclude\":[],\n    \"variables\": [\n        \"qm[1:n](t)=qms\",\n        \"p[1:n+1](t)=pms\"\n    ],\n    \"parameters\": [\n        \"A = A0*λ2\",\n        \"c1 = c10*λ1\",\n        \"c2 = c20*λ3\",\n        \"dx = L / n\",\n        \"f = f\"\n    ],\n    \"equations\": [\n        \"[der(p[i]) = c1 * (qm[i-1] - qm[i]) / dx for i = 2:n]\",\n        \"[der(qm[i]) = (c1 * qm[i]^2 / (0.5 * (p[i+1] + p[i]))^2 - A) * (p[i+1] - p[i]) / dx + c1 * qm[i] / (0.5 * (p[i+1] + p[i])) * (qm[i-1] - qm[i+1]) / dx - c2 * qm[i] * abs(qm[i]) / (0.5 * (p[i+1] + p[i])) for i = 2:n-1]\",\n        \"p[1] = inlet.p\",\n        \"p[n+1] = outlet.p\",\n        \"qm[n] = -outlet.qm\",\n        \"qm[1] = inlet.qm\",\n        \"der(qm[1]) = (c1 * qm[1]^2 / (0.5 * (p[2] + p[1]))^2 - A) * (p[2] - p[1]) / dx + c1 * qm[1] / (0.5 * (p[2] + p[1])) * (3 * qm[1] - 4 * qm[2] + qm[3]) / dx - c2 * qm[1] * abs(qm[1]) / (0.5 * (p[2] + p[1]))\",\n        \"der(qm[n]) = (c1 * qm[n]^2 / (0.5 * (p[n+1] + p[n]))^2 - A) * (p[n+1] - p[n]) / dx + c1 * qm[n] / (0.5 * (p[n+1] + p[n])) * (-3 * qm[n] + 4 * qm[n-1] - qm[n-2]) / dx - c2 * qm[n] * abs(qm[n]) / (0.5 * (p[n+1] + p[n]))\"\n    ]\n}\"\"\"\nsolution = generatecode(str, ComponentsJson())","category":"page"},{"location":"Examples/example/","page":"Differential Equations Json Examples","title":"Differential Equations Json Examples","text":"The generated codes are:","category":"page"},{"location":"Examples/example/","page":"Differential Equations Json Examples","title":"Differential Equations Json Examples","text":"function TransitionPipe(; name, λ1 = 1.0, λ2 = 1.0, λ3 = 1.0, n = 10, f = 0.016, D = 0.2, L = 100, T = 300, pins = 560000.0, pouts = 560000.0)\n    begin\n        RT = 287.11T\n        A0 = (pi / 4) * D ^ 2\n        c10 = RT / A0\n        c20 = ((c10 * f) / 2) / D\n        dx = L / n\n        qms = sqrt(abs(pins ^ 2 - pouts ^ 2) / ((((f * L * RT) / D) / A0) / A0))\n        pms = map((i->begin\n                        #= none:1 =#\n                        sqrt(pins ^ 2 * (1 - (i - 1) / n) + (pouts ^ 2 * (i - 1)) / n)\n                    end), 1:n + 1)\n    end\n    #= c:\\Users\\A\\Desktop\\git\\Ai4EMetaPSE.jl\\src\\solution.jl:127 =# @named inlet = FlowPort(T = 300)\n    #= c:\\Users\\A\\Desktop\\git\\Ai4EMetaPSE.jl\\src\\solution.jl:127 =# @named outlet = FlowPort(T = 300)\n    components = [inlet, outlet]\n    #= none:1 =# @variables begin\n            t\n            (qm[1:n])(t) = begin\n                    #= none:1 =#\n                    qms\n                end\n            (p[1:n + 1])(t) = begin\n                    #= none:1 =#\n                    pms\n                end\n        end\n    #= none:1 =# @parameters begin\n            A = A0 * λ2\n            c1 = c10 * λ1\n            c2 = c20 * λ3\n            dx = L / n\n            f = f\n        end\n    begin\n        der = Differential(t)\n        eqs = []\n        append!(eqs, [[der(p[i]) ~ (c1 * (qm[i - 1] - qm[i])) / dx for i = 2:n]])\n        append!(eqs, [[der(qm[i]) ~ ((((c1 * qm[i] ^ 2) / (0.5 * (p[i + 1] + p[i])) ^ 2 - A) * (p[i + 1] - p[i])) / dx + (((c1 * qm[i]) / (0.5 * (p[i + 1] + p[i]))) * (qm[i - 1] - qm[i + 1])) / dx) - (c2 * qm[i] * abs(qm[i])) / (0.5 * (p[i + 1] + p[i])) for i = 2:n - 1]])\n        append!(eqs, [p[1] ~ inlet.p])\n        append!(eqs, [p[n + 1] ~ outlet.p])\n        append!(eqs, [qm[n] ~ -(outlet.qm)])\n        append!(eqs, [qm[1] ~ inlet.qm])\n        append!(eqs, [der(qm[1]) ~ ((((c1 * qm[1] ^ 2) / (0.5 * (p[2] + p[1])) ^ 2 - A) * (p[2] - p[1])) / dx + (((c1 * qm[1]) / (0.5 * (p[2] + p[1]))) * ((3 * qm[1] - 4 * qm[2]) + qm[3])) / dx) - (c2 * qm[1] * abs(qm[1])) / (0.5 * (p[2] + p[1]))])\n        append!(eqs, [der(qm[n]) ~ ((((c1 * qm[n] ^ 2) / (0.5 * (p[n + 1] + p[n])) ^ 2 - A) * (p[n + 1] - p[n])) / dx + (((c1 * qm[n]) / (0.5 * (p[n + 1] + p[n]))) * ((-3 * qm[n] + 4 * qm[n - 1]) - qm[n - 2])) / dx) - (c2 * qm[n] * abs(qm[n])) / (0.5 * (p[n + 1] + p[n]))])\n        compose(ODESystem(eqs, t, sts, ps; name = name), components)\n    end\nend","category":"page"},{"location":"API/api/#API-in-Ai4EMetaPSE","page":"API","title":"API in Ai4EMetaPSE","text":"","category":"section"},{"location":"API/api/#index","page":"API","title":"index","text":"","category":"section"},{"location":"API/api/","page":"API","title":"API","text":"Pages = [\"api.md\"]","category":"page"},{"location":"API/api/#API","page":"API","title":"API","text":"","category":"section"},{"location":"API/api/","page":"API","title":"API","text":"Modules = [Ai4EMetaPSE]","category":"page"},{"location":"API/api/#Ai4EMetaPSE.MetaSolution","page":"API","title":"Ai4EMetaPSE.MetaSolution","text":"script::Expr\njm::Ai4EMetaPSE.jsonModel\n\nThe solution type.\n\nscript: the generated code\njm: store json file imformation\n\n\n\n\n\n","category":"type"},{"location":"API/api/#Ai4EMetaPSE.evalSolution-Tuple{MetaSolution}","page":"API","title":"Ai4EMetaPSE.evalSolution","text":"evalSolution(solution::MetaSolution) -> Any\n\n\nTo eval the script in MetaSolution at Main\n\nsolution: the result from generatecode\n\n\n\n\n\n","category":"method"},{"location":"API/api/#Ai4EMetaPSE.generatecode-Tuple{AbstractString, Ai4EMetaPSE.jsonModel}","page":"API","title":"Ai4EMetaPSE.generatecode","text":"generatecode(\n    io::AbstractString,\n    type::Ai4EMetaPSE.jsonModel;\n    write2File\n) -> MetaSolution\n\n\nTo read the json file and return MetaSolution type\n\nio: Json file name or json strings\ntype: The type of json, CommonJson , ModelJson and so on.\nwrite2File: The name of script to be generated or nothing. If passing nothing, it will not generate script. Default: nothing\n\nExamples:\n\nstr = \"\"\"{\n    \"name\": \"Name\",\n    \"pkgs\": [\n        \"ModelingToolkit\",\n        \"DifferentialEquations\"\n    ],\n    \"variables\": [\n        \"x(t) = 1.0\",\n        \"y(t) = 1.0\",\n        \"z(t) = 2.0\"\n    ],\n    \"parameters\": [\n        \"σ = 1.0\",\n        \"ρ = 3.0\",\n        \"β = 5.0\" \n    ],\n    \"equations\": [\n        \"der(x) = σ*(y - x)\",\n        \"der(y) = x*(ρ - z) - y\",\n        \"der(z) = x*y - β*z\"\n    ],\n    \"u0\": [\n        \"x => 1.0\",\n        \"y => 2.0\",\n        \"z => 3.0\"\n    ],\n    \"timespan\": [0,1,0.1],\n    \"solver\": \"Rosenbrock23\"\n}\"\"\"\nsolution = generatecode(str, CommonJson(); write2File=\"s.jl\")\n\n\n\n\n\n","category":"method"},{"location":"API/api/#Ai4EMetaPSE.getscript-Tuple{MetaSolution}","page":"API","title":"Ai4EMetaPSE.getscript","text":"getscript(solution::MetaSolution) -> Expr\n\n\nTo get the script in MetaSolution\n\nsolution: the result from generatecode\n\n\n\n\n\n","category":"method"},{"location":"API/api/#Ai4EMetaPSE.json2julia-Tuple{AbstractString}","page":"API","title":"Ai4EMetaPSE.json2julia","text":"json2julia(io::AbstractString) -> Expr\n\n\njson2julia converts a JSON string to a Julia expression.\n\nExamples:\n\nfile = joinpath(@__DIR__, \"JsonFiles/julia2jsonTest1.json\")\nex = json2julia(file)\n\n\n\n\n\n","category":"method"},{"location":"API/api/#Ai4EMetaPSE.julia2json-Tuple{String}","page":"API","title":"Ai4EMetaPSE.julia2json","text":"julia2json(str::String) -> Dict{Symbol, Any}\n\n\njulia2json converts a Julia expression to a JSON string.\n\nExamples:\n\njulia2json accepts a string or an expression.\n\nex = \"function f(x)\nx + 1\nend\" |> julia2json\nJSON3.pretty(file, ex)\n\nex = :(function f(x)\nx + 1\nend) |> julia2json\nJSON3.pretty(file, ex)\n\njulia2json can also be used as a macro\n\ns = @julia2json function f(x)\n    x + 1\nend\nJSON3.pretty(file, s)\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = Ai4EMetaPSE","category":"page"},{"location":"#Ai4EMetaPSE","page":"Home","title":"Ai4EMetaPSE","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for Ai4EMetaPSE.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Ai4EMetaPSE.jl parses a json file that include differential equations and generate julia solution code based on Sciml Ecosystem.","category":"page"},{"location":"#Install","page":"Home","title":"Install","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using Pkg\nPkg.add(\"Ai4EMetaPSE\")","category":"page"}]
}