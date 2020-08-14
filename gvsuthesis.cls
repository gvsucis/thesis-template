% !TEX TS-program = xelatex
% !TEX encoding = UTF-8 Unicode
% -*- coding: UTF-8; -*-
% vim: set fenc=utf-8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% gvsuthesis.cls
%% <https://github.com/kkredit/thesis-template>
%% Licensed under the LaTeX Project Public License v1.3c.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{gvsuthesis}

\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{letterpaper}{\PassOptionsToClass{\CurrentOption}{report}}

% Run in non-stop mode.
\DeclareOption{nonstopmode}{\nonstopmode}

% Draft mode.
\newcommand{\TypesetInDraftMode}{0}
\DeclareOption{draftmode}{\renewcommand{\TypesetInDraftMode}{1}}

% Text spacing.
\newcommand{\SpacingSetting}{\doublespacing}
\DeclareOption{doublespacing}{\renewcommand{\SpacingSetting}{\doublespacing}}
\DeclareOption{singlespacing}{\renewcommand{\SpacingSetting}{\singlespacing}}
\DeclareOption{onehalfspacing}{\renewcommand{\SpacingSetting}{\onehalfspacing}}

% Text justification.
\newcommand{\JustificationSetting}{\RaggedRight}
\DeclareOption{RaggedRight}{\renewcommand{\JustificationSetting}{\RaggedRight}}
\DeclareOption{justifying}{\renewcommand{\JustificationSetting}{\justifying}}

% Font family.
\newcommand{\LiberationFonts}{1}
\DeclareOption{msfonts}{\renewcommand{\LiberationFonts}{0}}

% Serifs or sans.
\newcommand{\SansFonts}{0}
\DeclareOption{sansfonts}{\renewcommand{\SansFonts}{1}}

% Bibliography style.
\newcommand{\Bibstyle}{IEEEtran}
\newcommand{\Bibsettings}{IEEEfull}
\DeclareOption{bibIEEEfull}{}
\DeclareOption{bibIEEEabrv}{
    \renewcommand{\Bibsettings}{IEEEabrv}
}
\DeclareOption{bibACM}{
    \renewcommand{\Bibstyle}{acm}
    \renewcommand{\Bibsettings}{\empty}
}

\ProcessOptions\relax

% Use report class as the base class.
\LoadClass[12pt,oneside]{report}

% Geometry package for page margins.
% A4-size (210 mm × 297 mm) single-sided pages
% Letter-size (8.5 in × 11 in) single-sided pages
\RequirePackage[
left=1in,
right=1in,
top=1in,
bottom=1in,
headsep=0.5in, % header separation, above text body
footskip=0.5in] % footer skip, below text body
{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MISCELLANEOUS PACKAGES.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\RequirePackage[none]{hyphenat} % Disable hyphenation.
\RequirePackage[english]{babel} % For language-specific hyphenation.
\RequirePackage{cite} % Automatically sort and range citations numbers.
\RequirePackage{environ} % For easy definition of environments.
\RequirePackage{rotating} % For rotating objects.
\RequirePackage{framed} % For framed text.
\RequirePackage{pdfpages} % Directly include PDFs
\RequirePackage{etoolbox} % For declaration of bools.
\RequirePackage[acronym,toc]{glossaries} % For glossary generation
\RequirePackage[shortcuts=ac]{glossaries-extra} % For glossary generation, shortcuts

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PDF OUTPUT.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PDF settings and properties.
\RequirePackage{hyperref}

% Whether to include GVSU forms. Can be overriden in Thesis.tex.
\newbool{IncludeForms}
\booltrue{IncludeForms}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% COLORS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xcolor} % For colors.
\definecolor{AccentOne}{RGB}{0,101,164} % GVSU Laker Blue

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FONTS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{fontspec}
\defaultfontfeatures{Mapping=tex-text} % to support TeX conventions like "---".
\RequirePackage{xunicode} % Unicode support for LaTeX character names (accents, European chars, etc.).
\RequirePackage{xltxtra} % Extra customizations for XeLaTeX.
\RequirePackage{lmodern} % For Latin Modern fonts.

