%% RitsBioinfoReport.cls
%%
%% UNOFFICIAL LaTeX class based on the Microsoft Word
%% experiment report template for the Department of
%% Bioinformatics, College of Life Sciences,
%% Ritsumeikan University.
%%
%% This class is for personal report-writing use
%% and is NOT affiliated with, endorsed by,
%% or maintained by Ritsumeikan University.
%%
%% Last updated: 2026-05-13
%%
%% Author: ykttt
%% Contact: https://github.com/ykttt
%%
%% A4 paper, 20 mm margins, 12 pt text,
%% approximately 52 lines per page.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{RitsBioinfoReport}[2026/05/13 Unofficial experiment report class for College of Life Sciences, Ritsumeikan University]

\LoadClass[12pt,a4paper]{ltjsarticle}

% Page layout: close to the Word template.
\RequirePackage[
  top=20mm,
  bottom=20mm,
  left=21mm,
  right=21mm,
  headheight=0pt,
  headsep=0pt,
  footskip=12mm
]{geometry}

% Basic packages.
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{amsmath,amssymb}
\RequirePackage{array}
\RequirePackage{float}
\RequirePackage{url}
\RequirePackage{fontspec}
\RequirePackage{luatexja-fontspec}
\RequirePackage{unicode-math}
\RequirePackage{booktabs}
\RequirePackage{subcaption}

% Fonts: use the required Windows fonts when available.
% Japanese: MS Mincho / MS Gothic. English: Times New Roman.
\IfFontExistsTF{Times New Roman}{%
  \setmainfont{Times New Roman}[
    BoldFont={Times New Roman Bold},
    ItalicFont={Times New Roman Italic},
    BoldItalicFont={Times New Roman Bold Italic}
  ]%
}{%
  \IfFontExistsTF{Tinos}{%
    \setmainfont{Tinos}%
  }{%
    \setmainfont{TeX Gyre Termes}%
  }%
}

\IfFontExistsTF{MS Mincho}{%
  \setmainjfont{MS Mincho}[BoldFont={MS Mincho}]%
}{%
  \IfFontExistsTF{Noto Serif CJK JP}{%
    \setmainjfont{Noto Serif CJK JP}%
  }{%
    \setmainjfont{HaranoAjiMincho}%
  }%
}

\IfFontExistsTF{MS Gothic}{%
  \setsansjfont{MS Gothic}[BoldFont={MS Gothic}]%
}{%
  \IfFontExistsTF{Noto Sans CJK JP}{%
    \setsansjfont{Noto Sans CJK JP}%
  }{%
    \setsansjfont{HaranoAjiGothic}%
  }%
}

\IfFontExistsTF{Cambria Math}{%
  \setmathfont{Cambria Math}%
}{%
  \setmathfont{latinmodern-math.otf}%
}

% Spacing and paragraph style.
\ltjsetparameter{autoxspacing=true, autospacing=true}
\setlength{\parindent}{1\zw}
\setlength{\parskip}{0pt}
\setlength{\abovedisplayskip}{6pt}
\setlength{\belowdisplayskip}{6pt}
\setlength{\tabcolsep}{6pt}
\renewcommand{\arraystretch}{1.05}
\pagestyle{plain}
\sloppy

% --------------------------------
% Report metadata and title page
% --------------------------------
\newcommand{\report@title}{レポート}
\newcommand{\report@department}{立命館大学　生命科学部　生命情報学科}
\newcommand{\report@studentid}{0000000000}
\newcommand{\report@studentname}{Name}

