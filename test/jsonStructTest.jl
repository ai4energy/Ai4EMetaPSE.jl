file = joinpath(@__DIR__, "JsonFiles/CommoTemplate.json")
@test typeof(readjson(file)) <: CommonTemplate