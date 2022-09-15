# Ai4EMetaPSE

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jake484.github.io/Ai4EMetaPSE.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jake484.github.io/Ai4EMetaPSE.jl/dev/)
[![Build Status](https://github.com/jake484/Ai4EMetaPSE.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jake484/Ai4EMetaPSE.jl/actions/workflows/CI.yml)

Ai4EMetaPSE.jl parses a json file that include differential equations and generate julia solution script based on [Sciml Ecosystem](https://sciml.ai/). 

Examples:

**JSON File**:

```json
{
    "name": "Name",
    "varibles":[],
    "parameters": [],
    "equations": [],
    "u0": [],
    "timespan": [],
    "solver": []
}
```

**Solution Script**:

```julia

```