% !Mode:: "TeX:UTF-8"

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gdufe_master_thesis}[2025/05/17 Master Thesis template for GDUFE v0.4.1]

% ---------声明变量-------------
\newcommand{\masterClass}{学术} % 默认值
\newcommand{\masterClassValue}{academic} % 默认值
\newcommand{\academic}{academic} % 用于判断是否为学硕
% ---------选项设置-------------
\DeclareOption{class=academic}{\renewcommand{\masterClass}{学术}\renewcommand{\masterClassValue}{academic}}
\DeclareOption{class=professional}{\renewcommand{\masterClass}{专业}\renewcommand{\masterClassValue}{professional}}
\ExecuteOptions{class=academic} % 设置默认选项

\newcommand{\type}{thesis}
% 论文格式
\DeclareOption{thesis}{{\renewcommand{\type}{thesis}}}
% 开题报告格式
\DeclareOption{proposal}{{\renewcommand{\type}{thesis}}}


\newif\ifprint
\printfalse
\DeclareOption{forprint}{\printtrue}

% 消除 fix diff 需要的选项
\PassOptionsToPackage{no-math}{fontspec}

% 捕获未声明的选项并传递给 ctexbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}

\ProcessOptions\relax
% 加载ctexbook类
\LoadClass[
    zihao=-4,
    a4paper,
    openany]{ctexbook}

%%------------------------调用宏包-----------------------------------
\RequirePackage{amsmath,amssymb,mathrsfs}
% \RequirePackage{amsthm}
\RequirePackage[amsmath,thmmarks]{ntheorem}
\RequirePackage{graphicx}                 % 图形
\RequirePackage{float}
\RequirePackage[labelsep=quad]{caption} %% 序号之后空一格写标题
\RequirePackage{subcaption}
\RequirePackage{color,xcolor}             %支持彩色
\RequirePackage{url}
\RequirePackage{enumerate}
\RequirePackage{etoolbox}
\RequirePackage{pdfpages}
\RequirePackage{fixdif}
\RequirePackage{tikz}
\RequirePackage{ulem}
% \RequirePackage{siunitx}
\RequirePackage{booktabs}
\RequirePackage{listings}
\RequirePackage{setspace}
\RequirePackage[titles]{tocloft}
% \RequirePackage{zhlineskip}
\RequirePackage{changepage}

%------------------------ Page layout ----------------------------------
\RequirePackage[top=2.54truecm,
    bottom=2.54truecm,
    left=3truecm,
    right=2.2truecm,
    paper=a4paper,
    headsep=1.04truecm,
    footskip=0.79truecm,
    headheight=16pt]{geometry}    % 页面设置%

\RequirePackage{fancyhdr}
\RequirePackage[colorlinks,linkcolor=red,anchorcolor=blue,citecolor=green,bookmarksnumbered=true]{hyperref}

\hypersetup{pdfencoding=auto}  %%% 邓东升修改
\ifprint
    \hypersetup{hidelinks}
\else
    \hypersetup{citecolor=magenta,linkcolor=blue}
\fi

%% ------------------------ 字体设置 -----------------------------------
\defaultfontfeatures{Path = fonts/}
% 设置英文字体
\setmainfont[BoldFont = timesbd.ttf,
    ItalicFont = timesi.ttf,
    BoldItalicFont = timesbi.ttf]{times.ttf}
% 设置中文字体
\setCJKmainfont{simsun.ttc}
\setCJKsansfont{simhei.ttf}
\setCJKmonofont{simfang.ttf}

\setCJKfamilyfont{zhsong}{simsun.ttc}
\setCJKfamilyfont{zhhei}{simhei.ttf}
\setCJKfamilyfont{zhfs}{simfang.ttf}
\setCJKfamilyfont{zhkai}{simkai.ttf}


% 设置行距
\apptocmd{\heiti}{\setlength{\baselineskip}{20pt}}{}{}
\apptocmd{\songti}{\setlength{\baselineskip}{20pt}}{}{}
\apptocmd{\fangsong}{\setlength{\baselineskip}{20pt}}{}{}
\apptocmd{\kaishu}{\setlength{\baselineskip}{20pt}}{}{}
\apptocmd{\bfseries}{\setlength{\baselineskip}{20pt}}{}{}

