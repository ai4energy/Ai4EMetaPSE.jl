for sym in [
    :LogLevel, :BelowMinLevel, :AboveMaxLevel,
    :AbstractLogger,
    :NullLogger,
    :handle_message, :shouldlog, :min_enabled_level, :catch_exceptions,
    Symbol("@debug"),
    Symbol("@info"),
    Symbol("@warn"),
    Symbol("@error"),
    Symbol("@logmsg"),
    :with_logger,
    :current_logger,
    :global_logger,
    :disable_logging,
    :SimpleLogger,
    :closed_stream]
    @eval const $sym = Base.CoreLogging.$sym
end

struct Ai4ESimulatorLogger <: AbstractLogger
    stream::IO
    min_level::LogLevel
    message_limits::Dict{Any,Int}
end
function Ai4ESimulatorLogger(stream::IO, min_level=LogLevel(-1))
    Ai4ESimulatorLogger(stream, min_level, Dict{Any,Int}())
end
function Ai4ESimulatorLogger(min_level=LogLevel(-1))
    Ai4ESimulatorLogger(closed_stream, min_level, Dict{Any,Int}())
end
function shouldlog(logger::Ai4ESimulatorLogger, level, _module, group, id)
    get(logger.message_limits, id, 1) > 0
end
min_enabled_level(logger::Ai4ESimulatorLogger) = logger.min_level

function handle_message(logger::Ai4ESimulatorLogger, level::LogLevel, message, _module, group, id,
    filepath, line; kwargs...)
    @nospecialize
    # println(haskey(kwargs, :status)?)
    status = get(kwargs,:status,"正在计算!")
    progress = get(kwargs,:progress,"none")
    progress == "done" && status =="正在计算!" ? progress = 1.0 : nothing
    println(status,progress)
    nothing
end
# using TerminalLoggers: TerminalLogger
global_logger(Ai4ESimulatorLogger())

@logmsg(LogLevel(-1),"ODESystem",_id=:OrdinaryDiffEq,status = "正在测试",progress=0.1)



a = """{
    "name": "Lithium battery",
    "pkgs": [
        "ModelingToolkit",
        "DifferentialEquations",
        "Ai4EComponentLib.Electrochemistry"
    ],
    "components": [
        {
            "name": "batter",
            "type": "Lithium_ion_batteries",
            "args": {}
        },
        {
            "name": "Pv",
            "type": "PhotovoltaicCell",
            "args": {}
        },
        {
            "name": "ground",
            "type": "Ground",
            "args": {}
        }
    ],
    "connections": [
        [
            "batter.p",
            "Pv.p"
        ],
        [
            "batter.n",
            "Pv.n",
            "ground.g"
        ]
    ],
    "u0": [
        "batter.v_f => 0.5",
        "batter.v_s => 0.5",
        "batter.v_soc => 0.5"
    ],
    "timespan": [
        0.0,
        36000.0,
        1.0
    ],
    "solver": "Rosenbrock23"
}"""

using Ai4EMetaPSE
using JSON
replace(JSON.parse(a)["name"], " " => "_")
s = Ai4EMetaPSE.getscript(generatecode(a, ModelJson()))
using ModelingToolkit,Ai4EComponentLib.Electrochemistry
import Ai4EComponentLib.t
eval(s)
typeof(s)
using ModelingToolkit