\ifnum\LiberationFonts=0
    \setromanfont{Times New Roman}
    \setsansfont{Arial}
    \setmonofont{Courier New}
    \ifnum\SansFonts=0
        \setmainfont{Times New Roman}
    \else
        \setmainfont{Arial}
    \fi
\else
    % Font: Roman font, \textrm{}, \rmfamily.
    \setromanfont
    [Path=./Fonts/liberation-serif/,
    ItalicFont=LiberationSerif-Italic,
    BoldFont=LiberationSerif-Bold,
    BoldItalicFont=LiberationSerif-BoldItalic,
    Scale=1.00]
    {LiberationSerif-Regular.ttf}

    % Font: Sans-serif font, \textsf{}, \sffamily.
    \setsansfont
    [Path=./Fonts/liberation-sans/,
    ItalicFont=LiberationSans-Italic,
    BoldFont=LiberationSans-Bold,
    BoldItalicFont=LiberationSans-BoldItalic,
    Scale=1.00]
    {LiberationSans-Regular.ttf}

    % Font: Monospace font, \texttt{}, \ttfamily.
    \setmonofont
    [Path=./Fonts/liberation-mono/,
    ItalicFont=LiberationMono-Italic,
    BoldFont=LiberationMono-Bold,
    BoldItalicFont=LiberationMono-BoldItalic,
    Scale=0.95]
    {LiberationMono-Regular.ttf}

    % Font: Main font, \textnormal{}, \normalfont.
    \ifnum\SansFonts=0
        \setmainfont
        [Path=./Fonts/liberation-serif/,
        ItalicFont=LiberationSerif-Italic,
        BoldFont=LiberationSerif-Bold,
        BoldItalicFont=LiberationSerif-BoldItalic,
        Scale=1.00]
        {LiberationSerif-Regular.ttf}
    \else
        \setmainfont
        [Path=./Fonts/liberation-sans/,
        ItalicFont=LiberationSans-Italic,
        BoldFont=LiberationSans-Bold,
        BoldItalicFont=LiberationSans-BoldItalic,
        Scale=1.00]
        {LiberationSans-Regular.ttf}
    \fi
\fi

% Symbols.
\RequirePackage{textcomp} % For symbols.
\RequirePackage{underscore} % Use underscore symbol without escape sequence.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SECTION HEADINGS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Section heading fonts.
\RequirePackage[explicit]{titlesec}

\titlespacing*{\part}%
{0em}% left
{8em}% vertical space before title
{4em}% vertical space after title
[0em]% right

