\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ucbthesis}[2025/01/01 UC Berkeley PhD Thesis Class]

% ============================================================================
% CLASS OPTIONS AND BASE CLASS
% ============================================================================
% Load memoir with your preferred options

% Spacing options
\DeclareOption{singlespace}{\def\@ucbspacingcmd{\ssp}}
\DeclareOption{onehalfspace}{\def\@ucbspacingcmd{\hsp}}
\DeclareOption{doublespace}{\def\@ucbspacingcmd{\dsp}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
% Default spacing
\ExecuteOptions{doublespace}

% Process options
\ProcessOptions\relax
\LoadClass[oneside,12pt]{memoir}
% ============================================================================
% REQUIRED PACKAGES
% ============================================================================
\RequirePackage[T1]{fontenc}
\RequirePackage{microtype}
\RequirePackage{amsthm}
\RequirePackage{mdframed}  % For framed theorem environments

% ============================================================================
% PAGE GEOMETRY
% ============================================================================
\setstocksize{11in}{8.5in}
\settrimmedsize{11in}{8.5in}{*}
\nouppercaseheads

% Set text width to 33em and center it
\settypeblocksize{*}{33em}{*}
\setlrmargins{*}{*}{1}  % Equal left and right margins
\setulmargins{*}{*}{1}  % Equal top and bottom margins
\checkandfixthelayout

% ============================================================================
% DOCUMENT FORMATTING
% ============================================================================
\pagestyle{simple}
\aliaspagestyle{chapter}{simple}
\aliaspagestyle{title}{simple}

% Paragraph indentation
\setlength{\parindent}{1em}
\RequirePackage{indentfirst}

% Prevent widows and orphans
\widowpenalty=10000
\clubpenalty=10000

% Float placement
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.85}

% Caption formatting
\addtolength{\abovecaptionskip}{\baselineskip}

% ============================================================================
% SPACING COMMANDS
% ============================================================================
\newcommand\ssp{\SingleSpacing}
\newcommand\hsp{\OnehalfSpacing}
\newcommand\dsp{\DoubleSpacing}

% Default to double spacing for the body
\AtBeginDocument{\dsp}

% ============================================================================
% SECTION NUMBERING
% ============================================================================
\setsecnumdepth{subparagraph}
\maxtocdepth{section}

% Custom numbering scheme
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\thechapter.\Alph{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\roman{subsubsection}}
\renewcommand{\theparagraph}{\thesubsubsection.\alph{paragraph}}
\renewcommand{\thesubparagraph}{\theparagraph.\oldstylenums{\arabic{subparagraph}}}

% Clear page before chapters and sections
\pretocmd{\chapter}{\clearpage}{}{}
\pretocmd{\section}{\clearpage}{}{}

% ============================================================================
% TABLE OF CONTENTS FORMATTING
% ============================================================================
\setlength{\cftchapternumwidth}{2.5em}
\setlength{\cftsectionnumwidth}{3em}
\setlength{\cftsubsectionnumwidth}{4em}
\setlength{\cftsubsubsectionnumwidth}{5em}
\setlength{\cftparagraphnumwidth}{6em}
\setlength{\cftsubparagraphnumwidth}{7em}

% Add paragraph and subparagraph to TOC
\cftsetindents{paragraph}{5em}{6em}
\cftsetindents{subparagraph}{6em}{7em}

\RequirePackage{etoc}

% % optional: kill the "Contents" title on the local ToCs
% \renewcommand{\localtableofcontentsname}{}
% \etocsettocstyle{}{} % also remove the default heading/space

% mini-ToC after every chapter, down to subparagraph
% \AddToHook{cmd/chapter/after}{%
%   \etocsetnexttocdepth{subparagraph}%
%   \localtableofcontents
% }
% ============================================================================
% PARAGRAPH AND SUBPARAGRAPH AS DISPLAY HEADINGS
% ============================================================================
\renewcommand\paragraph{%
  \@startsection{paragraph}{4}{\z@}%
    {-3.25ex \@plus -1ex \@minus -.2ex}%
    {0.0001pt \@plus .2ex}%
    {\normalfont\normalsize\bfseries}%
}
\renewcommand\subparagraph{%
  \@startsection{subparagraph}{5}{\z@}%
    {-3.25ex \@plus -1ex \@minus -.2ex}%
    {0.0001pt \@plus .2ex}%
    {\normalfont\normalsize\bfseries}%
}

% ============================================================================
% LIST OF FIGURES AND LIST OF TABLES FORMATTING
% ============================================================================
% Set number width for figures and tables (format: chapter.number)
\setlength{\cftfigurenumwidth}{3em}  % Space for figure numbers like "III.12"
\setlength{\cfttablenumwidth}{3em}   % Space for table numbers like "III.12"

\setlength{\cftfigureindent}{0em}    % Indent before figure entries
\setlength{\cfttableindent}{0em}     % Indent before table entries

\renewcommand{\cftfigureleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cfttableleader}{\cftdotfill{\cftdotsep}}

