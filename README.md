# The MSP poster package

## Introduction

Based on an idea by Ingmar Steiner, this package is meant to make creating posters for presentations as simple as writing a basic article in LaTeX.
This means the user can focus mainly on the content and is not required to pay a lot of attention to mangling with the layout.

The package uses [PGF and TikZ] to automatically generate the layout of the poster.

## License

The package is licensed under *The LaTeX Project Public License*.

See [LICENSE.md] and [mspposter.sty] for more details.

## Using the package

Copy the file 'mspposter.sty' and the directory 'themes' to the same folder as your LaTeX file and add the line

```latex
\usepackage{mspposter}
```

to your preamble.

## Managing the content

Place the content of the poster inside the poster environment:

```latex
\begin{poster}
...
\end{poster}
```

Use

```latex
\begin{posterblock}
    CONTENT
\end{posterblock}
```

to create a block on the poster with CONTENT.

The environment

```latex
\begin{posterblockH}{H}
    CONTENT
\end{posterblockH}
```

generates a block with fixed height H on the poster.

Use

```latex
\begin{logobar}
    CONTENT
\end{logobar}
```

to create a logo bar at the bottom of the poster with CONTENT.

The poster blocks themselves are arranged automatically on the poster depending on the chosen layout.
The default layout is using one block on each row.

Currently, two layouts are available:

### The posterrows environment

Use the environment

```latex
\begin{posterrows}[N]
  ...
\end{posterrows}
```
to have N columns on each row.

In this layout, the poster blocks first fill the current row.
After it is filled, a new row is started automatically.

In this environment, two additional poster block environments are available:

```latex
\begin{posterblockW}{W}{H}
  ...
\end{posterblockW}
```

creates a block with width W and height H.

**Note: Columns created by this environment are not counted, which means that the row has to be ended with the following environment:**

```latex
\begin{posterblockWFill}{H}
  ...
\end{posterblockWFill}
```

creates a block with height H that uses the remaining space on the row as width.

### The postercolumns environment

The environment

```latex
\begin{postercolumns}[N]
  ...
\end{postercolumns}
```

also creates a layout with N columns on each row.
This time, however, the columns are filled first.

**Note: The column is not ended automatically.**

Use the command

```latex
\posternextcolumn
```

to return to the first row of the current layout and move to the next column.

## Tweaking the layout

The command

```latex
\setblockpadding{X}
```
sets the inner padding in each block to X.

Use

```latex
\setblockspacing{Y}
```
to change the spacing between two blocks to Y.
The horizontal and vertical spacings can be set individually by using the command

```latex
\setblockspacings{HORIZONTAL}{VERTICAL}
```
Change the margins with

```latex
\setmargins{SIDE}{TOP}
```
This sets the left and right margin to SIDE and the top margin to TOP.

**Important: All provided values have to be dimensionless - they are interpreted in terms of pt.**

The background can be changed with

```latex
\shadebackground{bottomColor}{topColor}
```
This creates a color gradient from top to bottom with the chosen colors.
Both colors should be in a format that is accepted by TikZ.

To place content on the background, use

```latex
\setbackground{CONTENT}
```

Finally, the posterblock, posterblockH, posterblockW, posterblockWFill, and logobar environments accept an optional argument that refers to a user-defined TikZ style for the block:

```latex
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
```

### Poster themes

Instead of adding your layout tweaks to your poster code, you can also place them inside an external __theme file__.
To apply the theme to your poster, use the optional parameter of the **poster** environment:

```latex
\begin{poster}[T]
```

where T is the path to the file containing the layout tweaks.

Example file that represents the default theme applied when using [themes/default]:

```latex
\tikzset{
  title/.style={
    opacity=0.7,
    text opacity=1.0,
    fill=white,
    thin,
    rounded corners,
    draw
  },
  posterblock/.style={
    opacity=0.7,
    text opacity=1.0,
    fill=white,
    thin,
    rounded corners,
    draw
  },
  logobar/.style={
    minimum width=\paperwidth + 10pt,
    text width=\textwidth,
    draw,
    thin,
    fill=white,
    inner sep=5
  }
}

% tweak layout
\setmargins{15}{15}
\setblockpadding{20}
\setblockspacing{15}
\shadebackground{red!30}{orange!30}

\makeatletter
\renewcommand{\maketitle}{
    \begin{posterblock}[title]
        \begin{center}
            {\huge{\bf{\@title}}} \\
            \vspace{5pt}
            {\large\@author}
        \end{center}
    \end{posterblock}
}
\makeatother
```

