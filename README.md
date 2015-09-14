# The MSP Poster Package

## Introduction

Based on an idea by Ingmar Steiner, this package is meant to make creating posters for presentations as simple as writing a basic article in LaTeX.
This means the user can focus mainly on the content and is not required to pay a lot of attention to mangling with the layout. 

The package uses [PGF and TikZ] to automatically generate the layout of the poster.

## License

The package is licensed under *The LaTeX Project Public License*.

See LICENSE.md and mspposter.sty for more details.

## Using the package

Copy the file 'mspposter.sty' to the same folder as your LaTeX file and add the line 

    \usepackage{mspposter}

to your preamble.

## Managing the content

Place the content of the poster inside the poster environment:

    \begin{poster}
        ...
    \end{poster}

Use 

    \begin{posterblock}
        CONTENT
    \end{posterblock}

to create a block on the poster with CONTENT.

The environment

    \begin{posterblockH}{H}
        CONTENT
    \end{posterblockH}

generates a block with fixed height H on the poster.

Use

    \begin{logobar}
        CONTENT
    \end{logobar}

to create a logo bar at the bottom of the poster with CONTENT.

The poster blocks themselves are arranged automatically on the poster depending on the chosen layout.
The default layout is using one block on each row. 

Currently, two layouts are available:

### The posterrows environment

Use the environment

    \begin{posterrows}[N]
      ...
    \end{posterrows}

to have N columns on each row.

In this layout, the poster blocks first fill the current row.
After it is filled, a new row is started automatically.

In this environment, two additional poster block environments are available:

    \begin{posterblockW}{W}{H}
      ...
    \end{posterblockW}

creates a block with width W and height H.

**Note: Columns created by this environment are not counted, which means that the row has to be ended with the following environment:**

    \begin{posterblockWFill}{H}
      ...
    \end{posterblockWFill}

creates a block with height H that uses the remaining space on the row as width.

### The postercolumns environment

The environment

    \begin{postercolumns}[N]
      ...
    \end{postercolumns}

also creates a layout with N columns on each row.
This time, however, the columns are filled first.

**Note: The column is not ended automatically.**

Use the command

    \posternextcolumn

to return to the first row of the current layout and move to the next column.

## Tweaking the layout

The command

    \setblockpadding{X}

sets the inner padding in each block to X.

Use

    \setblockspacing{Y}

to change the spacing between two blocks to Y.

Change the margins with

    \setmargins{SIDE}{TOP}

This sets the left and right margin to SIDE and the top margin to TOP.

**Important: All provided values have to be dimensionless - they are interpreted in terms of pt.**

The background can be changed with

    \shadebackground{bottomColor}{topColor}

This creates a color gradient from top to bottom with the chosen colors.
Both colors should be in a format that is accepted by TikZ.

To place content on the background, use

    \setbackground{CONTENT}

Finally, the posterblock, posterblockH, posterblockW, posterblockWFill, and logobar environments accept an optional argument that refers to a user-defined TikZ style for the block:

    \tikzset{%
      myblock/.style={
        draw,
        fill=blue
      },
      mylogobar/.style={
        draw,
        fill=white
      }
    }

    ...

    \begin{document}

    ...

    \begin{posterblock}[myblock]
        ...
    \end{posterblock}

    \begin{posterblockH}[myblock]{100}
        ...
    \end{posterblockH}

    ...

    \begin{logobar}[mylogobar]
       ...
    \end{logobar}

### Poster Themes

Instead of writing your layout tweaks directly into your main LaTeX code, you can also place them inside an external __theme file__.
To apply the theme to your poster, use the following command after you started the poster environment:

    \setpostertheme{T}

where T is the path to the file containing the layout tweaks. 

**The following file represents the default theme:**

    \tikzset{
      % default style for poster block
      posterblock/.style={
        opacity=0.5,
        text opacity=1.0,
        fill=white,
        draw,
        ultra thick,
        rounded corners
      }
      ,
      % default style for logo bar
      logobar/.style={
        align=center,
        % make the bar a little bit wider than the paper width,
        % such that the left and right borders are not visible
        minimum width=\paperwidth + 10pt,
        text width=\textwidth,
        fill=white,
        draw=black,
        ultra thick,
        decoration=random steps,
        decorate,
        inner sep=5
      }
    }

    \setmargins{20}{20}
    \setblockpadding{10}
    \setblockspacing{20}
    \shadebackground{red!30}{orange!40}

## Limitations

- Floating environments like *figure* and *table* are not supported inside a poster block.

- TikZ pictures inside a poster block inherit the chosen style for the block.
  This issue is related to TikZ, see for example [TeX Stackexchange]. 

  Workarounds:

  1. Like proposed on [TeX Stackexchange], typeset the TikZ picture in a *savebox* and use it later on.
  2. Create a PDF of the TikZ picture and use *\includegraphics* in the posterblock environment.
  3. Use the [Standalone package] for including the TikZ picture.



## Example

