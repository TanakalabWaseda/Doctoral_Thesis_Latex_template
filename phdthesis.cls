%%
%% phdthesis.cls - PhD Thesis Document Class
%% Based on the formatting from phd_thesis_zhuang_final.pdf
%% Reference style based on ieeeconf.cls
%%
%% Copyright (c) 2026
%%
%% This class provides formatting for PhD dissertations with:
%% - Custom cover page
%% - Title and subtitle formatting
%% - Figure and table captions
%% - Chapter and section formatting
%% - IEEE-style references
%% - Table of contents, list of figures, list of tables
%% - Abstract, acknowledgments, dedication
%% - Bibliography using IEEE conference style

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{phdthesis}[2026/03/06 v1.0 PhD Thesis Document Class]

% ============================================================================
% CLASS OPTIONS
% ============================================================================

% Default options
\newif\if@twoside \@twosidetrue
\newif\if@draft \@draftfalse
\newif\if@hyperref \@hyperreftrue

% Process options
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{twoside}{\@twosidetrue}
\DeclareOption{draft}{\@drafttrue}
\DeclareOption{final}{\@draftfalse}
\DeclareOption{nohyperref}{\@hyperreffalse}

% Pass unknown options to book class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

% Execute default options
\ExecuteOptions{twoside,final}
\ProcessOptions\relax

% Load base class
\if@twoside
  \LoadClass[12pt,letterpaper,twoside,openright]{book}
\else
  \LoadClass[12pt,letterpaper,oneside]{book}
\fi

% ============================================================================
% REQUIRED PACKAGES
% ============================================================================

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{CJKutf8}         % For Japanese characters
\RequirePackage{times}           % Times Roman font
\RequirePackage{mathptmx}        % Times Roman math font
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{tocloft}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}
\RequirePackage{xcolor}
\RequirePackage[numbers]{natbib}  % For bibliography with numerical citations
\RequirePackage[section]{placeins} % Prevent figures from floating past section boundaries

% Relax float placement limits so figures stay close to their reference point
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\renewcommand{\topfraction}{0.9}
\renewcommand{\bottomfraction}{0.9}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.7}

% Conditional hyperref loading
\if@hyperref
  \RequirePackage[hidelinks,breaklinks]{hyperref}
\fi

% ============================================================================
% PAGE LAYOUT AND GEOMETRY
% ============================================================================

% Two-sided layout: inner margin (binding side) is larger
\if@twoside
  \geometry{
    letterpaper,
    inner=1.5in,
    outer=1in,
    top=1in,
    bottom=1in,
    headheight=15pt,
    headsep=0.25in,
    footskip=0.5in
  }
\else
  \geometry{
    letterpaper,
    left=1.5in,
    right=1in,
    top=1in,
    bottom=1in,
    headheight=15pt,
    headsep=0.25in,
    footskip=0.5in
  }
\fi

% Line spacing
\if@draft
  \doublespacing
\else
  \onehalfspacing
\fi

% Paragraph formatting
\setlength{\parindent}{0.25in}
\setlength{\parskip}{0pt}

% ============================================================================
% HEADER AND FOOTER
% ============================================================================

\pagestyle{fancy}
\fancyhf{}
\if@twoside
  % Even pages (left side): page number on left, chapter on right
  \fancyhead[LE]{\thepage}
  \fancyhead[RE]{\itshape\leftmark}
  % Odd pages (right side): section on left, page number on right
  \fancyhead[LO]{\itshape\rightmark}
  \fancyhead[RO]{\thepage}
\else
  \fancyhead[L]{\itshape\leftmark}
  \fancyhead[R]{\thepage}
\fi
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