## Poster block IDs

Each poster block is internally a TikZ node and can be accessed by using a unique ID that depends on the order of the blocks:
The ID for the first block is 1, for the second block, we have ID 2 and so on.

## Shifted poster

Use the environment

```latex
\begin{shiftedposter}[T, RIGHT, DOWN]
```

to create a shifted version of the poster with optional theme parameter *T*.
*RIGHT* is the right shift and *DOWN* the down shift of the result.
This enivronment might be helpful if you are using the poster package to design a title page for your document.

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

```latex
\documentclass[a4paper, 11pt]{article}

\usepackage{mspposter}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}

\usepackage{caption}
\usepackage{tabularx}
\usepackage{multicol}

\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}

\title{Example poster for the msp poster package}
\author{
  Alexander Hewer\textsuperscript{1-2},
  Ingmar Steiner\textsuperscript{1-3},
  Sébastien Le Maguer\textsuperscript{1,3}\\
  \vspace{12pt}
  {%
    \def\arraystretch{1.5}
    \begin{tabular}{C{0.35\textwidth} C{0.35\textwidth}}
      \textsuperscript{1}\textit{Cluster of Excellence MMCI, Saarland University} &
      \textsuperscript{2}\textit{DFKI Language Technology Lab, Saarbr\"{u}cken} \\
      \multicolumn{2}{c}{\textsuperscript{3}%
        \textit{Computational Linguistics \& Phonetics, Saarland University}} \\
    \end{tabular}
  }
}

\begin{document}

\begin{poster}[themes/tholey]

  \maketitle

  \begin{postercolumns}[2]

    \begin{posterblock}
      \begin{center}
        \begin{tikzpicture}
          \node [fill=red!70, circle, text width=20pt] {};
        \end{tikzpicture}
        \captionof{figure}{A red circle.}
      \end{center}
    \end{posterblock}

    \begin{posterblock}
      \begin{center}
        \begin{tikzpicture}
          \node [fill=black!70, circle, text width=30pt] {};
        \end{tikzpicture}
        \captionof{figure}{A black circle.}
      \end{center}
    \end{posterblock}

    \posternextcolumn

    \begin{posterblock}
      \begin{center}
        \begin{tikzpicture}
          \node [fill=blue!70, circle, text width=40pt] {};
        \end{tikzpicture}
        \captionof{figure}{A blue circle.}
      \end{center}
    \end{posterblock}

    \begin{posterblock}
      \begin{center}
        \begin{tikzpicture}
          \node [fill=orange!70, circle, text width=10pt] {};
        \end{tikzpicture}
        \captionof{figure}{An orange circle.}
      \end{center}
    \end{posterblock}

  \end{postercolumns}

  \begin{posterrows}[3]

    \begin{posterblockW}{150}{45}
      \section{Left Box}
      This poster block has a fixed height and width.
    \end{posterblockW}

    \begin{posterblockWFill}{45}
      \section{Right Box}
      Here, the poster block uses the remaining space that is available on the current row.
      Like the left block, it has a fixed height.
    \end{posterblockWFill}

    \begin{posterblock}
      {\bf posterblockWFill} ends the row automatically.
    \end{posterblock}

    \begin{posterblock}
      Blocks in this row are aligned to the largest block in the above row.
    \end{posterblock}

    \begin{posterblockH}{30}
      This poster block has a fixed height and uses the precomputed width.
    \end{posterblockH}

  \end{posterrows}

  \begin{postercolumns}[3]
    \begin{posterblock}
      \section{Left column}
    \end{posterblock}
    \begin{posterblock}
      \section{Left column}
    \end{posterblock}

    \posternextcolumn
    \posternextcolumn

    \begin{posterblock}
      \section{Right column}
    \end{posterblock}
    \begin{posterblock}
      \section{Right column}
    \end{posterblock}

  \end{postercolumns}

  \begin{logobar}[logobar]
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
```

Resulting poster:

![][Example]


[PGF and TikZ]: http://sourceforge.net/projects/pgf/ "PGF and TikZ"
[TeX Stackexchange]: http://tex.stackexchange.com/questions/23411/tikzpicture-in-node-of-another-tikzpicture-how-to-screen-of-from-inheriting-sty "TeX Stackexchange"
[Standalone package]: https://www.ctan.org/pkg/standalone  "Standalone package"
[Example]: poster.jpg
[LICENSE.md]: LICENSE.md
[mspposter.sty]: mspposter.sty
