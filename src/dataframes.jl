using DataFrames

"""
List all columns that only consists of `NA`

    all_nacols(df::AbstractDataFrames)

"""
function all_nacols(df::AbstractDataFrame)
    nacols = Array{Symbol}([])
    for n in names(df)
        allna(df[n]) && push!(nacols, n)
    end
    nacols
end


"""
Drop all columns that only consists of `NA`

    drop_all_nacols!(df::AbstracDataFrame)

"""
function drop_all_nacols!(df::AbstractDataFrame)
    nacols = all_nacols(df)
    df = delete!(df, nacols)
    df
end
