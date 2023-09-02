# Markdown Demo

This section contains basic Markdown examples for faster reference.

## Simple math stuff

Simple math can be encapsulated in `$`:

- `$n = \sum_{d|n}\varphi(d)$` is rendered as $n = \sum_{d|n}\varphi(d)$

## Citations

Pandoc has a [citation extension](https://pandoc.org/MANUAL.html#citation-syntax), with `--biblatex` enabled citations are translated using BibTeX's `autocite` command:

- `[@serre1979]` general reference [@serre1979]
- `[@serre1979,p.20]` reference with a page [@serre1979,p.20]
- `[@serre1979;@lurie2009]` multi-reference [@serre1979;@lurie2009]

## Footnotes

- `^[just like this]`: inline footnote ^[just like this]

## Internal references

Markdown can do inter-document links but only to headings and only within the same file

- Use `[link text](#markdown-demo)` to a link a section: [link text](#markdown-demo).
    - The anchor has to be lower-kebab-case, irrespective of the case of the anchor name. Note that you have to choose a name and not get the section number, so this corresponds to `\nameref`.
    - It is possible to set a custom anchor name with `{#key}` behind a heading. This way it can be referenced with `[link text](#key)`.

## Mixing Markdown and LaTeX

Actually for pandoc it is (mostly) fine to mix markdown and LaTeX. So math stuff can be typeset with `equation` environments etc, for example:^[the equation also contains `\label{eq:euler}` to define an anchor point] 
\begin{equation}
e^{i\pi} + 1= 0 \label{eq:euler}
\end{equation}

This is not valid markdown, so it will land as it is in the pandoc's target - which is fine as long as we transform to LaTeX anyway. So basically it possible to write a wild mixture of Markdown and \LaTeX. 

This enables LaTeX labels and references - in particular for figures or equations. Just set the label via `\label{key}` and refer to it with `\ref{key}`, e.g.

-  `See equation (\ref{eq:euler})`: See equation (\ref{eq:euler})