% ============================================================================
% THEOREM ENVIRONMENTS
% ============================================================================
% Define theorem style with horizontal lines
\mdfdefinestyle{theoremstyle}{%
    topline=true,
    bottomline=true,
    leftline=false,
    rightline=false,
    linewidth=0.5pt,
    innertopmargin=0.5\baselineskip,
    innerbottommargin=0.5\baselineskip,
    innerleftmargin=0pt,
    innerrightmargin=0pt
}

% Main results with rules
\theoremstyle{definition}
\newmdtheoremenv[style=theoremstyle]{theorem}{Theorem}[chapter]
\newmdtheoremenv[style=theoremstyle]{corollary}[theorem]{Corollary}

% Regular theorem environments without rules
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem*{note}{Note}

% ============================================================================
% FRONT MATTER VARIABLES
% ============================================================================
% Initialize variables with defaults
\def\@title{Thesis Title}
\def\@author{Author Name}
\def\@degreeyear{2025}
\def\@degreesemester{Spring}
\def\@degree{Doctor of Philosophy}
\def\@chair{Chair Name}
\def\@chairtitle{Chair}
\def\@othermembers{}
\def\@field{Field Name}
\def\@campus{Berkeley}

% User commands to set variables
\def\degreeyear#1{\gdef\@degreeyear{#1}}
\def\degreesemester#1{\gdef\@degreesemester{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\chair#1{\gdef\@chair{#1}\gdef\@chairtitle{Chair}}
\def\cochair#1{\gdef\@cochair{#1}}
\def\cochairs#1#2{\gdef\@chair{#1}\gdef\@cochair{#2}\gdef\@chairtitle{Co-chair}}
\def\othermembers#1{\gdef\@othermembers{#1}}
\def\@numberofmembers{3}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}}
\def\field#1{\gdef\@field{#1}}

% Environment for single-column pages
\newenvironment{alwayssingle}{%
  \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\newpage\fi
}{%
  \if@restonecol\twocolumn\else\newpage\fi
}

% Font commands
\def\fmfont{\fontsize{12pt}{14.5pt}\selectfont}
\def\fmsmallfont{\fontsize{12pt}{14pt}\selectfont}

% ============================================================================
% TITLE PAGE
% ============================================================================
\renewcommand{\maketitle}{%
  \ssp
  \begin{alwayssingle}
    \thispagestyle{empty}
    \setcounter{page}{1}
    
    % Calculate vertical spacing
    \newdimen\@tempdima
    \@tempdima=28pt
    \advance\@tempdima-\baselineskip
    \parskip=\@tempdima minus 4pt
    
    % Add vertical space
    \vspace*{\fill}
    
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
      University of California, \@campus\par
      \vspace{34pt minus 8pt}
      {%
        \fmsmallfont
        Committee in charge: \par
        \@chair, \@chairtitle \\
        \ifdefined\@cochair
          \@cochair, Co-chair \\
        \fi
        \@othermembers\par
        \vspace{14pt minus 4pt}
        \@degreesemester\ \@degreeyear\par
      }
    \end{center}
    
    \vfill
  \end{alwayssingle}
  \setcounter{footnote}{0}
}

% ============================================================================
% COPYRIGHT PAGE
% ============================================================================
\def\copyrightpage{%
  \begin{alwayssingle}
    \thispagestyle{empty}
    \vspace*{\fill}
    \begin{center}
      \fmfont
      \@title\par
      \vspace{1in}
      Copyright \@degreeyear\par
      by\par
      \@author
    \end{center}
    \vfill
  \end{alwayssingle}
}

% ============================================================================
% ABSTRACT
% ============================================================================
\renewenvironment{abstract}{%
    \thispagestyle{simple}
    \setlength{\parindent}{0pt}
    \setlength{\parskip}{\baselineskip}
    \setcounter{page}{1}
    \begin{center}
      \textbf{Abstract}\par
      \@title\par
      by\par
      \@author\par
      \@degree\ in \@field\par
      University of California, \@campus\par
      \@chair, \@chairtitle\par
      \ifdefined\@cochair
        \@cochair, Co-chair\par
      \fi
    \end{center}
    \setlength{\parskip}{.6\baselineskip}
    \vspace{.4\baselineskip}
}{%
}

% ============================================================================
% DEDICATION
% ============================================================================
\newenvironment{dedication}{%
    \vspace*{\fill}
    \begin{center}
}{%
    \end{center}
    \vfill
}

% ============================================================================
% ACKNOWLEDGEMENTS
% ============================================================================
\newcommand\acknowledgename{Acknowledgments}
\newenvironment{acknowledgements}{%
    \begin{center}
      \large\bfseries\acknowledgename
    \end{center}
    \vspace{\baselineskip}
}{%
}

% ============================================================================
% FRONTMATTER environment
% ============================================================================
\renewenvironment{frontmatter}{%
  \setcounter{page}{1}
  \renewcommand{\thepage}{\roman{page}}
}{%
  \cleardoublepage
  \renewcommand{\thepage}{\arabic{page}}
  \setcounter{page}{1}
}
\preto\mainmatter{\@ucbspacingcmd}
\endinput