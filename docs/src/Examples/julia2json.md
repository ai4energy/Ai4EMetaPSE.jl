# julia2json Examples

## julia2json and json2julia

julia2json converts a Julia expression to a JSON string and json2julia converts a JSON string to a Julia expression.

### Examples:

```@example 1    
using Ai4EMetaPSE
using JSON3
using Test

expr = :(function f(x)
    x + 1
end)
file = "s.json"
open(file, "w") do io
    s = @julia2json function f(x)
        x + 1
    end
    JSON3.pretty(io, s)
end
ex = json2julia(file)
@test eval(ex)(1) == eval(expr)(1)
```

```@example 1    
expr = :(function f(x)
    x + 1
end)
file = "s.json"
s = @julia2json function f(x)
    x + 1
end
JSON3.pretty(file, s)
ex = json2julia(file)
@test eval(ex)(1) == eval(expr)(1)
```

```@example 1    
expr = :(function f(x)
    x = x + 1
    x *= 3
    x -= 2
end)
file = "s.json"
open(file, "w") do io
    s = julia2json("function f(x)
        x = x + 1
        x *= 3
        x -= 2
    end")
    JSON3.write(io, s)
end
ex = json2julia(file)
@test eval(ex)(1) == eval(expr)(1)

```

```@example 1    
expr = :(function f(x)
    x = x + 1
    x *= 3
    x -= 2
    begin
        @assert x isa Number
        return x
    end
end)
file = "s.json"
open(file, "w") do io
    s = julia2json(expr)
    JSON3.pretty(io, s)
end
ex = json2julia(file)
@test eval(ex)(1) == eval(expr)(1)
```
