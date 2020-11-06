# lynx.jl
# make a nice ordered set of symlinks to the files we will knit together

@show VERSION

symlink_prefix = "⋮⋮sym."
path_chapters = "chapters"

# collect names of all .Rmd files, except `index.Rmd`
files = readdir(path_chapters) |> 
  f -> filter!(endswith(".Rmd"),f) |>
    f -> filter!(!startswith("index"),f)

# delete all files with `symlink_prefix`
rm.(readdir() |> f -> filter!(startswith(symlink_prefix),f), force=true)

# make new symlinks in root folder
for i in 1:length(files)
  symlink(joinpath(path_chapters,files[i]), symlink_prefix * string(i, pad=4) * "⋮⋮" * files[i])
end

println("All done")