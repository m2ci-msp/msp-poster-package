\ProvidesClass{poster}

% use the standard article as base class
\LoadClass[a4paper, 11pt]{article}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{setspace}
\usepackage{microtype}
\usepackage{calc}

\usepackage{ifthen}
\usepackage{tikz}

\usetikzlibrary{
  backgrounds,
  shadings,
  positioning,
  decorations.fractals,
  decorations.shapes,
  decorations.text,
  decorations.pathmorphing,
  decorations.pathreplacing,
  decorations.footprints,
  decorations.markings
}



% counter for poster row
\newcounter{PosterRow}
\newcounter{OldRow}

\newcounter{PosterColumn}

\newboolean{sectionopen}
\setboolean{sectionopen}{false}


% create tikzpicture
\AtBeginDocument {%
  \textwidth0.9\paperwidth
  \parindent0pt
  \null
  \thispagestyle{empty}
  % offset a little bit
  \vskip2cm
  \vfill
  \hfil
  \begin{tikzpicture}[overlay,
  box/.style={
    minimum width=\textwidth,
    text width=\textwidth-10pt,
    fill=white, anchor=north,
    inner sep=10,
    draw,
    very thick,
    rounded corners}
  ]
  \coordinate (center) at (0, 0);
  \coordinate (left) at (-.5\paperwidth,0);
  \coordinate (right) at (.5\paperwidth,0);
  \coordinate (startpos) at (0,.5\paperheight);

  \coordinate (bottom) at (0,-.6\paperheight);
  \coordinate (upper) at (0,.57\paperheight);

  \shade [bottom color=red!30,top color=orange!40]
  (upper -|  left) rectangle (bottom -| right);
}

\AtEndDocument {%
  % close open section
  \ifthenelse{\boolean{sectionopen}}{\egroup;}{}
\end{tikzpicture}
\vfill
\vbox{}
\clearpage
} 

\renewcommand\section[1]{%

  % save old row
  \setcounter{OldRow}{\thePosterRow}
  \stepcounter{PosterRow}

  \ifthenelse{\boolean{sectionopen}}
    {
    % close previous section if it was open
    \egroup;
    % create node beneath previous node
    \node [below= of \theOldRow.south, box] (\thePosterRow)
    % set marker for cell
    \bgroup
    }
    {
      % generate the first section
      \node at (startpos) [box] (\thePosterRow)
      \bgroup
    }

    % center title
    % move a little to the top
    \vspace{-1em}
    \begin{center}
    \Large\bfseries #1
    \end{center}

    % set flag that section is open
    \setboolean{sectionopen}{true}

    % remaining section is placed inside the node
}

