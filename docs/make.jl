using Ai4EMetaPSE
using Documenter

DocMeta.setdocmeta!(Ai4EMetaPSE, :DocTestSetup, :(using Ai4EMetaPSE); recursive=true)

makedocs(;
    modules=[Ai4EMetaPSE],
    authors="jake484 <522432938@qq.com> and contributors",
    repo="https://github.com/jake484/Ai4EMetaPSE.jl/blob/{commit}{path}#{line}",
    sitename="Ai4EMetaPSE.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jake484.github.io/Ai4EMetaPSE.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jake484/Ai4EMetaPSE.jl",
    devbranch="main",
)
