# Ai4EMetaPSE

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jake484.github.io/Ai4EMetaPSE.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jake484.github.io/Ai4EMetaPSE.jl/dev/)
[![Build Status](https://github.com/jake484/Ai4EMetaPSE.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jake484/Ai4EMetaPSE.jl/actions/workflows/CI.yml)

Ai4EMetaPSE.jl parses a json file that include differential equations and generate julia solution script based on [Sciml Ecosystem](https://sciml.ai/). 

Examples:

**JSON File**:

```json
{
    "name": "A test",
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

**Solution Script**:

```julia

```