\let\orig@zihao\zihao
% 设置 \zihao 命令后面自动20pt行距
\renewcommand{\zihao}[1]{%
    \orig@zihao{#1}% 执行原始的字号设置
    \setlength{\baselineskip}{20pt}\selectfont % 设置行间距
}

% 设置正文页眉页脚样式，其余样式用plain 或empty
\fancypagestyle{master-mainmatter}
{
\fancyhead{}                                    % clear all header fields
\fancyhead[L]{\zihao{5}广东财经大学{\masterClass}学位硕士论文}
\fancyhead[R]{\zihao{5} \ctitle}
\renewcommand{\headrulewidth}{0.1pt}
\fancyfoot{}                                    % clear all footer fields
\fancyfoot[C]{\thepage}
}


%%-----------------------Equation & Theorems -----------------------------------
\renewcommand{\theequation}{\thechapter-\arabic{equation}} % 公式编号格式

\theoremstyle{plain}
\theoremheaderfont{\heiti}
\theorembodyfont{\songti}
\theoremindent 0em
\theorempreskip{0pt}
\theorempostskip{0pt}
\theoremnumbering{arabic}
\newtheorem{theorem}{\hspace{2em}定理}[section]
\newtheorem{definition}{\hspace{2em}定义}[section]
\newtheorem{lemma}{\hspace{2em}引理}[section]
\newtheorem{corollary}{\hspace{2em}推论}[section]
\newtheorem{property}{\hspace{2em}性质}[section]
\newtheorem{axiom}{\hspace{2em}公理}[section]
\newtheorem{example}{\hspace{2em}例}[section]
\newtheorem{remark}{\hspace{2em}注}[section]


\theoremstyle{nonumberplain}
\theoremheaderfont{\heiti}
\theorembodyfont{\normalfont \rm \songti}
\theoremindent 0em
\theoremseparator{:\hspace{1em}}
\theoremsymbol{$\square$}
\newtheorem{proof}{\hspace{2em}证明}[section]

%%%%%%%-------------------------------------------------
%%%===  suppress extra inter-line spacing in \list environments
\makeatletter \setlength\partopsep{0pt}
\def\@listI{\leftmargin\leftmargini
    \parsep 0pt
    \topsep \parsep
    \itemsep \parsep}
\@listI
\def\@listii {\leftmargin\leftmarginii
    \labelwidth\leftmarginii
    \advance\labelwidth-\labelsep
    \parsep    \z@ \@plus\z@  \@minus\z@
    \topsep    \parsep
    \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
    \labelwidth\leftmarginiii
    \advance\labelwidth-\labelsep
    \parsep    \z@ \@plus\z@  \@minus\z@
    \topsep    \parsep
    \itemsep   \parsep}
\def\@listiv{\leftmargin\leftmarginiv
    \labelwidth\leftmarginiv
    \advance\labelwidth-\labelsep
    \parsep    \z@ \@plus\z@  \@minus\z@
    \topsep    \parsep
    \itemsep   \parsep}
\def\@listv{\leftmargin\leftmarginv
    \labelwidth\leftmarginv
    \advance\labelwidth-\labelsep
    \parsep    \z@ \@plus\z@  \@minus\z@
    \topsep    \parsep
    \itemsep   \parsep}
\def\@listvi{\leftmargin\leftmarginvi
    \labelwidth\leftmarginvi
    \advance\labelwidth-\labelsep
    \parsep    \z@ \@plus\z@  \@minus\z@
    \topsep    \parsep
    \itemsep   \parsep}
%
% Change default margins for \list environments
\setlength\leftmargini   {2\ccwd} \setlength\leftmarginii
{\leftmargini} \setlength\leftmarginiii {\leftmargini}
\setlength\leftmarginiv  {\leftmargini} \setlength\leftmarginv
{\ccwd} \setlength\leftmarginvi  {\ccwd} \setlength\leftmargin
{\leftmargini} \setlength\labelsep      {.5\ccwd}
\setlength\labelwidth    {\leftmargini}
%
\setlength\listparindent{2\ccwd}
% Change \listparindent to 2\ccwd in \list
\def\list#1#2{\ifnum \@listdepth >5\relax \@toodeep
    \else \global\advance\@listdepth\@ne \fi
    \rightmargin \z@ \listparindent2\ccwd \itemindent \z@
    \csname @list\romannumeral\the\@listdepth\endcsname
    \def\@itemlabel{#1}\let\makelabel\@mklab \@nmbrlistfalse #2\relax
    \@trivlist
    \parskip\parsep \parindent\listparindent
    \advance\linewidth -\rightmargin \advance\linewidth -\leftmargin
    \advance\@totalleftmargin \leftmargin
    \parshape \@ne \@totalleftmargin \linewidth
    \ignorespaces}

\makeatother

%%%%%%%%listings 设置%%%%%%%%%%%%
% \usepackage{textcomp}
\definecolor{listinggray}{gray}{0.9}
\definecolor{lbcolor}{rgb}{0.9,0.9,0.9}
\lstset{
    backgroundcolor=\color{white},
    tabsize=4,
    rulecolor=,
    language=TeX,
    basicstyle=\scriptsize,
    upquote=true,
    aboveskip={\baselineskip},
    columns=fixed,
    showstringspaces=false,
    extendedchars=true,
    breaklines=true,
    prebreak = \raisebox{0ex}[0ex][0ex]{\ensuremath{\hookleftarrow}},
    frame=single,
    showtabs=false,
    showspaces=false,
    showstringspaces=false,
    identifierstyle=\ttfamily,
    keywordstyle=\color[rgb]{0,0,1},
    commentstyle=\color[rgb]{0.133,0.545,0.133},
    stringstyle=\color[rgb]{0.627,0.126,0.941},
}
%---------------------------------------------------

%%% ---- 图表标题设置 ----- %%%%
\captionsetup[figure]{%
    format=plain,
    font={bf,small},
    textfont={bf},
}  %
\renewcommand{\figurename}{\bfseries \zihao{5} \songti 图}
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}

