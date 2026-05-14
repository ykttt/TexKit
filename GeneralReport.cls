%% GeneralReport.cls
%%
%% This class extracts the common report format:
%% title page, A4 layout, captions,
%% subfigures, listings, and siunitx
%%
%% Author: ykttt
%% Contact: https://github.com/ykttt
%%
%% Last updated: 2026-05-14
%%
%% A4 paper, 22 mm margins, 11 pt text.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{GeneralReport}[2026/05/14 General LuaLaTeX report class]

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
\newcommand{\ReportType}{レポート}
\newcommand{\ReportNumber}{}
\newcommand{\Institution}{}
\newcommand{\StudentName}{}
\newcommand{\StudentID}{}
\newcommand{\Collaborators}{}
\newcommand{\ExperimentDate}{}
\newcommand{\SubmissionDate}{\today}

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

\newcommand{\makereporttitle}{%
  \begin{titlepage}
    \centering
    \vspace*{10mm}
    {\Large \Institution\par}
    \vspace{20mm}
    {\Huge\bfseries \ReportType\par}
    \vspace{5mm}
    {\Large \ReportNumber\par}
    \vfill
    {\LARGE\bfseries \@title \par}
    \vspace{10mm}
    {\large
      名前：\StudentName\\
      学籍番号：\StudentID\\
      \ifx\Collaborators\@empty
      \else
        共同実験者：\Collaborators\\
      \fi
      \Institution\par
    }
    \vspace{10mm}
    \ifx\ExperimentDate\@empty
      提出日：\SubmissionDate\par
    \else
      実験日：\ExperimentDate\\
      提出日：\SubmissionDate\par
    \fi
    \vfill
  \end{titlepage}
}

\endinput