% Plain page style for chapter pages - same as regular pages
\fancypagestyle{plain}{%
  \fancyhf{}
  \if@twoside
    % Even pages (left side): page number on left
    \fancyhead[LE]{\thepage}
    % Odd pages (right side): page number on right
    \fancyhead[RO]{\thepage}
  \else
    \fancyhead[R]{\thepage}
  \fi
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

% ============================================================================
% TITLE PAGE INFORMATION
% ============================================================================

\def\@university{University Name}
\def\@department{Department Name}
\def\@degree{Doctor of Philosophy}
\def\@degreefield{Philosophy}
\def\@author{Author Name}
\def\@title{Thesis Title}
\def\@subtitle{}
\def\@submitdate{\the\year}
\def\@advisor{Advisor Name}
\def\@advisorb{}
\def\@advisorc{}
\def\@coadvisor{}
\def\@committee{}

\newcommand{\university}[1]{\def\@university{#1}}
\newcommand{\department}[1]{\def\@department{#1}}
\newcommand{\degree}[1]{\def\@degree{#1}}
\newcommand{\degreefield}[1]{\def\@degreefield{#1}}
\renewcommand{\author}[1]{\def\@author{#1}}
\renewcommand{\title}[1]{\def\@title{#1}}
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand{\submitdate}[1]{\def\@submitdate{#1}}
\newcommand{\advisor}[1]{\def\@advisor{#1}}
\newcommand{\advisorb}[1]{\def\@advisorb{#1}}
\newcommand{\advisorc}[1]{\def\@advisorc{#1}}
\newcommand{\coadvisor}[1]{\def\@coadvisor{#1}}
\newcommand{\committee}[1]{\def\@committee{#1}}

% ============================================================================
% COVER PAGE
% ============================================================================

\renewcommand{\maketitle}{%
  \thispagestyle{empty}
  \begin{center}
    \vspace*{0.0in}

    % University name
    {\Large\bfseries\MakeUppercase{\@university}\par}
    \vspace{0.05in}

    % Department
    {\large\@department\par}
    \vspace{1.5in}

    % Title
    {\LARGE\bfseries\@title\par}
    \vspace{0.2in}

    % Subtitle (if provided)
    \ifx\@subtitle\@empty\else
      {\large\begin{CJK}{UTF8}{min}\@subtitle\end{CJK}\par}
      \vspace{0.2in}
    \fi

    \vspace{2in}

    % Author
    \vspace{5\baselineskip}
    {\Large\bfseries\@author\par}
    
    \vfill

    % Advisor (removed from cover page)
    % \ifx\@advisor\@empty\else
    %   {\large\begin{tabular}[t]{@{}r@{\hspace{0.5em}}l@{}}
    %     Primary Advisor: & \@advisor \\
    %     \ifx\@advisorb\@empty\else & \@advisorb \\\fi
    %     \ifx\@advisorc\@empty\else & \@advisorc \\\fi
    %   \end{tabular}\par}
    %   \vspace{0.1in}
    % \fi

    {\normalsize\@submitdate\par}
    \vspace{1\baselineskip}

  \end{center}
  \clearpage
  \thispagestyle{empty}% blank verso page after cover
  \null
  \clearpage
  \setcounter{page}{1}
}

% ============================================================================
% SIGNATURE PAGE
% ============================================================================

\newcommand{\makesignature}{%
  \clearpage
  \thispagestyle{plain}
  \begin{center}
    {\Large\bfseries\@university\par}
    \vspace{0.5in}
    {\large\bfseries DISSERTATION APPROVAL\par}
  \end{center}
  
  \vspace{0.5in}
  
  This dissertation entitled:
  
  \vspace{0.2in}
  \begin{center}
    {\large\bfseries\@title\par}
    \ifx\@subtitle\@empty\else
      {\@subtitle\par}
    \fi
  \end{center}
  
  \vspace{0.3in}
  
  written by \@author
  
  \vspace{0.2in}
  
  has been approved for the \@department
  
  \vspace{1in}
  
  \begin{flushright}
    \rule{3in}{0.4pt}\\
    \@advisor, Advisor
    
    \vspace{0.5in}
    
    \ifx\@coadvisor\@empty\else
      \rule{3in}{0.4pt}\\
      \@coadvisor, Co-Advisor
      \vspace{0.5in}
    \fi
    
    \rule{3in}{0.4pt}\\
    Date
  \end{flushright}
  
  \clearpage
}

% ============================================================================
% COPYRIGHT PAGE
% ============================================================================

\newcommand{\makecopyright}{%
  \clearpage
  \thispagestyle{empty}
  \vspace*{\fill}
  \begin{center}
    Copyright \copyright\ \@submitdate\ by \@author\\
    All Rights Reserved
  \end{center}
  \vspace*{\fill}
  \clearpage
}

% ============================================================================
% ABSTRACT
% ============================================================================

\newenvironment{abstract}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{Abstract}
  \begin{center}
    {\Large\bfseries Abstract\par}
  \end{center}
  \vspace{0.3in}
}{%
  \cleardoublepage
}

% ============================================================================
% DEDICATION
% ============================================================================

\newenvironment{dedication}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Dedication}
  \vspace*{2in}
  \begin{center}
  \itshape
}{%
  \end{center}
  \vspace*{\fill}
  \clearpage
}

% ============================================================================
% ACKNOWLEDGMENTS
% ============================================================================

\newenvironment{acknowledgments}{%
  \cleardoublepage
  \phantomsection
  \markboth{Acknowledgments}{Acknowledgments}%
  \addcontentsline{toc}{chapter}{Acknowledgments}
  \begin{center}
    {\Large\bfseries Acknowledgments\par}
  \end{center}
  \vspace{0.3in}
}{%
  \clearpage
}

% ============================================================================
% TABLE OF CONTENTS, LOF, LOT
% ============================================================================

% TOC formatting
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\cfttoctitlefont}{\hfill\Large\bfseries}
\renewcommand{\cftaftertoctitle}{\hfill}
\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{1em}

% Chapter formatting in TOC — prepend "Chapter" to numbered entries
\renewcommand{\cftchapfont}{\bfseries}
\renewcommand{\cftchappagefont}{\bfseries}
\setlength{\cftbeforechapskip}{1em}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchappresnum}{Chapter\space}
\renewcommand{\cftchapaftersnum}{\hspace{0.5em}}
\newlength{\mychapnumwidth}
\settowidth{\mychapnumwidth}{\cftchapfont Chapter\space 00\hspace{0.5em}}
\setlength{\cftchapnumwidth}{\mychapnumwidth}

% Part formatting in TOC — prepend "Part I / Part II" to the title.
% tocloft skips \cftpartpresnum when titlesec is loaded, so we
% override the \part command to pass a custom TOC string.

% Customize chapter marks to show "Chapter X. Title"
\renewcommand{\chaptermark}[1]{\markboth{\chaptername\ \thechapter.\ #1}{}}
% Customize section marks to show "X.X Section Title"
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}

% Section formatting in TOC
\setlength{\cftbeforesecskip}{0.5em}

% List of Figures
\renewcommand{\listfigurename}{List of Figures}
\renewcommand{\cftloftitlefont}{\hfill\Large\bfseries}
\renewcommand{\cftafterloftitle}{\hfill}
\setlength{\cftbeforeloftitleskip}{0pt}
\setlength{\cftafterloftitleskip}{1em}

% List of Tables
\renewcommand{\listtablename}{List of Tables}
\renewcommand{\cftlottitlefont}{\hfill\Large\bfseries}
\renewcommand{\cftafterlottitle}{\hfill}
\setlength{\cftbeforelottitleskip}{0pt}
\setlength{\cftafterlottitleskip}{1em}

% ============================================================================
% CHAPTER AND SECTION FORMATTING
% ============================================================================

% Part formatting - centered on page, always on right page
\titleformat{\part}[display]
  {\normalfont\Huge\bfseries\centering\vfill}
  {\partname\ \thepart}
  {1em}
  {\Huge}
[\vfill\vfill]
\titlespacing*{\part}{0pt}{0pt}{0pt}

% Make sure parts always start on right page with empty style.
% Also inject "Part <num>" into the TOC entry automatically,
% since tocloft's \cftpartpresnum is disabled when titlesec is loaded.
% Strategy: use \part* for display (no TOC write) but give it the same
% visual format as the unstarred \part by defining a numberless format
% that still prints "Part <counter>".
\let\oldpart\part
\renewcommand{\part}[1]{%
  \cleardoublepage\thispagestyle{empty}%
  \refstepcounter{part}%
  \phantomsection%
  \addcontentsline{toc}{part}{Part~\thepart\hspace{0.5em}#1}%
  % Temporarily override the starred-part format to show "Part <num>"
  \titleformat{name=\part,numberless}[display]%
    {\normalfont\Huge\bfseries\centering\vfill}%
    {\partname\ \thepart}%
    {1em}%
    {\Huge}%
  [\vfill\vfill]%
  % Suppress titlesec's own TOC write for \part* (we already wrote ours above)
  \let\saved@ttladdcontentsline\ttl@addcontentsline
  \def\ttl@addcontentsline##1##2{}%
  \oldpart*{#1}%
  \let\ttl@addcontentsline\saved@ttladdcontentsline
}

% Chapter formatting
\titleformat{\chapter}[display]
  {\normalfont\huge\bfseries}
  {\chaptertitlename\ \thechapter}
  {1em}
  {\Huge}
\titlespacing*{\chapter}{0pt}{0pt}{2em}

% Chapter title with paper-attribution footnote (Zhuang convention).
% Usage: \notedchapter{Chapter Title}{Footnote text describing related papers}
% The footnote on the chapter title is rendered as an asterisk (*), and
% subsequent footnotes inside the chapter restart from 1.
\newcommand{\notedchapter}[2]{%
  \begingroup
  \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
  \chapter[#1]{#1\protect\footnotemark}%
  \global\let\notedchapter@currentlabel\@currentlabel
  \footnotetext{#2}%
  \endgroup
  \let\@currentlabel\notedchapter@currentlabel
  \setcounter{footnote}{0}%
}

% Section formatting
\titleformat{\section}
  {\normalfont\Large\bfseries}
  {\thesection}
  {1em}
  {}
\titlespacing*{\section}{0pt}{2em}{1em}

% Subsection formatting
\titleformat{\subsection}
  {\normalfont\large\bfseries}
  {\thesubsection}
  {1em}
  {}
\titlespacing*{\subsection}{0pt}{1.5em}{0.75em}

% Subsubsection formatting
\titleformat{\subsubsection}
  {\normalfont\normalsize\bfseries}
  {\thesubsubsection}
  {1em}
  {}
\titlespacing*{\subsubsection}{0pt}{1em}{0.5em}

% Paragraph formatting (title on its own line, text starts on next line)
\titleformat{\paragraph}[block]
  {\normalfont\normalsize\bfseries}
  {\theparagraph}
  {1em}
  {}
\titlespacing*{\paragraph}{0pt}{*2}{*0.5}

% ============================================================================
% FIGURE AND TABLE CAPTIONS
% ============================================================================

% Figure captions
\captionsetup[figure]{
  labelfont=bf,
  textfont=normal,
  font=small,
  labelsep=period,
  justification=centering,
  singlelinecheck=false,
  position=bottom
}

% Table captions
\captionsetup[table]{
  labelfont=bf,
  textfont=normal,
  font=small,
  labelsep=period,
  justification=centering,
  singlelinecheck=false,
  position=top
}

% Subfigure captions
\captionsetup[subfigure]{
  labelfont=bf,
  textfont=normal,
  font=footnotesize,
  labelformat=simple,
  labelsep=space,
  justification=centering
}
% Subfigure label as (a),(b),... both in captions and cross-references
\renewcommand\thesubfigure{(\alph{subfigure})}
% Cross-reference format: Fig. 1.1 (a) — insert a thin space before the letter
% Note: no \makeatletter/\makeatother needed inside a .cls file
\renewcommand\p@subfigure{\thefigure\,}

% ============================================================================
% THEOREM ENVIRONMENTS
% ============================================================================

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}

\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{remark}[theorem]{Remark}

% ============================================================================
% BIBLIOGRAPHY - IEEE CONFERENCE STYLE
% ============================================================================

% Bibliography heading
\renewcommand{\bibname}{References}

% Bibliography formatting
\renewenvironment{thebibliography}[1]{%
  \chapter*{\bibname}%
  \markboth{\bibname}{\bibname}%
  \phantomsection
  \addcontentsline{toc}{chapter}{\bibname}%
  \setcounter{NAT@ctr}{0}%  % Reset natbib counter so references always start at [1]
  \list{\@biblabel{\@arabic\c@enumiv}}%
  {%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}%
    \small
    \setlength{\itemsep}{0pt}%
    \setlength{\parsep}{0pt}%
  }%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}

% Citation format (IEEE style brackets)
\renewcommand{\@cite}[2]{[{#1\if@tempswa , #2\fi}]}
\renewcommand{\@biblabel}[1]{[#1]}

% ============================================================================
% LIST ENVIRONMENTS
% ============================================================================

% Itemize
\renewcommand{\labelitemi}{$\bullet$}
\renewcommand{\labelitemii}{$\circ$}
\renewcommand{\labelitemiii}{$\diamond$}
\renewcommand{\labelitemiv}{$\ast$}

% Enumerate
\renewcommand{\theenumi}{\arabic{enumi}}
\renewcommand{\theenumii}{\alph{enumii}}
\renewcommand{\theenumiii}{\roman{enumiii}}
\renewcommand{\theenumiv}{\Alph{enumiv}}

% ============================================================================
% APPENDIX
% ============================================================================

\renewcommand{\appendix}{%
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand{\chaptername}{Appendix}%
  \renewcommand{\thechapter}{\Alph{chapter}}%
}

% ============================================================================
% MISCELLANEOUS
% ============================================================================

% No widows and orphans
\widowpenalty=10000
\clubpenalty=10000

% Draft mode watermark
\if@draft
  \RequirePackage{draftwatermark}
  \SetWatermarkText{DRAFT}
  \SetWatermarkScale{3}
  \SetWatermarkColor[gray]{0.9}
\fi

% ============================================================================
% NOMENCLATURE (optional)
% ============================================================================

\newenvironment{nomenclature}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Nomenclature}
  \chapter*{Nomenclature}
  \begin{list}{}%
  {%
    \setlength{\labelwidth}{1.5in}%
    \setlength{\leftmargin}{\labelwidth}%
    \addtolength{\leftmargin}{\labelsep}%
    \setlength{\itemsep}{0pt}%
    \setlength{\parsep}{0pt}%
  }%
}{%
  \end{list}
  \clearpage
}

% ============================================================================
% VITA (Biography)
% ============================================================================

\newenvironment{vita}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Vita}
  \chapter*{Vita}
}{%
  \clearpage
}

% ============================================================================
% RESEARCH ACHIEVEMENTS
% ============================================================================

% Auto-numbered list for each subsection of research achievements.
% Counter restarts from 1 each time \begin{achievementlist} is used.
\newcounter{achievenum}
\newenvironment{achievementlist}{%
  \setcounter{achievenum}{0}%
  \begin{list}{[\theachievenum]}{%
    \usecounter{achievenum}%
    \setlength{\leftmargin}{2.8em}%
    \setlength{\labelsep}{0.6em}%
    \setlength{\itemsep}{0.4em}%
    \setlength{\parsep}{0pt}%
    \setlength{\topsep}{0.5em}%
  }%
}{%
  \end{list}%
}

\newenvironment{achievements}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Research achievements}
  \chapter*{Research achievements}%
  \markboth{Research achievements}{Research achievements}%
}{%
  \clearpage
}

% ============================================================================
% USEFUL COMMANDS
% ============================================================================

% Degree symbol
\providecommand{\degree}{\ensuremath{^\circ}}

% Quotes environment
\newenvironment{inquote}%
  {\begin{quote}\itshape}%
  {\end{quote}}

% Epigraph
\newcommand{\epigraph}[2]{%
  \vspace{1em}
  \begin{flushright}
    \begin{minipage}{0.7\textwidth}
      \itshape #1
      \begin{flushright}
        --- #2
      \end{flushright}
    \end{minipage}
  \end{flushright}
  \vspace{1em}
}

% ============================================================================
% END OF CLASS
% ============================================================================

\endinput