\captionsetup[table]{%
    format=plain,
    font={bf,small},
    skip=0pt}
\renewcommand{\tablename}{\bfseries \zihao{5} \songti 表}
\renewcommand{\thetable}{\thechapter-\arabic{table}}
\AtBeginEnvironment{tabular}{%
    \zihao{5}
}


%%% ------ 目录设置 ------- %%%%
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{4}

% \setlength{\cftaftertoctitleskip}{40pt}

\renewcommand{\cfttoctitlefont}{}
% \renewcommand{\cftaftertoctitle}{\hfill}
\ctexset{contentsname={\heiti\ziju{2} 目录}}

\renewcommand{\cftchapfont}{\songti\zihao{-4}}       % 章标题
\renewcommand{\cftsecfont}{\songti\zihao{-4}}        % 节标题
\renewcommand{\cftsubsecfont}{\songti\zihao{-4}}     % 条标题
\renewcommand{\cftchappagefont}{\songti\zihao{-4}}    % 章页码
\renewcommand{\cftsecpagefont}{\songti\zihao{-4}}    % 节页码
\renewcommand{\cftsubsecpagefont}{\songti\zihao{-4}} % 条页码

% 不额外空行
\setlength{\cftbeforechapskip}{0pt}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}

% 设置缩进
\setlength{\cftchapindent}{0pt} % chapter 不缩进
\setlength{\cftsecindent}{0pt} % section 不缩进
\setlength{\cftsubsecindent}{0pt} % subsection 不缩进

% 点线设置
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}


