$latex_dir="latex";
$latex_output="$latex_dir/src/main.tex";          # pandoc: output file
$latex_template="$latex_dir/src/template.tex";    # pandoc: use custom template
#$latex_template="default.latex";                 # pandoc: use default template
$bibliography="$latex_dir/src/bibliography.bib";  # pandoc/biber: bibliography file
$metadata="$latex_dir/src/metadata.yaml";         # pandoc: metadata (needs to be explicitly used in template)
$content="main/*.md";                             # pandoc: input files

# TODO: make some noise if pandoc fails
system("pandoc --from markdown --to latex $content --output $latex_output --template $latex_template --bibliography $bibliography --biblatex --metadata-file=$metadata --standalone");
$pdf_mode = 4;                          # LuaLaTex -> pdf
@default_files = ("$latex_output");     # which file to compile
$out_dir = "$latex_dir";                # where to put the final document
$aux_dir = "$latex_dir/aux";            # where to put all the aux files
$preview_mode = 1;                      # start previewer
$pdf_previewer = "start evince";        # use (detached) evince as previewer
$pdf_update_method = 0;                 # update open viewer after recompilation
