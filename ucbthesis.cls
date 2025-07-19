\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ucbthesis}[2019/07/19 v3.6 University of California, Berkeley Thesis Class]

\newcommand\@masters{}
\DeclareOption{phd}{\renewcommand\@masters{0}}
\ExecuteOptions{phd}

\PassOptionsToClass{oneside}{memoir}
\PassOptionsToClass{12pt}{memoir}

% Other options are passed on to the memoir class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax

% Now load the memoir class, and configure it appropriately.
\LoadClass{memoir}
\setstocksize{11in}{8.5in}
\settrimmedsize{11in}{8.5in}{*}
\nouppercaseheads

% Explicitly set the text width and margins
\setlrmargins{1.5in}{*}{*}
\@tempdima=1.5in  \advance\@tempdima 25pt \advance\@tempdima\normalbaselineskip
\@tempdimb=1.5in  \advance\@tempdimb 30pt
\setulmarginsandblock{\@tempdima}{\@tempdimb}{*}
\AtBeginDocument{\checkandfixthelayout}

\pagestyle{simple}
\aliaspagestyle{book}{simple}
\aliaspagestyle{part}{simple}
\aliaspagestyle{chapter}{simple}
\aliaspagestyle{title}{simple}

\newcommand\ssp{\SingleSpacing}
\newcommand\dsp{\setSpacing{1.37}}


\let\memoirtableofcontents=\tableofcontents
\let\memoirlistoffigures=\listoffigures
\let\memoirlistoftables=\listoftables

% acknowledge environment:
\newcommand\acknowledgename{Acknowledgments}

%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************
\def\degreeyear#1{\gdef\@degreeyear{#1}}

% The semester (Fall or Spring) the degree will be officially conferred
\def\degreesemester#1{\gdef\@degreesemester{#1}}
% Name of degree to be confered
\def\degree#1{\gdef\@degree{#1}}

% The name of your committee's chair
\def\chair#1{\gdef\@chair{#1}\gdef\@chairtitle{Chair}}
% The name of your committee's secondary chair (for chair + co-chair)
\def\cochair#1{\gdef\@cochair{#1}}
% The names of your committee's co-chairs (for two equal co-chairs)
\def\cochairs#1#2{\gdef\@chair{#1}\gdef\@cochair{#2}\gdef\@chairtitle{Co-chair}}

% The names of your other committee members, one per line
\def\othermembers#1{\gdef\@othermembers{#1}}
% The number of committee members
\def\@numberofmembers{3}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}}

% The name of your degree's field
\def\field#1{\gdef\@field{#1}}

% The name of your UC Campus (e.g. Berkeley, Los Angeles)
\def\@campus{Berkeley}

% The alwayssingle environment ensures that front matter is always
% single column even in a double-column document.
\newenvironment{alwayssingle}
  {\if@twocolumn\@restonecoltrue\onecolumn \else \@restonecolfalse\newpage \fi}
  {\if@restonecol \twocolumn \else \newpage \fi}

% Set the font that will be used in the front matter headings
\def\fmfont{\fontsize\@xiipt{14.5}\selectfont}
\def\fmsmallfont{\fontsize\@xiipt{14pt}\selectfont}

\def\maketitle{
{\ssp
  \makeatletter
    \setlength{\@tempdima}{28pt}\advance\@tempdima-\baselineskip
    \parskip=\@tempdima minus 4pt
  \makeatother
\begin{alwayssingle}
  \hrule height 0pt
    \@tempdima=\stockheight
    \advance\@tempdima-\textheight
    \advance\@tempdima-2\uppermargin
    \advance\@tempdima-\topskip
    \vspace{\@tempdima}
  \vfill
  \let\footnotesize\small
  \let\footnoterule\relax
  \thispagestyle{empty}
  \setcounter{page}{1}

  \begin{center}
    \fmfont
    \@title\par
    \vspace{14pt minus 4pt}
    by \par
    {\@author}\par
    \vspace{28pt minus 8pt}
    A dissertation submitted in partial satisfaction of the \par
    requirements for the degree of \par
      {\@degree}\par
    in \par
    {\@field}\par
    in the \par
    Graduate Division \par
    of the \par
    University of California, {\expandafter{\@campus}}\par
    \vspace{34pt minus 8pt}
    {
      \fmsmallfont
      Committee in charge: \par
      {\@chair}, \@chairtitle \\
      \ifdefined\@cochair
        {\@cochair}, Co-chair \\
      \fi
      {\@othermembers}\par
      \vspace{14pt minus 4pt}
      \@degreesemester \ \@degreeyear\par
    }
  \end{center}
  \vfill
  \hrule height 0pt
\end{alwayssingle}

\setcounter{footnote}{0}
}}