%------------------------ Abstract & Keywords -------------------------
\newcommand\cnkeywords[1]{ {\heiti\zihao{-4}\cnkeywordsname: }\songti\zihao{-4}#1}
\newcommand\cnkeywordsname{关键词}
\newcommand\enkeywords[1]{{\noindent\bfseries\zihao{-4}\enkeywordsname: }\zihao{-4}#1}
\newcommand\enkeywordsname{Key Words}

% \heiti \ziju{1}
\newenvironment{cnabstract}{%
    \chapter[摘要]{\heiti\ziju{1}摘要\the\baselineskip}
    \zihao{-4}
    }
    {\newline
    \par}


\newenvironment{enabstract}{%
    \chapter[ABSTRACT]{\bfseries ABSTRACT\the\baselineskip}
    \zihao{-4}
    \noindent}
    {\newline\par}

%% -----frontmatter mainmatter appendix 设置 使得自动调整章节格式-----
\apptocmd{\frontmatter}{
    \pagenumbering{Roman}
    \pagestyle{plain}
    \ctexset{
        chapter={
          format={\centering\zihao{-2}},
          pagestyle={plain},
          afterskip={2\baselineskip},
          beforeskip={0pt}
         }
    }
}{}{}

\apptocmd{\mainmatter}{
    \pagestyle{master-mainmatter}
    \ctexset{
        chapter={
          format={\zihao{3}\heiti\raggedright},
          pagestyle={master-mainmatter},
          afterskip={1\baselineskip},
          beforeskip={0pt},
          number={\arabic{chapter}},
          name={,},
          aftername={\quad}
         },
        section={
          format={\zihao{-3}\heiti\raggedright},
          afterskip={6pt},
          beforeskip={6pt},
          aftername={\quad}
         },
        subsection={
                format={\zihao{4}\heiti\raggedright},
                afterskip={3pt},
                beforeskip={3pt},
                aftername={\quad}
            },
        subsubsection={
                format={\zihao{-4}\heiti\raggedright},
                afterskip={0pt},
                beforeskip={0pt},
                aftername={\quad}
            }
    }
}{}{}


% \apptocmd{\appendix}{\ctexset{chapter={pagestyle={plain}}}
% }{}{}


%% 设置清除双面打印时的空白页
\makeatletter
\def\cleardoublepage{%
    \clearpage
    \if@twoside
        \ifodd\c@page
            % 当前是奇数页，不插空白页
        \else
            \hbox{}%
            \thispagestyle{empty}%
            \newpage
            \if@twocolumn\hbox{}\newpage\fi
        \fi
    \fi
}
\makeatother

% 相关信息宏定义
\newtoks{\etitle}
\newtoks{\supervisor}
\newtoks{\major}
\newtoks{\studentid}
\newtoks{\EnterDate}
\newtoks{\SubmitDate}
\newtoks{\DefenseDate}
\newtoks{\SignDate}
\newtoks{\CoverPageDate}

\makeatletter
\newcommand{\cname}{\@author}
\newcommand{\ctitle}{\@title}
\makeatother


\newcommand{\infoTable}{
    \ifx\masterClassValue\academic{
        \renewcommand{\arraystretch}{1.5}
        \begin{tabular}{ll}
            \makebox[3.5cm][s]{\zihao{4}专业 名 称}                         & \underline{\makebox[5.75cm][c]{\zihao{4}\the\major}}     \\%\hline
            \makebox[3.5cm][s]{\zihao{4}学 位 申 请 人}                 & \underline{\makebox[5.75cm][c]{\zihao{4}\cname}}         \\%\hline
            \makebox[3.5cm][s]{\zihao{4}导 师 姓 名 及 职 称} & \underline{\makebox[5.75cm][c]{\zihao{4}\the\supervisor}}    \\%\hline
            \makebox[3.5cm][s]{\zihao{4}学 号}                                         & \underline{\makebox[5.75cm][c]{\zihao{4}\the\studentid}} \\%\hline
            \makebox[3.5cm][s]{\zihao{4}入 学 时 间}                         & \underline{\makebox[5.75cm][c]{\zihao{4}\the\EnterDate}} \\%\hline
        \end{tabular}
    }\else
    {
        \renewcommand{\arraystretch}{1.5}
        \begin{tabular}{ll}
            %\hline
            \makebox[3.5cm][s]{专 业 学 位 名 称}                         & \underline{\makebox[5.75cm][c]{\the\major}}     \\
            \makebox[3.5cm][s]{学 位 申 请 人}                 & \underline{\makebox[5.75cm][c]{\cname}}         \\
            \makebox[3.5cm][s]{校内导师} & \underline{\makebox[5.75cm][c]{\the\supervisor}}    \\
            \makebox[3.5cm][s]{校外导师} & \underline{\makebox[5.75cm][c]{\the\supervisor}}    \\
            \makebox[3.5cm][s]{学 号}                                         & \underline{\makebox[5.75cm][c]{\the\studentid}} \\
            \makebox[3.5cm][s]{入 学 时 间}                         & \underline{\makebox[5.75cm][c]{\the\EnterDate}} \\
        \end{tabular}
    }
    \fi}

%%=====latex 编写的封面。由于要插入的签名过多，没想好解决办法，现处于放弃状态，改为word生成pdf后插入===
\newcommand{\makecover}{%
    \begin{titlepage}
        \thispagestyle{empty}%
        \newgeometry{top=3.7truecm,bottom=3.5truecm,left=2.8truecm,right=2.6truecm}
        {\noindent\fangsong\zihao{-4}\bfseries 分类号： UDC\\[-3pt]
                密\quad 级：\\[-3pt]
                编\quad 号：
        }
        \vspace*{0.4cm}
        \begin{center} \leavevmode
            {%
                \begin{minipage}{0.71\textwidth}
                    \centering
                    \includegraphics[width=\textwidth]{gdufelogo.jpg}
                \end{minipage}
            }
            \par\vspace*{2mm} %插入空白
            \rule{0.9\textwidth}{0.5pt}
            \par\vspace*{2mm}
            {\heiti \fontsize{48pt}{\baselinestretch} {\masterClass 学位硕士论文}}\\
            \vspace{60pt}
            {\heiti \zihao{-2} \ctitle}\\
            {\heiti \zihao{-2} \the\etitle \par}
            % \vspace*{2em}
            \vfill\vfill\vfill
            {\fangsong \infoTable}
            \vfill
            {\fangsong\zihao{3} \bfseries \the\DefenseDate}
            \vspace{1em}
        \end{center}
    \end{titlepage}
    \restoregeometry
}

% %%========扉页========================%%
\newcommand\maketitlepage{%
    \newpage
    \thispagestyle{empty}
    \newgeometry{top=3.7truecm,bottom=3.5truecm,left=2.8truecm,right=2.6truecm}
    % \vspace*{0.75cm}
    \begin{center}
        {\songti \zihao{0} \masterClass 学位硕士论文}
        \par\vfill
        {\heiti \zihao{-2} \ctitle \par \the\etitle}
        \par\vfill
        {
        \heiti\zihao{4}\renewcommand{\arraystretch}{1.5}
            \hspace*{2em}\infoTable
            \par\vfill
            \hspace*{2em}
            \begin{tabular}{lr}
                \makebox[4.25cm][s]{\zihao{4}论文提交时间} & \makebox[4.75cm][r]{\zihao{4}\the\SubmitDate}  \\
                \makebox[4.25cm][s]{\zihao{4}论文答辩时间} & \makebox[4.75cm][r]{\zihao{4}\the\DefenseDate} \\
            \end{tabular}
            \par\vfill
            \hspace*{2em}
            \begin{tabular}{lr}
                \makebox[4.25cm][s]{\zihao{4}答辩委员会主席} & \underline{\makebox[4.75cm][s]{}} \\
                \makebox[4.25cm][s]{\zihao{4}答辩委员会委员} & \underline{\makebox[4.75cm][s]{}} \\
                \makebox[4.25cm][s]{ }       & \underline{\makebox[4.75cm][s]{}} \\
            \end{tabular}
        }
        \vfill
    \end{center}
    \restoregeometry
}

% %%=====原创性声明========================%%
\newcommand\makeclaim{
    \newpage
    \thispagestyle{empty}
    \newgeometry{top=3.7truecm,bottom=3.5truecm,left=2.8truecm,right=2.6truecm}
    \begin{center}
        \vspace*{0.8cm}
        {\heiti \zihao{3} \bfseries 广东财经大学学位论文原创性声明}
    \end{center}
    \vspace{0.72cm}

    \begin{spacing}{2.0}
        \fangsong \zihao{4}
        本人郑重声明：所呈交的学位论文是本人在导师的指导下独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本论文不含任何其他个人或集体已经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。因本学位论文引起的法律后果完全由本人承担。
        \newline
        \begin{tabular}{rr}
            \zihao{4}
            \makebox[11cm][r]{学位论文作者签名:} & \makebox[3.75cm][l]{ }             \\
            \zihao{4}
            \makebox[11cm][r]{签字日期:}     & \makebox[3.75cm][l]{\zihao{4} \the\SignDate} \\
        \end{tabular}
    \end{spacing}
    \vspace{1em}
    \begin{spacing}{1.5}
        \begin{center}
            {\heiti \bfseries \zihao{3} 广东财经大学学位论文版权使用授权书}
        \end{center}

        \fangsong \zihao{4}
        本学位论文作者完全了解广东财经大学有关保留、使用学位论文的规定，有权保留并向国家有关部门或机构送交论文的纸质版和电子版，允许论文被查阅和借阅。本人授权广东财经大学可以将学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存、汇编学位论文。

        （保密的学位论文在解密后适用本授权书）
    \end{spacing}
    \vspace*{1em}
    {\fangsong \zihao{4} \noindent
        \makebox[9.5cm][l]{学位论文作者签名：} \makebox[5truecm][l]{导师签名：}\\
        \makebox[9.5cm][l]{签字日期：\the\SignDate} \makebox[5truecm][l]{签字日期：\the\SignDate}
    }
    \restoregeometry
}


%%%%%%% 开题报告内容 %%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\graphicspath{{figures/}}        % 图片文件路径
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \allowdisplaybreaks
% \setlength{\baselineskip}{20pt}\selectfont
\endlinechar `\^^M
\endinput
