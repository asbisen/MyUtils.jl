using PlotlyJS


"""
`boxplot( val::Vector, cat::Vector; ...)`

Description
===========

Generates a boxplot using numeric data provided by an Array
`val` and categorical (numeric or string) data provided by
`cat`


Arguments
=========

- **`boxpoints`** : ["outliers"], "all", "suspectedoutliers"
- **`boxmean`** : ["True"], "sd", "False"
- **`hovermode`** : ["closest"], "x", "y", "False"
- **`jitter`** : [0.3] Between 0-1
- **`pointpos`** : Numeric
- **`orientation`** : ["v"], "h"
- **`maxcategories`** : threshold to ensure the cardinality of categories isn't too high


"""
function boxplot{N<:Number}( val::Vector{N};
                             cat::Vector=[],
                             title="", height=600, width=600,
                             xaxis_title="", yaxis_title="",
                             boxpoints="outliers", boxmean="True",
                             hovermode="closest", jitter=0.3, pointpos=0,
                             orientation="v", maxcategories=16)


    # If cat is not specified then create one
    if cat == []
        cat = ["0" for i in 1:length(val)]
    end

    # Ensure that cat and val are of equal length
    @assert length(cat) == length(val) "cat and val should be equal in length"

    # Check for too many categories; more than 16 are too many
    @assert length(unique(cat)) <= maxcategories "Too many categories, try a different plot"

    # Check if x is a subtype of Number
    @assert eltype(val) <: Number "x should be of Numeric Type"


    data = Array{PlotlyJS.GenericTrace{Dict{Symbol,Any}},1}([])

    # TODO: Mechanism to specify the order of boxes
    #       For now just sort the categories to have an order
    boxids = sort(unique(cat))



    for id in boxids
        sub = val[cat .== id]
        name=string(id)

        # TODO: A clean method to handle horizontal / vertical box plots
        #       by replacing "y=sub" with "x=sub" will result in a horizontal plot

        if orientation=="h"
            trace = box(;x=sub, name=name, boxpoints=boxpoints,
                        jitter=jitter, pointpos=pointpos,
                        boxmean=boxmean)
        elseif orientation=="v"
            trace = box(;y=sub, name=name, boxpoints=boxpoints,
                        jitter=jitter, pointpos=pointpos,
                        boxmean=boxmean)
        end

        push!(data, trace)
    end


    layout = Layout(;title=title,
                    xaxis_title=xaxis_title, yaxis_title=yaxis_title,
                    width=width, height=height, hovermode=hovermode)

    p = Plot(data, layout)

end