% APPROVALPAGE
%
% The \approvalpage macro emits a UC-approved approval page ready for
% your committee's signature.  It is not an automatic part of the
% output because it only needs to be printed out once (and should not
% be present in the electronically submitted part).  It requires that
% the \year, \author, \title, and \campus macros have been defined.

\def\approvalpage{%
    \begin{alwayssingle}
    \thispagestyle{empty}

    \fmfont \noindent
        The \@dissertation of {\@author}, titled {\@title}, is approved:
    
    \vfil{
        \baselineskip=36pt
        \settowidth\@tempdima{
            \ifdefined\@cochair Co-chair\else\@chairtitle\fi\quad
        }
        \hbox to\textwidth{
            \raise 3pt\hbox to\@tempdima{
                \@chairtitle\hfil
            }   
            %
            \leaders\hrule\hskip 0pt plus .75fill\qquad
            \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill
        }
        \hbox to\textwidth{
            \raise 3pt\hbox to\@tempdima{
                \ifdefined\@cochair Co-chair
                \fi
                \hfil
            }
            %
            \leaders\hrule\hskip 0pt plus .75fill\qquad
            \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill
        }
        \hbox to\textwidth{
            \hskip\@tempdima \leaders\hrule\hskip 0pt plus .75fill\qquad
            \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill
        }
        \ifnum \@numberofmembers > 3
        \hbox to\textwidth{
            \hskip\@tempdima \leaders\hrule\hskip 0pt plus .75fill\qquad
            \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill
        }
        \fi
        \ifnum \@numberofmembers > 4
        \hbox to\textwidth{\hskip\@tempdima \leaders\hrule\hskip 0pt plus .75fill\qquad
        \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill}
        \fi
    }
    \vfil
    \begin{center}
    {
        \fmfont University of California, {\@campus}
    }
    \end{center}
    \end{alwayssingle}
}

% COPYRIGHTPAGE
\def\copyrightpage{
    \begin{alwayssingle}
        \thispagestyle{empty}
        \begin{center}{
            \fmfont
            \@title\par
            \vspace{1in}
            Copyright \@degreeyear\par
            by\par
            \@author
        }
        \end{center}
    \end{alwayssingle}
}


% ABSTRACT
\renewenvironment{abstract}{
    \begin{alwayssingle}
    \thispagestyle{simple}
    \setlength{\parindent}{0pt}
    \setlength{\parskip}{\baselineskip}
    \setcounter{page}{1}
    \begin{center}
      \abstractname \par
      \@title\par
      by\par
      \@author\par
      {\@degree} in \@field\par
      University of California, {\@campus}\par
      {\@chair}, \@chairtitle \par
      \ifdefined\@cochair
        {\@cochair}, Co-chair\par
      \fi
    \end{center}
    \setlength{\parskip}{.6\baselineskip}
    \vspace{.4\baselineskip}
}{
    \par\end{alwayssingle}
}

% DEDICATION
\newenvironment{dedication}
  {\begin{alwayssingle}}
  {\end{alwayssingle}}

% ACKNOWLEDGEMENTS

\newenvironment{acknowledgements}{
    \begin{alwayssingle}
        \begin{center}{
            \large \bfseries \acknowledgename
        }
        \end{center}
    }{
    \end{alwayssingle}
}

% FRONTMATTER environment

\renewenvironment{frontmatter}
  {\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
  {\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}


% Rename environments to allow them to switch back to double spacing


\setlength{\cftchapternumwidth}{2em}
\setlength{\cftsectionnumwidth}{3em}
\setlength{\cftsubsectionnumwidth}{4em}
\setlength{\cftsubsubsectionnumwidth}{5em}
\setlength{\cftparagraphnumwidth}{5em}
\makeatletter
\renewcommand\paragraph{
  \@startsection{paragraph}{4}{\z@}
    {-3.25ex \@plus -1ex \@minus -.2ex}
    {0.0001pt \@plus .2ex}
    {\normalfont\normalsize\bfseries\@afterheading}
}
\renewcommand\subparagraph{
  \@startsection{subparagraph}{5}{\z@}
    {-3.25ex \@plus -1ex \@minus -.2ex}
    {0.0001pt \@plus .2ex}
    {\normalfont\normalsize\bfseries\@afterheading}
}
\makeatother
\usepackage{etoolbox}
\pretocmd{\section}{\clearpage}{}{}
\pretocmd{\chapter}{\cleardoublepage}{}{}
\endinput
