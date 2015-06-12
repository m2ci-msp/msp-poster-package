# The MSP Poster Package

## Introduction

Based on an idea by Ingmar Steiner, this package is meant to make creating posters for presentations as simple as writing a basic article in LaTeX.
This means the user can focus mainly on the content and is not required to pay a lot of attention to mangling with the layout. 

The package uses [PGF and TikZ] to automatically generate the layout of the poster.

## License

The package is licensed under the *The LaTeX Project Public License*.

See LICENSE.md and mspposter.sty for more details.

## Using the package

Copy the file 'mspposter.sty' to the same folder as your LaTeX file and add the line 

    \usepackage{mspposter}

to your preamble.

## Managing the content

Use 

    \begin{posterblock}
        CONTENT
    \end{posterblock}

to create a block on the poster with CONTENT.
The blocks themselves are arranged automatically on the poster depending on the chosen layout.
The default layout is using one block on each row. 

To have two blocks on each row, use the environment

    \begin{twocolumnlayout}
       ...
    \end{twocolumnlayout}

## Tweaking the layout

The command

    \setblockpadding{X}

sets the inner padding in each block to X.

Use

    \setblockspacing{Y}

to change the spacing between two blocks to Y.

The background can be changed with

    \shadebackground{bottomColor}{topColor}

This creates a color gradient from top to bottom with the chosen colors.
Both colors should be in a format that is accepted by TikZ.

Finally, the posterblock accepts an optional argument that refers to a user-defined TikZ style for the block:

    \tikzset{%
      example/.style={
        draw,
        fill=blue
      }
    }

    ...

    \begin{document}

    ...

    \begin{posterblock}[example]
      ...
    \end{posterblock}


[PGF and TikZ]: http://sourceforge.net/projects/pgf/ "PGF and TikZ"
