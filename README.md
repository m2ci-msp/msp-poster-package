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

For three blocks:

    \begin{threecolumnlayout}
       ...
    \end{threecolumnlayout}

Use

    \begin{logobox}
        CONTENT
    \end{logobox}

to create a logo bar at the bottom of the poster with CONTENT.

## Tweaking the layout

The command

    \setblockpadding{X}

sets the inner padding in each block to X.

Use

    \setblockspacing{Y}

to change the spacing between two blocks to Y.

Change the margin to the top boundary of the page with

    \settopmargin(Z)

to Z.

**Important: All provided values have to be dimensionless - they are interpreted in terms of pt.**

The background can be changed with

    \shadebackground{bottomColor}{topColor}

This creates a color gradient from top to bottom with the chosen colors.
Both colors should be in a format that is accepted by TikZ.

To place content on the background, use

    \setbackground{CONTENT}

Finally, the posterblock and logobox environments accept an optional argument that refers to a user-defined TikZ style for the block:

    \tikzset{%
      myblock/.style={
        draw,
        fill=blue
      },
      mylogobox/.style={
        draw,
        anchor=south,
        fill=white
      }
    }

    ...

    \begin{document}

    ...

    \begin{posterblock}[myblock]
        ...
    \end{posterblock}

    ...

    \begin{logobox}[mylogobox]
       ...
    \end{logobox}

**Important: Use anchor=south in your style for the logobox environment.**

## Example

Example poster file that uses additional packages:

Resulting poster:

    \documentclass[a4paper, 11pt]{article}
    \usepackage{mspposter}
    \usepackage{multicol}

    \usepackage{lipsum}
    \usepackage{calc}
    \usepackage{microtype}
    \usepackage[utf8]{inputenc}
    \usepackage[T1]{fontenc}
    \usepackage{setspace}
    \usepackage{calc}
    \usepackage[compact, center]{titlesec}
    \usepackage[hidelinks]{hyperref}
    \usepackage{titling}
    \setlength{\droptitle}{-50pt}
    \pretitle{\begin{center}\bf\Large}
    \posttitle{\end{center}}
    \predate{\vspace{-5mm}\begin{center}}
    \postdate{\end{center}\vspace{-30pt}}

    \usepackage{titlesec}
    \titlelabel{\thetitle.\quad}
    \titleformat*{\section}{\large\bf\center}
    \titlespacing*{\section}{0pt}{0pt}{0.5\baselineskip}

    \let \oldsection \section
    \renewcommand{\section}{\vspace{-15pt}\oldsection}

    \title{A title for a poster}
    \usepackage{authblk}
    \renewcommand\Authfont{\itshape}
    \renewcommand\Authands{\Authsep}
    \renewcommand\Affilfont{\itshape\small}
    \author[1--4]{Foo Bar}
    \author[1--3]{Bar Baz}
    \author[1]{Baz Foo}
    \affil[1]{Foo Department at Baz University, Random Country}
    \affil[2]{Bar Department at Foo University, Different Country}
    \affil[3]{Baz Institute, Random Place}
    \affil[4]{FooBar Research Lab, Other Place}
    \date{}

    % create custom styles
    \tikzset{
      mytitle/.style={
        white!20,
        opacity=1.0,
        fill=blue!70,
        anchor=north,
        draw=black,
        dashed,
        ultra thick,
        rounded corners
      },
      mylogobox/.style={
        minimum width=\paperwidth + 10pt,
        text width=\textwidth,
        fill=white,
        draw=black,
        ultra thick,
        decoration=random steps,
        decorate,
        anchor=south,
        inner sep=10
      }
    }

    \begin{document}

    % tweak layout
    \settopmargin{10}
    \setblockpadding{20}
    \setblockspacing{10}
    \shadebackground{red!40}{blue!30}

    \begin{posterblock}[mytitle]
    \maketitle
    \thispagestyle{empty}
    \end{posterblock}

    \begin{twocolumnlayout}

      \begin{posterblock}
        \section*{Left Box}
        \lipsum[4]
      \end{posterblock}

      \begin{posterblock}
        \section*{Right Box}
        \lipsum[2]
      \end{posterblock}

    \end{twocolumnlayout}

    \begin{threecolumnlayout}
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

      \begin{posterblock}
        \begin{center}
        \begin{tikzpicture}
          \node [fill=blue!70, circle, text width=40pt] {};
        \end{tikzpicture}
        \end{center}
      \end{posterblock}

    \end{threecolumnlayout}

    \begin{twocolumnlayout}
      \begin{posterblock}
        \section*{Left Box}
        \lipsum[6]
      \end{posterblock}

      \begin{posterblock}
        \section*{Right Box}
        \lipsum[10]
      \end{posterblock}
    \end{twocolumnlayout}

    \begin{logobox}[mylogobox]
      \centering
      \fbox{\huge \bfseries LOGO 1}
      \hfill
      \fbox{\huge \bfseries LOGO 2}
      \hfill
      \fbox{\huge \bfseries LOGO 3}
      \hfill
      \fbox{\huge \bfseries LOGO 4}
    \end{logobox}

    \end{document}

Resulting poster:

![][Example]


[PGF and TikZ]: http://sourceforge.net/projects/pgf/ "PGF and TikZ"
[Example]: poster.jpg
