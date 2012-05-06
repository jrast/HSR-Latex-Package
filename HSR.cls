% This file contains a basic documentclass for different papers at the HSR
% The base documentclass of this document is article
% Author: Juerg Rast (jrast@hsr.ch)
% Date:   23.4.2012
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{HSR}[2012/04/23 HSR-Spezial Klasse]

% Diese Packages werden gebraucht um Optionen zu übergeben und auszuwerten
\RequirePackage{kvoptions}
\RequirePackage{boolexpr, pdftexcmds}

% Dem (at)-Zeichen den gleichen Code zuweisen wie normalen Buchstaben
\makeatletter
%% Hilfsfunktion für Stringvergleiche
\long\def\isequal#1#2{\pdf@strcmp{#1}{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Eigene definitionen für Längen %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength{\HSRInner}\setlength{\HSRInner}{25mm}
\newlength{\HSROuter}\setlength{\HSROuter}{42mm}

%%%%%%%%%%%%%%%%%%%%%%
%% Package Optionen %%
%%%%%%%%%%%%%%%%%%%%%%
\DeclareStringOption[top]{logo}[top]

\DeclareVoidOption{twoside}{
  \PassOptionsToClass{twoside}{article}
  \setlength{\HSRInner}{21mm}
  \setlength{\HSROuter}{42mm}
}



\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
%% Optionen verarbeiten
\ProcessKeyvalOptions*

%% Klasse article laden
\LoadClass[a4paper]{article}


%%%%%%%%%%%%%%
%% Packages %%
%%%%%%%%%%%%%%
\RequirePackage{HSRColors}
\RequirePackage[utf8]{inputenc}
\RequirePackage[ngerman]{babel,varioref}
\RequirePackage{graphicx}
\RequirePackage[scaled]{uarial}
\RequirePackage[T1]{fontenc}
\RequirePackage[
	headheight=25.5mm, % Gleich hoch wie HSR Logo!
	headsep=5mm,
	top=40mm,
	inner=\HSRInner,
	outer=\HSROuter,
	bottom=30mm,
  marginparsep=5mm,
	marginparwidth=32mm]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%
%% Kopf- und Fusszeile %%
%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{fancyhdr}
\newcommand{\arialForHeader}{%
\fontfamily{ua1}\fontseries{m}\fontsize{10}{11.5}\selectfont}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{
	\raisebox{-3.6mm}{\includegraphics[width=60.5mm]{images/HSR_Logo_CMYK}}
}
\fancyhead[R] {
	\nouppercase\leftmark\\
	\vspace{1.7mm}
}
\if@twoside
  \fancyfoot[EL,OR]{\arialForHeader \thepage}
  \fancyfoot[OL,ER]{\arialForHeader \today}
\else
  \fancyfoot[R]{\arialForHeader \thepage}
  \fancyfoot[L]{\arialForHeader \today}
\fi
\renewcommand{\footrulewidth}{0.5pt}
\renewcommand{\headrulewidth}{0.5pt}

%\fancyhfoffset[LE,RO]{35mm} % = marginparwidth + marginparsep

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Links, Verweise und Aktionen im Dokument %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{hyperref}
\hypersetup{
	linkbordercolor=HSRBlue40,
	urlbordercolor=HSRLakeGreen40,
	pdfdisplaydoctitle
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Föllig sinnloser switch-Block um zu sehen wie es funktioniert! %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\switch
\case{\isequal{\HSR@logo}{undefined}}
  %\fancyfoot[c]{undefined}
\case{\isequal{\HSR@logo}{top}}
  %\fancyfoot[c]{top}
\case{\isequal{\HSR@logo}{bottom}}
  %\fancyfoot[c]{bottom}
\otherwise
  \ClassError{HSR}{
    \MessageBreak
    value >\HSR@logo< unknown \MessageBreak
    possible values are: top (default), bottom. \MessageBreak
  }{}
\endswitch
\makeatother




%%%%%%%%%%%%%%%%%%%%%%%%%
%% Margin-Notes Design %%
%%%%%%%%%%%%%%%%%%%%%%%%%
\let\OldMarginPar\marginpar
\renewcommand{\marginpar}[1]{\OldMarginPar{\textit{#1}}}

%%%%%%%%%%%%%%
%% Commands %%
%%%%%%%%%%%%%%
\newcommand{\settitle}[1]{%
  \hypersetup{pdftitle={#1}}
  \fancyhead[R] {
    \arialForHeader #1\\
    \nouppercase\leftmark\\
    \vspace{1.7mm}
  }
}

\newcommand{\setauthor}[1]{%
  \hypersetup{pdfauthor={#1}}
  \if@twoside
    \fancyfoot[OL,ER]{\arialForHeader #1, \today}
  \else
    \fancyfoot[L]{\arialForHeader #1, \today}
  \fi
}

\newcommand{\setarraystretch}[1]{%
  \renewcommand{\arraystretch}{#1}
}

\makeatother