Example poster file:

    \documentclass[a4paper, 11pt]{article}
    \usepackage{mspposter}

    \usepackage[utf8]{inputenc}
    \usepackage[T1]{fontenc}
    \usepackage[compact, center]{titlesec}

    \usepackage{titlesec}
    \titleformat*{\section}{\large\bf\center}
    \titlespacing*{\section}{0pt}{0pt}{0.5\baselineskip}

    % reduce the vertical space generated by a section
    \let \oldsection \section
    \renewcommand{\section}{\vspace{-10pt}\oldsection}

    % create custom styles
    \tikzset{
      myblock/.style={
        ultra thick,
        decoration=random steps,
        decorate,
        draw,
        fill=white,
        opacity=0.5,
        text opacity=1.0
      },
      mylogobar/.style={
        minimum width=\paperwidth + 10pt,
        text width=\textwidth,
        fill=white,
        draw=black,
        ultra thick,
        decoration=random steps,
        decorate,
        inner sep=5
      }
    }

    \begin{document}

    \begin{poster}

    % tweak layout
    \setblockpadding{20}
    \setblockspacing{15}
    \setmargins{15}{15}
    \shadebackground{red!40}{blue!30}

    \begin{posterrows}[4]

      \begin{posterblock}[myblock]
        \centering
        I am a poster block with a fancy style!
      \end{posterblock}

      \begin{posterblock}[myblock]
        \centering
        I am a poster block with a fancy style!
      \end{posterblock}

      \begin{posterblock}[myblock]
        \centering
        I am a poster block with a fancy style!
      \end{posterblock}

      \begin{posterblock}[myblock]
        \centering
        I am a poster block with a fancy style!
      \end{posterblock}

    \end{posterrows}

    \begin{postercolumns}[2]

      \begin{posterblock}
        \begin{center}
        \begin{tikzpicture}
          \node [fill=red!70, circle, text width=20pt] {};
        \end{tikzpicture}
        \end{center}
      \end{posterblock}

      \begin{posterblock}
        \begin{center}
        \begin{tikzpicture}
          \node [fill=black!70, circle, text width=30pt] {};
        \end{tikzpicture}
        \end{center}
      \end{posterblock}

       \posternextcolumn

      \begin{posterblock}
        \begin{center}
        \begin{tikzpicture}
          \node [fill=blue!70, circle, text width=40pt] {};
        \end{tikzpicture}
        \end{center}
      \end{posterblock}

      \begin{posterblock}
        \begin{center}
        \begin{tikzpicture}
          \node [fill=orange!70, circle, text width=10pt] {};
        \end{tikzpicture}
        \end{center}
      \end{posterblock}

    \end{postercolumns}

    \begin{posterrows}[3]

      \begin{posterblockW}{150}{45}
        \section{Left Box}
        This poster block has a fixed height and width.
      \end{posterblockW}

      \begin{posterblockWFill}{25}
        \section{Right Box}
        Here, the poster block uses the remaining space that is available on the current row.
        Like the left block, it has a fixed height.
      \end{posterblockWFill}

      \begin{posterblock}
        {\bf posterblockWFill} automatically ends the row.
      \end{posterblock}

      \begin{posterblock}
        Blocks in this row are aligned to the largest block in the above row.
      \end{posterblock}

      \begin{posterblockH}{30}
        This poster block has a fixed height and uses the precomputed width.
      \end{posterblockH}

    \end{posterrows}

    \begin{postercolumns}[5]
      \begin{posterblock}
        \section{Left}
      \end{posterblock}
      \begin{posterblock}
        \section{Left}
      \end{posterblock}
      \begin{posterblock}
        \section{Left}
      \end{posterblock}

      \posternextcolumn
      \posternextcolumn

    \begin{posterblock}
        \section{Center}
      \end{posterblock}
      \begin{posterblock}
        \section{Center}
      \end{posterblock}
      \begin{posterblock}
        \section{Center}
      \end{posterblock}

      \posternextcolumn
      \posternextcolumn

    \begin{posterblock}
        \section{Right}
      \end{posterblock}
      \begin{posterblock}
        \section{Right}
      \end{posterblock}
      \begin{posterblock}
        \section{Right}
      \end{posterblock}

    \end{postercolumns}

    \begin{logobar}[mylogobar]
      \centering
      \fbox{\huge \bfseries LOGO 1}
      \hfill
      \fbox{\huge \bfseries LOGO 2}
      \hfill
      \fbox{\huge \bfseries LOGO 3}
      \hfill
      \fbox{\huge \bfseries LOGO 4}
    \end{logobar}

    \end{poster}

    \end{document}

Resulting poster:

![][Example]


[PGF and TikZ]: http://sourceforge.net/projects/pgf/ "PGF and TikZ"
[TeX Stackexchange]: http://tex.stackexchange.com/questions/23411/tikzpicture-in-node-of-another-tikzpicture-how-to-screen-of-from-inheriting-sty "TeX Stackexchange"
[Standalone package]: https://www.ctan.org/pkg/standalone  "Standalone package"
[Example]: poster.jpg