\titleformat{\part}
[display]% shape
{\normalfont\bfseries\filcenter}% applied to label and text
{\fontsize{16}{19.2}\selectfont\color{AccentOne}PART~\thepart}% applied to the label only
{1em}% vertical spacing between label and text
{\fontsize{32}{38.4}\selectfont{#1}}% applied before the text
[]% applied after the text

\titleformat{name=\part,numberless}
[display]% shape
{\normalfont\bfseries\filcenter}% applied to label and text
{\fontsize{16}{19.2}\selectfont\color{AccentOne}~}% applied to the label only
{1em}% vertical spacing between label and text
{\fontsize{32}{38.4}\selectfont{#1}}% applied before the text
[]% applied after the text

\titlespacing*{\chapter}%
{0em}% left
{5em}% vertical space before title
{2em}% vertical space after title
[0em]% right

\titleformat{\chapter}
[display]% shape
{\normalfont\bfseries\raggedright}% applied to label and text
{\fontsize{17.5}{21}\selectfont\color{AccentOne}CHAPTER~\thechapter}% applied to the label only
{0em}% vertical spacing between label and text
{\fontsize{30}{36}\selectfont{#1}}% applied before the text
[]% applied after the text

\titleformat{name=\chapter,numberless}
[display]% shape
{\normalfont\bfseries\raggedright}% applied to label and text
{\fontsize{17.5}{21}\selectfont\color{AccentOne}~}% applied to the label only
{0em}% vertical spacing between label and text
{\fontsize{30}{36}\selectfont{#1}}% applied before the text
[]% applied after the text

\titleformat{\section}%
[hang]% shape
{\fontsize{17}{20.4}\selectfont\normalfont\bfseries\raggedright}% applied to label and text
{\color{AccentOne}\thetitle}% applied to the label only
{0.5em}% horizontal spacing between label and text
{#1}% applied before the text
[]% applied after the text

\titleformat{\subsection}%
[hang]% shape
{\fontsize{14.5}{17.4}\selectfont\normalfont\bfseries\raggedright}% applied to label and text
{\color{AccentOne}\thetitle}% applied to the label only
{0.5em}% horizontal spacing between label and text
{#1}% applied before the text
[]% applied after the text

\titleformat{\subsubsection}%
[hang]% shape
{\fontsize{13}{15.6}\selectfont\normalfont\bfseries\raggedright}% applied to label and text
{\color{AccentOne}\thetitle}% applied to the label only
{0.5em}% horizontal spacing between label and text
{#1}% applied before the text
[]% applied after the text

\titlespacing*{\paragraph}%
{\parindent}% left
{\parskip}% vertical space before title
{0.5em}% horizontal space after title
[]% right

\titleformat{\paragraph}%
[runin]% shape
{\normalfont\bfseries}% applied to label and text
{}% applied to the label only
{0em}% horizontal spacing between label and text
{#1.}% applied before the text
[]% applied after the text

\titlespacing*{\subparagraph}%
{2\parindent}% left
{\parskip}% vertical space before title
{0.5em}% horizontal space after title
[]% right

\titleformat{\subparagraph}%
[runin]% shape
{\normalfont\bfseries\itshape}% applied to label and text
{}% applied to the label only
{0em}% horizontal spacing between label and text
{#1.}% applied before the text
[]% applied after the text

% Section numbering depth.
\setcounter{secnumdepth}{10}

% Macros to capture section names.
\def\Chaptername{}
\let\Chaptermark\chaptermark
\def\chaptermark#1{\def\Chaptername{#1}\Chaptermark{#1}}
\def\Sectionname{}
\let\Sectionmark\sectionmark
\def\sectionmark#1{\def\Sectionname{#1}\Sectionmark{#1}}
\def\Subsectionname{}
\let\Subsectionmark\subsectionmark
\def\subsectionmark#1{\def\Subsectionname{#1}\Subsectionmark{#1}}
\def\Subsubsectionname{}
\let\Subsubsectionmark\subsubsectionmark
\def\subsubsectionmark#1{\def\Subsubsectionname{#1}\Subsubsectionmark{#1}}

% References to parts.
\newcommand{\Part}{{\color{AccentOne}Part}}
\newcommand{\Parts}{{\color{AccentOne}Parts}}
\newcommand{\pref}[1]{{\color{AccentOne}\ref{#1}}}

% References to chapters.
\newcommand{\Chapter}{{\color{AccentOne}Chapter}}
\newcommand{\Chapters}{{\color{AccentOne}Chapters}}
\newcommand{\cref}[1]{{\color{AccentOne}\ref{#1}}}

% References to sections.
\newcommand{\Section}{{\color{AccentOne}Section}}
\newcommand{\Sections}{{\color{AccentOne}Sections}}
\newcommand{\sref}[1]{{\color{AccentOne}\ref{#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARAGRAPHS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Line spacing.
\RequirePackage{setspace}
\SpacingSetting
%\setstretch{1.40} % custom

% Paragraph indentation:
% Indent first line of all paragraphs (including the first), as in IEEE style.
\let\@afterindentfalse\@afterindenttrue
% \setlength\parindent{0.5in}

% Justification.
\RequirePackage{ragged2e}
\RaggedRightParindent\parindent
\JustifyingParindent\parindent
\JustificationSetting

% Indented blocks.
\newcommand{\IndentBlock}[1]{\noindent\hangafter=0\hangindent=#1\parindent\ignorespaces}
\newcommand{\IndentHanging}{\noindent\hangafter=1\hangindent=\parindent\ignorespaces}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HEADERS AND FOOTERS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Header and footer font.
\newcommand{\UseHeaderFooterFont}{\normalfont}

% Header.
\ifnum\TypesetInDraftMode=0
\newcommand{\HeaderText}{}
\else
\newcommand{\HeaderText}{\null\hfill\color{red}{DRAFT}~\Timestamp\hfill\null}
\fi

% Empty style, for title page.
\def\ps@empty{%
\def\@oddhead{\UseHeaderFooterFont\HeaderText}%
\def\@evenhead{\UseHeaderFooterFont\HeaderText}%
\def\@oddfoot{\UseHeaderFooterFont}%
\def\@evenfoot{\UseHeaderFooterFont}%
}

% Plain style, for chapter pages.
\def\ps@plain{%
\def\@oddhead{\UseHeaderFooterFont\HeaderText}%
\def\@evenhead{\UseHeaderFooterFont\HeaderText}%
\def\@oddfoot{\UseHeaderFooterFont\hfill\thepage\hfill}%
\def\@evenfoot{\UseHeaderFooterFont\hfill\thepage\hfill}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FOOTNOTES.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Blank footnotes.
\newcommand\BlankFootnote[1]{%
\begingroup%
\renewcommand{\thefootnote}{}%
\footnotetext{#1}%
\addtocounter{footnote}{-1}%
\addtocounter{Hfootnote}{-1}%
\endgroup}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LISTS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Numbered lists in IEEE style.
% (Individual lists can be modified by redefining
% these macros inside the enumerate environment.)

% 1st level: 1), 2), 3)
\renewcommand{\theenumi}{\arabic{enumi}}
\renewcommand{\labelenumi}{\theenumi)}
% 2nd level: a), b), c)
\renewcommand{\theenumii}{\alph{enumii}}
\renewcommand{\labelenumii}{\theenumii)}
\renewcommand\p@enumii{}
% 3rd level: i), ii), iii)
\renewcommand{\theenumiii}{\roman{enumiii}}
\renewcommand{\labelenumiii}{\theenumiii)}
\renewcommand\p@enumiii{}
% 4th level: A), B), C)
\renewcommand{\theenumiv}{\Alph{enumiv}}
\renewcommand{\labelenumiv}{\theenumiv)}
\renewcommand\p@enumiv{}

% Numbered lists: Adjust spacing.
\let\oldenumerate\enumerate
\renewcommand{\enumerate}{
\oldenumerate
\setlength{\itemsep}{0pt}
\setlength{\parskip}{0pt}
\setlength{\parsep}{0pt}
}

% Itemized lists: Adjust spacing.
\let\olditemize\itemize
\renewcommand{\itemize}{
\olditemize
\setlength{\itemsep}{0pt}
\setlength{\parskip}{0pt}
\setlength{\parsep}{0pt}
}

% Definition items.
\newcommand{\DefineItem}[1]{%
\IndentBlock{1}#1\nopagebreak
\par\IndentBlock{2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FIGURES AND TABLES.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx} % To support graphics in EPS format.
\RequirePackage{longtable} % For multi-page long tables.
\RequirePackage{etoolbox} % For patching longtable captions.
\RequirePackage{multirow} % To support multi-row cells in tables.
\RequirePackage{booktabs} % For making nice tables.
\RequirePackage{array} % For better table content alignment.

% Adjust spacing between table rows.
\renewcommand*\arraystretch{1.25}

% Dashed lines in tables.
\RequirePackage{arydshln}
\def\dashvertical{;{2pt/3pt}}
\def\dashhorizontal{\hdashline[2pt/3pt]}

% Captions for figures and tables.
\newcommand{\CaptionFontSize}{\small}

\def\@figurestring{figure}
\def\@tablestring{table}
\def\@makecaption#1#2{%
\CaptionFontSize
\ifx\@captype\@figurestring
\vskip1em
\fi
\sbox\@tempboxa{{\color{AccentOne}\normalfont\bfseries\MakeUppercase{#1}\hspace{0.5em}}#2}%
\ifdim\wd\@tempboxa>\hsize
{{\color{AccentOne}\normalfont\bfseries\MakeUppercase{#1}\hspace{0.5em}}#2}%
\else
\hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
\fi
\ifx\@captype\@tablestring
\vskip1em
\fi
}

% Caption for longtables.
\setlength{\LTcapwidth}{\textwidth}

\patchcmd{\LT@makecaption}
{\sbox}
{\CaptionFontSize\singlespacing\sbox}
{}
{}

\patchcmd{\LT@makecaption}
{\vskip\baselineskip}
{\vskip1em}
{}
{}

\patchcmd{\LT@makecaption}
{\@tempboxa{#1{#2: }#3}}
{\@tempboxa{#1{{\color{AccentOne}\normalfont\bfseries\MakeUppercase{#2}\hspace{0.5em}}}#3}}
{}
{}

\patchcmd{\LT@makecaption}
{#1{#2: }#3}
{#1{{\color{AccentOne}\normalfont\bfseries\MakeUppercase{#2}\hspace{0.5em}}}#3}
{}
{}

% References to figures.
\newcommand{\Figure}{{\color{AccentOne}Figure}}
\newcommand{\Figures}{{\color{AccentOne}Figures}}
\newcommand{\fref}[1]{{\color{AccentOne}\ref{#1}}}

% References to tables.
\newcommand{\Table}{{\color{AccentOne}Table}}
\newcommand{\Tables}{{\color{AccentOne}Tables}}
\newcommand{\tref}[1]{{\color{AccentOne}\ref{#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DATE AND TIME.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{datetime2} % For dates and times.

% Timestamp.
\newcommand{\Timestamp}{{\DTMnow}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MATHEMATICS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{amsmath,amsfonts,amsbsy,amssymb,amsthm} % AMS packages.

% Indicator function "1[.]" symbol.
% Option 1: Use "\mathbf"
%\newcommand{\one}[1]{{\mathbf{1}\left[#1\right]}}
% Option 2: Use "bbold" package (install "bbold-type1" first)
\DeclareSymbolFont{bbold}{U}{bbold}{m}{n}
\DeclareSymbolFontAlphabet{\mathbbold}{bbold}
\newcommand{\one}[1]{{\mathbbold{1}\left[#1\right]}}
% Option 3: Use "dsfont" package
%\RequirePackage{dsfont}
%\newcommand{\one}[1]{{\mathds{1}\left[#1\right]}}

% Allow line breaks within math blocks.
\allowdisplaybreaks

% Prevent line breaks within math expressions.
\relpenalty=10000
\binoppenalty=10000
\sloppy

% Theorems (cf. "amsthm.sty").
\newtheoremstyle{MyPlain}%
{0.4em}% space above
{0.4em}% space below
{\itshape}% body font
{}% indent amount
{}% theorem head font
{}% punctuation after theorem head
{0.5em}% space after theorem head
{\normalfont\bfseries{\color{AccentOne}\MakeUppercase{\thmname{#1}\thmnumber{ #2}}}\thmnote{ (#3)}}% custom theorem head spec

\newtheoremstyle{MyDefinition}%
{0.4em}% space above
{0.4em}% space below
{}% body font
{}% indent amount
{}% theorem head font
{}% punctuation after theorem head
{0.5em}% space after theorem head
{\normalfont\bfseries{\color{AccentOne}\MakeUppercase{\thmname{#1}\thmnumber{ #2}}}\thmnote{ (#3)}}% custom theorem head spec

\theoremstyle{MyPlain}

\@ifundefined{chapter}
{\newtheorem{Thm:Theorem}{Theorem}[]}
{\newtheorem{Thm:Theorem}{Theorem}[chapter]}

\newtheorem{Thm:Lemma}[Thm:Theorem]{Lemma}
\newtheorem{Thm:Corollary}[Thm:Theorem]{Corollary}
\newtheorem{Thm:Claim}[Thm:Theorem]{Claim}
\newtheorem{Thm:Proposition}[Thm:Theorem]{Proposition}
\newtheorem{Thm:Conjecture}[Thm:Theorem]{Conjecture}

\theoremstyle{MyDefinition}
\newtheorem{Thm:Problem}[Thm:Theorem]{Problem}
\newtheorem{Thm:Definition}[Thm:Theorem]{Definition}
\newtheorem{Thm:Example}[Thm:Theorem]{Example}

% References to theorems, lemmas, corollaries, etc.
\newcommand{\Theorem}{{\color{AccentOne}Theorem}}
\newcommand{\Theorems}{{\color{AccentOne}Theorems}}
\newcommand{\Lemma}{{\color{AccentOne}Lemma}}
\newcommand{\Lemmas}{{\color{AccentOne}Lemmas}}
\newcommand{\Corollary}{{\color{AccentOne}Corollary}}
\newcommand{\Corollaries}{{\color{AccentOne}Corollaries}}
\newcommand{\Claim}{{\color{AccentOne}Claim}}
\newcommand{\Claims}{{\color{AccentOne}Claims}}
\newcommand{\Proposition}{{\color{AccentOne}Proposition}}
\newcommand{\Propositions}{{\color{AccentOne}Propositions}}
\newcommand{\Conjecture}{{\color{AccentOne}Conjecture}}
\newcommand{\Conjectures}{{\color{AccentOne}Conjectures}}
\newcommand{\Problem}{{\color{AccentOne}Problem}}
\newcommand{\Problems}{{\color{AccentOne}Problems}}
\newcommand{\Definition}{{\color{AccentOne}Definition}}
\newcommand{\Definitions}{{\color{AccentOne}Definitions}}
\newcommand{\Example}{{\color{AccentOne}Example}}
\newcommand{\Examples}{{\color{AccentOne}Examples}}
\newcommand{\mref}[1]{{\color{AccentOne}\ref{#1}}}

% References to equations.
%\let\origeqref=\eqref
%\def\eqref#1{{\color{AccentOne}\origeqref{#1}}}

% Proof.
\renewenvironment{proof}[1][\proofname]{%
{\par\vskip0.4em\noindent%
\normalfont\bfseries\itshape{#1:}%
\hspace{0.5em}}}%
{\nopagebreak\hspace*{\fill}~\mbox{\rule[0pt]{1.3ex}{1.3ex}}\par}

\newcommand{\qedmarker}{\nopagebreak\hspace*{\fill}~%
\mbox{\rule[0pt]{1.3ex}{1.3ex}}\par}

% Resized "align" environment.
\NewEnviron{ResizedAlign}[2]{%
\par\noindent
\resizebox{#1}{!}{
\parbox{#2}{
\begin{align}
\BODY
\end{align}}}\par}

% Resized "align*" environment.
\NewEnviron{ResizedAlign*}[2]{%
\par\noindent
\resizebox{#1}{!}{
\parbox{#2}{
\begin{align*}
\BODY
\end{align*}}}\par}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CODE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{algpseudocode} % For algorithms.

\algnewcommand{\CommentLeft}[1]{\State $\triangleright$\;\textit{#1}}
\algnewcommand{\CommentRight}[1]{\null\hfill $\triangleright$\;\textit{#1}}
\algnewcommand{\Goto}{\State \textbf{goto}\,}
\algnewcommand{\Break}{\State \textbf{break}\,}
\algnewcommand{\Stateu}{\Statex \hskip\ALG@thistlm}

% Inline code.
\newcommand{\code}[1]{\mbox{\color{DarkBlue}\texttt{#1}}}

% Code block.
\NewEnviron{CodeBlock}[1]{%
\par\noindent\ignorespaces%
\begin{oframed}%
\noindent\;\textbf{#1}
\nopagebreak\vspace{4pt}%
\hrule width \textwidth height 0.6pt depth 0pt
\vspace{4pt}%
\begin{algorithmic}[1]
\BODY
\ignorespaces%
\end{algorithmic}%
\end{oframed}%
\par}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TABLE OF CONTENTS (TOC) SETTINGS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TOC depth.
\setcounter{tocdepth}{10}

% Suppress entries in the TOC.
\newcommand{\DummyThree}[3]{}

\newcommand{\DisableTOCUpdates}{%
\let\tempaddcontentsline=\addcontentsline
\let\addcontentsline=\DummyThree}

\newcommand{\EnableTOCUpdates}{%
\let\addcontentsline=\tempaddcontentsline}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HIDDEN TEXT, TODO MARKER, SAMPLE/BLIND TEXT.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hidden text.
\newcommand{\Hide}[1]{}

% TODO marker.
\ifnum\TypesetInDraftMode=0
\newcommand{\TODO}[1]{}
\else
\newcommand{\TODO}[1]{{\color{red}\fbox{\texttt{\textbf{TODO}}}~#1}\PackageWarning{TODO:}{#1}}
\fi

% Sample/blind text.
\RequirePackage{lipsum}

\ifnum\TypesetInDraftMode=0
\renewcommand{\lipsum}[1][]{}
\fi

% End of class file.
\endinput
