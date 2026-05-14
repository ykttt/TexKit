%% GeneralReportInline.cls
%%
%% Compact inline report metadata header for LuaLaTeX / LuaTeX-ja.
%% Metadata is printed at the top of the first page, not on a separate title page.
%% All metadata fields are hidden by default and are printed only when filled.
%% Filled metadata fields are arranged sequentially in two compact columns.
%%
%% Author: ykttt
%% Contact: https://github.com/ykttt
%%
%% Last updated: 2026-05-14
%%
%% A4 paper, 22 mm margins, 11 pt text.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{GeneralReportInline}[2026/05/14 General LuaLaTeX inline report class]

\LoadClass[11pt,a4paper]{ltjsarticle}

% ----------------
% Basic packages
% ----------------
\RequirePackage{geometry}
\geometry{a4paper,margin=22mm}

\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{etoolbox}
\RequirePackage{cite}
\RequirePackage{enumitem}
\RequirePackage{listings}
\RequirePackage{fvextra}
\RequirePackage{siunitx}
\RequirePackage{url}
\RequirePackage{caption}
\RequirePackage[subrefformat=parens]{subcaption}
\RequirePackage{fontspec}
\RequirePackage{luatexja-fontspec}
\RequirePackage{unicode-math}

% ----------------
% Layout and spacing
% ----------------
\ltjsetparameter{autoxspacing=true, autospacing=true}
\setlength{\parindent}{1\zw}
\setlength{\parskip}{0pt}
\pagestyle{plain}
\sloppy

\captionsetup{width=\linewidth}
\captionsetup{compatibility=false}

% ----------------
% Listings
% ----------------
\lstset{
  basicstyle=\ttfamily\small,
  keywordstyle=\color{blue},
  commentstyle=\color{teal},
  stringstyle=\color{magenta},
  identifierstyle=\color{black},
  breaklines=true,
  breakatwhitespace=false,
  showstringspaces=false,
  frame=single,
  xleftmargin=1em,
  xrightmargin=1em,
  columns=fullflexible,
  keepspaces=true,
  captionpos=b,
  upquote=true,
}

% ----------------
% siunitx
% ----------------
\sisetup{
  detect-all,
  separate-uncertainty=true
}

% ----------------
% Metadata
% ----------------
% Default values are intentionally empty. A field is printed only after the user
% sets it with the corresponding command below.
\newcommand{\ReportType}{}
\newcommand{\ReportNumber}{}
\newcommand{\Institution}{}
\newcommand{\StudentName}{}
\newcommand{\StudentID}{}
\newcommand{\Collaborators}{}
\newcommand{\ExperimentDate}{}
\newcommand{\SubmissionDate}{}

\newcommand{\reporttype}[1]{\renewcommand{\ReportType}{#1}}
\newcommand{\reportnumber}[1]{\renewcommand{\ReportNumber}{#1}}
\newcommand{\institution}[1]{\renewcommand{\Institution}{#1}}
\newcommand{\studentname}[1]{\renewcommand{\StudentName}{#1}}
\newcommand{\studentid}[1]{\renewcommand{\StudentID}{#1}}
\newcommand{\collaborators}[1]{\renewcommand{\Collaborators}{#1}}
\newcommand{\experimentdate}[1]{\renewcommand{\ExperimentDate}{#1}}
\newcommand{\submissiondate}[1]{\renewcommand{\SubmissionDate}{#1}}

\renewcommand{\title}[1]{\gdef\@title{#1}}
\title{}

% ----------------
% Compact inline title block helpers
% ----------------
\newif\ifGRI@hasheader
\newif\ifGRI@hasmetadata

\newcommand{\GRI@checkheader}{%
  \GRI@hasheaderfalse
  \ifdefempty{\@title}{}{\GRI@hasheadertrue}%
  \ifdefempty{\ReportType}{}{\GRI@hasheadertrue}%
  \ifdefempty{\ReportNumber}{}{\GRI@hasheadertrue}%
}

\newcommand{\GRI@checkmetadata}{%
  \GRI@hasmetadatafalse
  \ifdefempty{\Institution}{}{\GRI@hasmetadatatrue}%
  \ifdefempty{\StudentName}{}{\GRI@hasmetadatatrue}%
  \ifdefempty{\StudentID}{}{\GRI@hasmetadatatrue}%
  \ifdefempty{\ExperimentDate}{}{\GRI@hasmetadatatrue}%
  \ifdefempty{\SubmissionDate}{}{\GRI@hasmetadatatrue}%
  \ifdefempty{\Collaborators}{}{\GRI@hasmetadatatrue}%
}

\newcounter{GRI@metacount}
\newcommand{\GRI@metabody}{}

% Add a metadata item only when the value is nonempty. Items are packed in
% reading order: left -> right, then top -> bottom.
\newcommand{\GRI@addmetaitem}[2]{%
  \ifdefempty{#2}{}{%
    \ifodd\value{GRI@metacount}%
      \gappto\GRI@metabody{& \textbf{#1}：#2}%
    \else
      \ifnum\value{GRI@metacount}>0 \gappto\GRI@metabody{\tabularnewline} \fi
      \gappto\GRI@metabody{\textbf{#1}：#2}%
    \fi
    \stepcounter{GRI@metacount}%
  }%
}

\newcommand{\GRI@buildmetabody}{%
  \setcounter{GRI@metacount}{0}%
  \gdef\GRI@metabody{}%
  \GRI@addmetaitem{所属}{\Institution}%
  \GRI@addmetaitem{名前}{\StudentName}%
  \GRI@addmetaitem{学籍番号}{\StudentID}%
  \GRI@addmetaitem{実験日}{\ExperimentDate}%
  \GRI@addmetaitem{提出日}{\SubmissionDate}%
  \GRI@addmetaitem{共同実験者}{\Collaborators}%
  \ifodd\value{GRI@metacount}\gappto\GRI@metabody{&}\fi
}

% Compact first-page title block. If every field is empty, this command prints
% nothing and does not consume vertical space. Metadata is packed sequentially
% into two columns without reserving fixed positions for particular fields.
\newcommand{\makereporttitle}{%
  \begingroup
  \GRI@checkheader
  \GRI@checkmetadata
  \setlength{\parindent}{0pt}%
  \ifGRI@hasheader
    \noindent
    \begin{minipage}[t]{.62\linewidth}
      \raggedright
      \ifdefempty{\@title}{}{{\Large\bfseries \@title\par}}%
      \ifdefempty{\ReportNumber}{}{{\small \ReportNumber\par}}%
    \end{minipage}%
    \hfill
    \begin{minipage}[t]{.34\linewidth}
      \raggedleft
      \ifdefempty{\ReportType}{}{{\normalsize\bfseries \ReportType\par}}%
    \end{minipage}\par
    \vspace{1.5mm}\hrule\vspace{1.5mm}%
  \fi
  \ifGRI@hasmetadata
    \small
    \GRI@buildmetabody
    \noindent
    \begin{tabular}{@{}p{.49\linewidth}p{.49\linewidth}@{}}
      \GRI@metabody
    \end{tabular}\par
    \vspace{1.5mm}\hrule\vspace{4mm}%
  \else
    \ifGRI@hasheader\vspace{2.5mm}\fi
  \fi
  \endgroup
}

\endinput