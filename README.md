# Ai4EMetaPSE

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ai4energy.github.io/Ai4EMetaPSE.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://ai4energy.github.io/Ai4EMetaPSE.jl/dev/)
[![Build Status](https://github.com/ai4energy/Ai4EMetaPSE.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ai4energy/Ai4EMetaPSE.jl/actions/workflows/CI.yml)

Ai4EMetaPSE.jl can parse:
* julia ASTs(abstract syntax tree) to a json file
* json file to julia AST
* a json file that include differential equations and generate julia solution code based on [Sciml Ecosystem](https://sciml.ai/).

## Install

```
using Pkg
Pkg.add("Ai4EMetaPSE")
```

## Document

see more infomation in [docs](https://ai4energy.github.io/Ai4EMetaPSE.jl/dev/)

## Example

```julia
using Ai4EMetaPSE
open(`s.json`, "w") do io

    # parse a function f(x) to json file
    s = @julia2json function f(x)
        x + 1
    end

    JSON3.pretty(io, s)
end
```

In `s.json`:

```json
{
    "args": [
        {
            "args": [
                "f",
                "x"
            ],
            "head": "call"
        },
        {
            "args": [
                {
                    "LINENUMBERNODE": {
                        "line": 11,
                        "file": "e:\\develop\\Ai4EMetaPSE.jl\\test\\julia2json.jl"
                    }
                },
                {
                    "LINENUMBERNODE": {
                        "line": 12,
                        "file": "e:\\develop\\Ai4EMetaPSE.jl\\test\\julia2json.jl"
                    }
                },
                {
                    "args": [
                        "+",
                        "x",
                        1
                    ],
                    "head": "call"
                }
            ],
            "head": "block"
        }
    ],
    "head": "function"
}
```
