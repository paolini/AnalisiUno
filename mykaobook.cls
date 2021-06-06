%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kaobook
% LaTeX Class
% Version 0.9.6 (2021/03/23)
%
% This template originates from:
% https://www.LaTeXTemplates.com
%
% For the latest template development version and to make contributions:
% https://github.com/fmarotta/kaobook
%
% Authors:
% Federico Marotta (federicomarotta@mail.com)
% Based on the doctoral thesis of Ken Arroyo Ohori (https://3d.bk.tudelft.nl/ken/en)
% and on the Tufte-LaTeX class.
% Modified for LaTeX Templates by Vel (vel@latextemplates.com)
%
% License:
% LPPL (see included MANIFEST.md file)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mykaobook}[2021/03/23 v0.9.6 kaobook]
\newcommand{\@baseclass}{scrbook} % Base class name

\RequirePackage{kvoptions} % Manage class key-value options

\SetupKeyvalOptions{
    family = kao,
    prefix = kao@
}

% Set the default options
\PassOptionsToClass{a4paper}{\@baseclass}
\PassOptionsToClass{fontsize=10pt}{\@baseclass}
\PassOptionsToClass{parskip=half}{\@baseclass}
\PassOptionsToClass{headings=optiontoheadandtoc}{\@baseclass}

% Define kao-specific options
\DeclareStringOption[1]{secnumdepth}
\DeclareStringOption[1]{pagewidth}
\DeclareStringOption[1]{pageheight}

% Pass through any other options to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\@baseclass}} 

\ProcessKeyvalOptions*
\ProcessOptions\relax % Process the options

\LoadClass{\@baseclass} % Load the base class
\RequirePackage{mykao} % Load the code common to all classes

\renewcommand{\autodot}{} % rimuovi i punti dopo le numerazioni delle sezioni etc...
%----------------------------------------------------------------------------------------
%	FRONT-, MAIN-, BACK- MATTERS BEHAVIOUR
%----------------------------------------------------------------------------------------

% Front matter
\let\oldfrontmatter\frontmatter % Store the old command
\renewcommand{\frontmatter}{%
	\oldfrontmatter% First of all, call the old command
	\pagestyle{plain.scrheadings}% Use a plain style for the header and the footer
	\pagelayout{wide}% Use a wide page layout
	\setchapterstyle{plain} % Choose the default chapter heading style
	% \sloppy % Required to better break long lines
}

%------------------------------------------------

% Main matter
\let\oldmainmatter\mainmatter % Store the old command
\renewcommand{\mainmatter}{%
	% Add a blank page before the main matter if the front matter has an
	% odd number of pages
    \Ifthispageodd{%
	  \afterpage{\blankpage}%
	}{}%
	\oldmainmatter% Call the old command
	\pagestyle{scrheadings}% Use a fancy style for the header and the footer
	\pagelayout{margin}% Use a 1.5 column layout
	\setchapterstyle{kao} % Choose the default chapter heading style
}

%------------------------------------------------

% Appendix
\let\oldappendix\appendix% Store the old command
\renewcommand{\appendix}{%
	\oldappendix% Call the old command
	\bookmarksetup{startatroot}% Reset the bookmark depth
}

%------------------------------------------------

% Back matter
\let\oldbackmatter\backmatter% Store the old command
\renewcommand{\backmatter}{%
	\oldbackmatter% Call the old command
	\bookmarksetup{startatroot}% Reset the bookmark depth
	\pagestyle{plain.scrheadings}% Use a plain style for the header and the footer
	\pagelayout{wide}% Use a wide page layout
	\setchapterstyle{kao} % Choose the default chapter heading style
}

%----------------------------------------------------------------------------------------
%	CHAPTER HEADING STYLES
%----------------------------------------------------------------------------------------

\DeclareDocumentCommand{\setchapterstyle}{m}{%
	\ifthenelse{\equal{plain}{#1}}{\chapterstyleplain}{}
	\ifthenelse{\equal{lines}{#1}}{\chapterstylelines}{}
	\ifthenelse{\equal{kao}{#1}}{\chapterstylekao}{}
}

% The default definition in KOMA script
\DeclareDocumentCommand{\chapterstyleplain}{}{%
	\renewcommand{\chapterlinesformat}[3]{%
		\@hangfrom{##2}{##3}}
	\renewcommand*{\chapterformat}{%
		\mbox{\chapappifchapterprefix{\nobreakspace}\thechapter%
		\autodot\IfUsePrefixLine{}{\enskip}}}

	\RedeclareSectionCommand[beforeskip=0cm,afterskip=10\vscale]{chapter}
	\setlength{\mtocshift}{-1\vscale}
}


% The Kao style
\DeclareDocumentCommand{\chapterstylekao}{}{%
	\renewcommand*{\chapterformat}{%
		\mbox{\chapappifchapterprefix{\nobreakspace}\scalebox{2.85}{\thechapter%\autodot
		}}%
	}%
	\renewcommand\chapterlinesformat[3]{%
		\vspace{3.5\vscale}%
		\smash{\makebox[0pt][l]{%
			\parbox[b]{\textwidth}{\flushright{##3}}%
			\makebox[\marginparsep][c]{\rule[-2\vscale]{0pt}{1.4\vscale+\f@size mm}}%
			\parbox[b]{\marginparwidth}{##2}%
		}}%
	}%
	\RedeclareSectionCommand[beforeskip=0cm,afterskip=10\vscale]{chapter}%
    \setlength{\mtocshift}{-3\vscale}%
}


%----------------------------------------------------------------------------------------
%	FONTS AND STYLES
%----------------------------------------------------------------------------------------

% Set KOMA fonts for book-specific elements
\addtokomafont{part}{\normalfont\scshape\bfseries}
\addtokomafont{partentry}{\normalfont\scshape\bfseries}
\addtokomafont{chapter}{\normalfont\bfseries}
\addtokomafont{chapterentry}{\normalfont\bfseries}

% Set KOMA fonts for elements common to all classes
\addtokomafont{section}{\normalfont\bfseries}
\addtokomafont{subsection}{\normalfont\bfseries}
\addtokomafont{subsubsection}{\normalfont\bfseries}
\addtokomafont{paragraph}{\normalfont\bfseries}
\setkomafont{descriptionlabel}{\normalfont\bfseries}

%----------------------------------------------------------------------------------------
%	TOC, LOF & LOT
%----------------------------------------------------------------------------------------

\PassOptionsToClass{toc=listof}{\@baseclass}
\PassOptionsToClass{toc=index}{\@baseclass}
\PassOptionsToClass{toc=bibliography}{\@baseclass}

%----------------------------------------------------------------------------------------
%	NUMBERING
%----------------------------------------------------------------------------------------

\setcounter{secnumdepth}{\kao@secnumdepth} % Set section numbering depth

\counterwithin*{sidenote}{chapter} % Uncomment to reset the sidenote counter at each chapter
%\counterwithout{sidenote}{chapter} % Uncomment to have one sidenote counter for the whole document