\newcommand{\reporttitle}[1]{\renewcommand{\report@title}{#1}}
\newcommand{\reportdepartment}[1]{\renewcommand{\report@department}{#1}}
\newcommand{\studentid}[1]{\renewcommand{\report@studentid}{#1}}
\newcommand{\studentname}[1]{\renewcommand{\report@studentname}{#1}}

\newcommand{\makereporttitle}{%
  \thispagestyle{empty}%
  \vspace*{22mm}%
  \begin{center}%
    {\mcfamily\fontsize{25}{27}\selectfont
      \report@title\par}%
  \end{center}%
  \vspace*{101mm}%
  \begin{flushright}%
    {\fontsize{17}{18}\selectfont \report@department\par}%
    \vspace{4mm}%
    {\fontsize{17}{18}\selectfont 学籍番号: \report@studentid\par}%
    \vspace{16mm}%
    {\fontsize{26}{31}\selectfont \report@studentname\par}%
  \end{flushright}%
  \clearpage
  \normalsize
  \setcounter{page}{1}%
}

% ---------------
% Section style
% ---------------
% Keep the original ltjsarticle/jsarticle section mechanism and spacing.
% Only change the printed heading text.
% \section{a}       -> 【a】
% \subsection{a}    -> a
% \subsubsection{a} -> a
\setcounter{secnumdepth}{0}

\newcommand{\Rits@sectionstyle}[1]{%
  \normalfont\normalsize\mcfamily\mbox{【#1】}%
}
\newcommand{\Rits@subsectionstyle}[1]{%
  \normalfont\normalsize\mcfamily #1%
}
\newcommand{\Rits@subsubsectionstyle}[1]{%
  \normalfont\normalsize\mcfamily #1%
}

\if@twocolumn
  \renewcommand{\section}{%
    \@startsection{section}{1}{\z@}%
    {0.6\Cvs}{0.4\Cvs}%
    {\Rits@sectionstyle}}
  \renewcommand{\subsection}{%
    \@startsection{subsection}{2}{\z@}%
    {\z@}{\if@slide .4\Cvs \else \z@ \fi}%
    {\Rits@subsectionstyle}}
  \renewcommand{\subsubsection}{%
    \@startsection{subsubsection}{3}{\z@}%
    {\z@}{\if@slide .4\Cvs \else \z@ \fi}%
    {\Rits@subsubsectionstyle}}
\else
  \renewcommand{\section}{%
    \if@slide\clearpage\fi
    \@startsection{section}{1}{\z@}%
    {\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
    {.5\Cvs \@plus.3\Cdp}%
    {\Rits@sectionstyle}}
  \renewcommand{\subsection}{%
    \@startsection{subsection}{2}{\z@}%
    {\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
    {.5\Cvs \@plus.3\Cdp}%
    {\Rits@subsectionstyle}}
  \renewcommand{\subsubsection}{%
    \@startsection{subsubsection}{3}{\z@}%
    {\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
    {\if@slide .5\Cvs \@plus.3\Cdp \else \z@ \fi}%
    {\Rits@subsubsectionstyle}}
\fi

% ----------------------
% Figure / Table style
% ----------------------
% Keep figure/table captions exactly as ltjsarticle/jsarticle defaults.
% Center the contents of figure/table by default.
\let\Rits@origfigure\figure
\let\Rits@endorigfigure\endfigure
\renewenvironment{figure}[1][tbp]{%
  \Rits@origfigure[#1]%
  \centering
}{%
  \Rits@endorigfigure
}

\let\Rits@origtable\table
\let\Rits@endorigtable\endtable
\renewenvironment{table}[1][tbp]{%
  \Rits@origtable[#1]%
  \centering
}{%
  \Rits@endorigtable
}

% --------------
% Bibliography
% --------------
\renewcommand{\refname}{参考文献}
\renewcommand{\@biblabel}[1]{[#1]}
\renewcommand{\@cite}[2]{[#1]}

\renewenvironment{thebibliography}[1]
{%
  \par
  \vspace{\baselineskip}%
  \noindent\refname\par
  \list{\@biblabel{\arabic{enumiv}}}{%
    \usecounter{enumiv}%
    \setlength{\leftmargin}{0pt}%
    \setlength{\labelwidth}{0pt}%
    \setlength{\labelsep}{0.5em}%
    \setlength{\itemindent}{0pt}%
    \setlength{\itemsep}{0pt}%
    \setlength{\parsep}{0pt}%
    \setlength{\topsep}{0pt}%
  }%
  \sloppy
  \clubpenalty4000
  \widowpenalty4000
  \sfcode`\.\@m
}
{\endlist}

\endinput