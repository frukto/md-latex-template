# LaTeX/Markdown Template

## From Markdown to LaTeX via pandoc

For simple texts it is much more convenient writing in Markdown than in LaTeX. However the latter produces more good-looking results. The idea is to use [pandoc](https://pandoc.org/) to get the best of both worlds.

Pandoc can convert Markdown directly to pdf by using LaTeX as intermediate format. But I prefer to let pandoc translate .md files to .tex and then use LuaLaTeX to compile the pdf in a second step.

By using simplified a simplified LaTeX template, the code looks quite OK and I can hack in additional stuff which would be not possible in Markdown alone. However, if things get fancy it makes sense to forget about Markdown and write the LaTeX directly.

## BibTeX Integration via zotero

It is pretty cool that pandoc can handle BibTeX which makes citation handling very easy. I use [zotero](https://www.zotero.org/) to manage bibliographies and with a suitable plugin it exports to BibTeX quite nicely.

For a time a used [zettlr](https://www.zettlr.com/) as a Markdown editor which has also some integration for pandoc and plays (to some extent) nicely with zotero. However recently I fell back to plain vim (nvim to be precise).

## Building with latexmk

It is still a painful to build LaTeX with its circular .aux dependencies. That is where [latexmk](https://www.ctan.org/pkg/latexmk/) comes into the mix. It provides a simple build system which handles most stuff automagically.

So my workflow looks something like this:

```
    (1) add stuff to zotero
        |
        \---(auto export)---> .bib -------------\
                                |               |
                                V               |
    (2) write stuff in MD ---(pandoc)---> .tex  |
                                A            |  |
                                |            V  V
    (3) run latexmk ------------+---------(lualatex)---> .pdf
```

All this is put in a git repository to have some version control at hand.

# How to use

## Copy the example folder

A complete example project is in the `example` folder. It is a good starting point. It contains already several folders. I use `main` for the Markdown content and `notes`, well, for my notes. I prefer to have a file named `notes/@key` for notes regarding the source with citation key `key`. This way I can keep my notes separated and organized.

There is a `latex` folder containing the LaTeX source and auxiliary files. After adjusting the template there is little to do in this folder.

Here is a complete overview:
```
    .\
     .latexmkrc             # latexmk configuration
     + latex
       + aux                # all the latex helper files
       + src                # actual latex source
         template.tex       # LaTeX template used by pandoc
         titlepage.tex      # custom title page
         bibliography.bib   # bibTeX file maintained by zotero
       + extra              # graphics and additional latex stuff
     + notes                # scratch space
     + main                 # actual content, written in Markdown
       05_intro.md          #   with number prefix to keep the ordering
       15_demo.md           #   simple
     main.pdf               # genrated pdf
```
## Install and configure zotero

This is completely optional. You can maintain `bibliography.bib` in any other way you like. However the name (and path) is hard-coded in `.latexmkrc` and in the custom template, if you change it, you have to adjust it there as well. 

- Install [zotero](https://www.zotero.org/)
- Install the [Better BibTex(BBT) extension for zotero](https://github.com/retorquere/zotero-better-bibtex)
    - Follow the [BBT installation instructions](https://retorque.re/zotero-better-bibtex/installation/), that is:
        - Download the [latest xpi](https://github.com/retorquere/zotero-better-bibtex/releases/)
        - In zotero click: Tools > Add-ons > Install Add-on from file
        - Choose the downloaded xpi
        - Restart zotero
- Configure BBT:
    - Rightclick on a collection, choose "Export collection"
        - Format: Better BibLaTeX
        - Keep updated: yes
        - Background export: yes
    - Navigate to your project folder and save as `latex/src/bibliography.bib`

Now zotero should keep `bibliography.bib` up-to-date as you add more and more references. BBT extension has a lot more settings, most of them seem to be good. I prefer to set the "citation key formula" to `auth.lower + year` to have kind of readable citation keys.

## Running latexmk

`latexmk` will read `.latexmkrc` to figure out what to do. The main purpose of this file is to get all the file locations right, call pandoc (with the correct parameters) and build the final pdf. These are the most common commands:

- `latexmk`: Build the main pdf
- `latexmk -C`: Big cleanup, remove all regeneratable files
- `latexmk -g`: Go mode, force rebuild, even if it looks unnecessary

Add `-silent` to make the output less verbose.

## Custom templates and title pages

Pandoc uses a template to generate main .tex file. The `latex_template` parameter controls which template to use. Either the custom template `latex/src/template.tex` or the default template (i.e. `latex_template=default.latex`).

The custom template is a simplified version of the default template and includes also a custom title page. The title page has it own .tex file. To build/update it, run

```
latexmk latex/src/titlepage_eth.tex  
```

## Setup git

Just create a new repository and add a remote if necessary:

- `git init`
- `git remote add origin https://github.com/frukto/md-latex-template.git`

There is already a `.gitignore` containing excluding auxiliary files and the main pdf. You also want to delete/adjust `main/*.md` or unused templates/title pages before the first commit:

- `rm -r main/*.md`
