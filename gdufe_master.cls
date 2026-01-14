% !Mode:: "TeX:UTF-8"

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gdufe_master}[2025/12/29 Master Thesis template for GDUFE v0.5.4]

% ---------声明变量-------------
\newcommand{\masterClass}{学术}
% ---------选项设置-------------
\DeclareOption{class=academic}{\renewcommand{\masterClass}{学术}}
\DeclareOption{class=professional}{\renewcommand{\masterClass}{专业}}

\newcommand{\type}{thesis}
% % 论文格式
\DeclareOption{type=thesis}{\renewcommand{\type}{thesis}}
% % 开题报告格式
\DeclareOption{type=proposal}{\renewcommand{\type}{proposal}}
\ExecuteOptions{type=thesis}

\newif\ifprint
\printfalse
\DeclareOption{forprint}{\printtrue}

% 消除 fix diff 需要的选项
\PassOptionsToPackage{no-math}{fontspec}

% 捕获未声明的选项并传递给 ctexbook
% 根据类型加载ctexbook类不同的基础字号
\ExplSyntaxOn
\str_case:Nn \type {
    {thesis}{
            \PassOptionsToClass{zihao=-4,a4paper,openany}{ctexbook}
            \DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
        }
        {proposal}{
            \PassOptionsToClass{zihao=5,a4paper,openany}{ctexart}
            \DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
        }
}
\ProcessOptions\relax
\str_case:Nn \type {
    {thesis}{
            \LoadClass{ctexbook}
        }
        {proposal}{
            \LoadClass{ctexart}
        }
}
\ExplSyntaxOff

%% tag: 宏包
%% 排版与页面控制
\RequirePackage{lmodern}
\RequirePackage[titles]{tocloft}
\RequirePackage{changepage}
\RequirePackage{setspace}
\RequirePackage{pifont}   % 提供 \ding 命令
\RequirePackage[perpage,symbol*]{footmisc}
% \RequirePackage{fix-cm}
%% 编程
\RequirePackage{etoolbox}
\RequirePackage{expl3}
%% 数学相关
\RequirePackage{amsmath,amssymb}
% \RequirePackage{amsmath,amssymb,mathscr}
\RequirePackage[scr=rsfs]{mathalpha}
\RequirePackage{amsthm,thmtools}
% \RequirePackage[thmtools-compat]{keytheorems}
% \RequirePackage[amsmath,thmmarks]{ntheorem}
\RequirePackage{fixdif}
%% 图表
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{multirow}
\RequirePackage{makecell}
\RequirePackage{tabularx}
\RequirePackage{graphicx} % 图形
\RequirePackage[labelsep=quad]{caption} %% 序号之后空一格写标题
\RequirePackage{subcaption}
\RequirePackage{float}
%% 列表
% \RequirePackage{enumerate}
\RequirePackage{enumitem}
%% 彩色
\RequirePackage{color,xcolor} %支持彩色
%% pdf插入
\RequirePackage{pdfpages}
%% 绘图
\RequirePackage{tikz}
\RequirePackage[most]{tcolorbox}
%% 代码
\RequirePackage{listings}
\RequirePackage{verbatim}
%% 其他
\RequirePackage{lipsum}

%% tag: 页面布局: 页边距、页眉页脚高度
\ExplSyntaxOn
\str_case:Nn \type {
    {thesis}{\RequirePackage[top=2.54truecm,
                bottom=2.54truecm,
                left=3truecm,
                right=2.2truecm,
                paper=a4paper,
                headsep=1.04truecm,
                footskip=0.79truecm,
                headheight=16pt]{geometry}}
        {proposal}{\RequirePackage[top=2.54truecm,
                bottom=2.54truecm,
                left=2.6truecm,
                right=2.6truecm,
                headsep=1.04truecm,
                footskip=0.79truecm,
                headheight=16pt]{geometry}}
}{}{}
\ExplSyntaxOff
\RequirePackage{fancyhdr}
\RequirePackage[colorlinks,linkcolor=blue,anchorcolor=blue,citecolor=blue,bookmarksnumbered=true]{hyperref}
\hypersetup{pdfencoding=auto}
\ifprint
    \hypersetup{hidelinks}
\fi
%% 智能引用要修改的东西有点多，咕咕了
% \RequirePackage{cleveref}

\AtBeginDocument{%
    \setlength{\baselineskip}{20pt} \selectfont
    \raggedbottom
}

%% tag: 字体
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


%% tag: 行距
% \apptocmd{\heiti}{\setlength{\baselineskip}{20pt}}{}{}
% \apptocmd{\songti}{\setlength{\baselineskip}{20pt}}{}{}
% \apptocmd{\fangsong}{\setlength{\baselineskip}{20pt}}{}{}
% \apptocmd{\kaishu}{\setlength{\baselineskip}{20pt}}{}{}
% \apptocmd{\bfseries}{\setlength{\baselineskip}{20pt}}{}{}

%% tag: 字号
% 设置 \zihao 命令后面自动20pt行距
\let\origzihao=\zihao
\renewcommand{\zihao}[1]{%
    \origzihao{#1}% 执行原始的字号设置
    \setlength{\baselineskip}{20pt}\selectfont % 设置行间距
}

%% tag: 页眉页脚样式
\fancypagestyle{master-thesis-mainmatter}
{
\fancyhead{}                                    % clear all header fields
\fancyhead[L]{\zihao{5}广东财经大学{\masterClass}学位硕士论文}
\fancyhead[R]{\zihao{5} \ctitle}
\renewcommand{\headrulewidth}{0.1pt}
\fancyfoot{}                                    % clear all footer fields
\fancyfoot[C]{\thepage}
}

\fancypagestyle{master-proposal-style}
{
    \fancyhead{}
    \fancyfoot{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[R]{\thepage}
}


%% tag: 公式定理
\ExplSyntaxOn

%----------------------公式------------------------
\str_case:Nn \type {
    {thesis}{
        \renewcommand{\theequation}{\thechapter-\arabic{equation}} % 公式编号格式
    }
}

%------------------------定理----------------------
% 1. 全局配置变量
%------------------------------------------------
\tl_new:N \g_thm_counter_layer_tl
\tl_new:N \g_thm_counter_mode_tl

\tl_gset:Nn \g_thm_counter_layer_tl { none }
\tl_gset:Nn \g_thm_counter_mode_tl  { shared }

%------------------------------------------------
% 2. l3keys 用户接口
%------------------------------------------------
\keys_define:nn { theorem }
  {
    counter-layer .choice:,
    counter-layer / none        .code:n =
      { \tl_gset:Nn \g_thm_counter_layer_tl { none } },
    counter-layer / chapter     .code:n =
      { \tl_gset:Nn \g_thm_counter_layer_tl { chapter } },
    counter-layer / section     .code:n =
      { \tl_gset:Nn \g_thm_counter_layer_tl { section } },
    counter-layer / subsection  .code:n =
      { \tl_gset:Nn \g_thm_counter_layer_tl { subsection } },

    counter-mode .choice:,
    counter-mode / shared     .code:n =
      { \tl_gset:Nn \g_thm_counter_mode_tl { shared } },
    counter-mode / seperated  .code:n =
      { \tl_gset:Nn \g_thm_counter_mode_tl { separated } },
  }

\NewDocumentCommand \SetupTheorem { m }
  {
    \keys_set:nn { theorem } { #1 }
  }

%------------------------------------------------
% 3. 定理样式（替代 ntheorem）
%------------------------------------------------
\declaretheoremstyle[
  headfont=\bfseries \zihao{-4},
  bodyfont=\zihao{-4},
  spaceabove=0pt,
  spacebelow=0pt,
  headpunct= ,
  headindent = 2\ccwd,
  postheadspace = 1\ccwd,
  notefont = \bfseries,
  qed = ,
]{thmstyle-plain}

%------------------------------------------------
% 4. 名称映射
%------------------------------------------------
\cs_new:Npn \thm_name:n #1
  {
    \str_case:nn { #1 }
      {
        { theorem }    { 定理 }
        { definition } { 定义 }
        { lemma }      { 引理 }
        { corollary }  { 推论 }
        { property }   { 性质 }
        { axiom }      { 公理 }
        { example }    { 例 }
        { remark }     { 注 }
      }
  }

%------------------------------------------------
% 5. 声明定理环境的工具函数
%------------------------------------------------
% #1 = env name
% #2 = sibling (为空表示主计数器)
% #3 = style
\cs_new_protected:Npn \thm_declare:nnn #1 #2 #3
  {
    \tl_if_blank:nTF { #2 }
      {
        % 主计数器
        \tl_if_eq:NnTF \g_thm_counter_layer_tl { none }
          {
            \declaretheorem[
              style = #3,
              name  = \thm_name:n{#1},
            ]{#1}
          }
          {
            \declaretheorem[
              style = #3,
              name  = \thm_name:n{#1},
              numberwithin = \g_thm_counter_layer_tl,
            ]{#1}
          }
      }
      {
        % 共享计数器
        \declaretheorem[
          style   = #3,
          name    = \thm_name:n{#1},
          sibling = #2,
        ]{#1}
      }
  }

%------------------------------------------------
% 6. 主入口：生成所有定理环境
%------------------------------------------------
\cs_new_protected:Npn \GenerateTheoremEnvs
  {
    \tl_if_eq:NnTF \g_thm_counter_mode_tl { shared }
      {
        % plain 风格（共享 theorem）
        \thm_declare:nnn { theorem }    { }       { thmstyle-plain }
        \thm_declare:nnn { definition } { theorem }{ thmstyle-plain }
        \thm_declare:nnn { lemma }      { theorem }{ thmstyle-plain }
        \thm_declare:nnn { corollary }  { theorem }{ thmstyle-plain }
        \thm_declare:nnn { property }   { theorem }{ thmstyle-plain }
        \thm_declare:nnn { axiom }      { theorem }{ thmstyle-plain }
        \thm_declare:nnn { example }    { theorem }{ thmstyle-plain }
        \thm_declare:nnn { remark }     { theorem }{ thmstyle-plain }
      }
      {
        % 独立编号
        \thm_declare:nnn { theorem }    { } { thmstyle-plain }
        \thm_declare:nnn { definition } { } { thmstyle-plain }
        \thm_declare:nnn { lemma }      { } { thmstyle-plain }
        \thm_declare:nnn { corollary }  { } { thmstyle-plain }
        \thm_declare:nnn { property }   { } { thmstyle-plain }
        \thm_declare:nnn { axiom }      { } { thmstyle-plain }
        \thm_declare:nnn { example }    { } { thmstyle-plain }
        \thm_declare:nnn { remark }     { } { thmstyle-plain }
      }
  }

\ExplSyntaxOff

% 证明不斜体, 空两格
\makeatletter
\renewenvironment{proof}[1][\proofname]{%
  \par\pushQED{\qed}%
  \normalfont
  \trivlist
  \item[\hskip\labelsep\hspace{2\ccwd}\bfseries #1:]%
  \ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}
\makeatother


% \theoremstyle{plain}
% \theoremheaderfont{\heiti}
% \theorembodyfont{\songti}
% \theoremindent 0em
% \theorempreskip{0pt}
% \theorempostskip{0pt}
% \theoremnumbering{arabic}

% \newtheorem{theorem}{\hspace{2em}定理}
% \newtheorem{definition}{\hspace{2em}定义}
% \newtheorem{lemma}{\hspace{2em}引理}
% \newtheorem{corollary}{\hspace{2em}推论}
% \newtheorem{property}{\hspace{2em}性质}
% \newtheorem{axiom}{\hspace{2em}公理}
% \newtheorem{example}{\hspace{2em}例}
% \newtheorem{remark}{\hspace{2em}注}

% \newtheorem{theorem}{\hspace{2em}定理}[chapter]
% \newtheorem{definition}{\hspace{2em}定义}[chapter]
% \newtheorem{lemma}{\hspace{2em}引理}[chapter]
% \newtheorem{corollary}{\hspace{2em}推论}[chapter]
% \newtheorem{property}{\hspace{2em}性质}[chapter]
% \newtheorem{axiom}{\hspace{2em}公理}[chapter]
% \newtheorem{example}{\hspace{2em}例}[chapter]
% \newtheorem{remark}{\hspace{2em}注}[chapter]

% \newtheorem{theorem}{\hspace{2em}定理}
% \newtheorem{definition}[theorem]{\hspace{2em}定义}
% \newtheorem{lemma}[theorem]{\hspace{2em}引理}
% \newtheorem{corollary}[theorem]{\hspace{2em}推论}
% \newtheorem{property}[theorem]{\hspace{2em}性质}
% \newtheorem{axiom}[theorem]{\hspace{2em}公理}
% \newtheorem{example}[theorem]{\hspace{2em}例}
% \newtheorem{remark}[theorem]{\hspace{2em}注}

% \newtheorem{theorem}{\hspace{2em}定理}[chapter]
% \newtheorem{definition}[theorem]{\hspace{2em}定义}
% \newtheorem{lemma}[theorem]{\hspace{2em}引理}
% \newtheorem{corollary}[theorem]{\hspace{2em}推论}
% \newtheorem{property}[theorem]{\hspace{2em}性质}
% \newtheorem{axiom}[theorem]{\hspace{2em}公理}
% \newtheorem{example}[theorem]{\hspace{2em}例}
% \newtheorem{remark}[theorem]{\hspace{2em}注}




% \theoremstyle{nonumberplain}
% \theoremheaderfont{\heiti}
% \theorembodyfont{\normalfont \rm \songti}
% \theoremindent 0em
% \theoremseparator{:}
% \theoremsymbol{$\square$}
% \newtheorem{proof}{\hspace{2em}证明}

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

% %
% % % Change default margins for \list environments
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

% %%%%%%%%listings 设置%%%%%%%%%%%%
% % \usepackage{textcomp}
% \definecolor{listinggray}{gray}{0.9}
% \definecolor{lbcolor}{rgb}{0.9,0.9,0.9}
% \lstset{
%     backgroundcolor=\color{white},
%     tabsize=4,
%     rulecolor=,
%     language=TeX,
%     basicstyle=\scriptsize,
%     upquote=true,
%     aboveskip={\baselineskip},
%     columns=fixed,
%     showstringspaces=false,
%     extendedchars=true,
%     breaklines=true,
%     prebreak = \raisebox{0ex}[0ex][0ex]{\ensuremath{\hookleftarrow}},
%     frame=single,
%     showtabs=false,
%     showspaces=false,
%     showstringspaces=false,
%     identifierstyle=\ttfamily,
%     keywordstyle=\color[rgb]{0,0,1},
%     commentstyle=\color[rgb]{0.133,0.545,0.133},
%     stringstyle=\color[rgb]{0.627,0.126,0.941},
% }
%% tag: lstlisting 设置
\ifprint
    \lstset{
        aboveskip=20pt,
        basicstyle=\ttfamily\small,
        numbers=left,
        numberstyle=\tiny,
        breaklines=true,
        frame=single,
        keywordstyle=\color{black},
        commentstyle=\color{black},
        stringstyle=\color{black},
    }
\else
    \lstset{
        aboveskip=20pt,
        basicstyle=\ttfamily\small,
        numbers=left,
        numberstyle=\tiny,
        breaklines=true,
        frame=single,
        keywordstyle=\color{blue},
        commentstyle=\color{gray},
        stringstyle=\color{orange},
    }
\fi


%% tag: enumerate 设置
\setlist[enumerate]{itemsep=0pt, topsep=0pt, parsep=0pt}
\setlist[description]{itemsep=0pt, topsep=0pt, parsep=0pt}
\setlist[itemize]{itemsep=0pt, topsep=0pt, parsep=0pt}

%---------------------------------------------------
%% tag: 图片、表格
\DeclareCaptionFont{xbf}{\zihao{5}\bfseries\boldmath}
%%% 设置图表与上下文之间的距离
\setlength{\textfloatsep}{40pt}
% \setlength{\intextsep}{2\baselineskip}
%%% ---- 图表标题设置 ----- %%%%
\captionsetup[figure]{%
    format=plain,
    font=xbf,
    % labelfont = {\bfseries},
    % textfont={bf},
    skip = 5pt
}  %
\ExplSyntaxOn
\str_case:Nn \type {
    {thesis}{
            \renewcommand{\thefigure}{\thechapter-\arabic{figure}} % 图编号格式
        }
}
\ExplSyntaxOff
\renewcommand{\figurename}{图}


\captionsetup[table]{%
    format=plain,
    font=xbf,
    % labelfont = {bf},
    % textfont = {bf},
    skip=5pt
}
\captionsetup[longtable]{%
    font=xbf,              % 字体大小
    % labelfont={bf},            % 标签“表 x.x”加粗
    % textfont={bf},             % 标题内容斜体
    justification=centering, % 居中对齐
    skip = 5pt
}
\ExplSyntaxOn
\str_case:Nn \type {
    {thesis}{
            \renewcommand{\thetable}{\thechapter-\arabic{table}} % 表编号格式
        }
}
\ExplSyntaxOff
\renewcommand{\tablename}{表}


%% 提供图表加粗整行支持 代码来源 https://tex.stackexchange.com/questions/309833/format-whole-row-of-table-as-bold
\newcommand{\setrow}[1]{\gdef\rowmac{#1}#1\ignorespaces}
\newcommand{\clearrow}{\global\let\rowmac\relax}
\clearrow

% 调整为5号字 这部分好像不起作用
\AtBeginEnvironment{table}{\zihao{5}}
\AtBeginEnvironment{tabularx}{\zihao{5}}

%% tag: 目录
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{4}

% \setlength{\cftaftertoctitleskip}{40pt}

\renewcommand{\cfttoctitlefont}{}
% \renewcommand{\cftaftertoctitle}{\hfill}
\ctexset{contentsname={\heiti\ziju{2} 目录}}

% 毕业论文book类 设置
\ExplSyntaxOn
\str_case:Nn \type {
    {thesis}{
            \renewcommand{\cftchapfont}{\songti\zihao{-4}}       % 章标题
            \renewcommand{\cftchappagefont}{\songti\zihao{-4}}    % 章页码
            \setlength{\cftchapindent}{0pt} % chapter 不缩进
            \setlength{\cftbeforechapskip}{0pt}
            % 点线设置
            \renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
        }
}
\ExplSyntaxOff

\renewcommand{\cftsecfont}{\songti\zihao{-4}}        % 节标题
\renewcommand{\cftsecpagefont}{\songti\zihao{-4}}    % 节页码
\setlength{\cftbeforesecskip}{0pt}                   % 不额外空行
\setlength{\cftsecindent}{0pt}                       % section 不缩进

\renewcommand{\cftsubsecfont}{\songti\zihao{-4}}     % 条标题
\renewcommand{\cftsubsecpagefont}{\songti\zihao{-4}} % 条页码
\setlength{\cftbeforesubsecskip}{0pt}                % 不额外空行
\setlength{\cftsubsecindent}{0pt}                    % subsection 不缩进





%% tag: 摘要、关键词
\newcommand\cnkeywords[1]{ {\heiti\zihao{-4}\cnkeywordsname: }\songti\zihao{-4}#1}
\newcommand\cnkeywordsname{关键词}
\newcommand\enkeywords[1]{{\noindent\bfseries\zihao{-4}\enkeywordsname: }\zihao{-4}#1}
\newcommand\enkeywordsname{Key Words}

% \heiti \ziju{1}
\newenvironment{cnabstract}{%
    \chapter[摘要]{\heiti\ziju{1}摘要}
    \zihao{-4}
}
{\newline
    \par}


\newenvironment{enabstract}{%
    \chapter[ABSTRACT]{\bfseries ABSTRACT}
    \zihao{-4}
    \noindent}
{\newline\par}

%% tag: 章节格式调整
%% -----frontmatter mainmatter appendix 设置 使得自动调整章节格式-----
% \titlespacing*{\chapter}{80pt}{0pt}{0pt}  % 修改为 0pt 贴紧顶部

\apptocmd{\frontmatter}{
    \pagenumbering{Roman}
    \pagestyle{plain}
    \ctexset{
        chapter={
          format={\centering\zihao{-2}},
          pagestyle={plain},
          afterskip={2\baselineskip},
          beforeskip={-20pt}
         }
    }
}{}{}

\apptocmd{\mainmatter}{
    \pagestyle{master-thesis-mainmatter}
    \ctexset{
        chapter={
          format = {\zihao{3}\heiti\raggedright},
          % titleformat={\zihao{3}\heiti\raggedright},
          % nameformat={\zihao{3}\heiti\raggedright},
          pagestyle={master-thesis-mainmatter},
          fixskip = true,
          afterskip={20pt},
          beforeskip={0pt},
          number={\arabic{chapter}},
          name={,},
          aftername={\quad},
          % aftername={},
          % indent = 2\ccwd,
         },
        section={
          format={\zihao{-3}\heiti\raggedright},
          % nameformat={\zihao{-3}\heiti\raggedright},
          % titleformat={\zihao{-3}\heiti\raggedright},
          afterskip={6pt},
          beforeskip={6pt},
          aftername={\quad},
          % aftername={},
          name={,},
          % fixskip = true,
          % indent = 2\ccwd,
         },
        subsection={
                format={\zihao{4}\heiti\raggedright},
                % nameformat={\zihao{4}\heiti\raggedright},
                % titleformat={\zihao{4}\heiti\raggedright},
                afterskip={3pt},
                beforeskip={3pt},
                aftername={\quad},
                % aftername={},
                name={,},
                % fixskip = true,
                % indent = 2\ccwd,
            },
        subsubsection={
                format={\zihao{-4}\heiti\raggedright},
                % titleformat={\zihao{-4}\heiti\raggedright},
                % nameformat={\zihao{-4}\heiti\raggedright},
                afterskip={0pt},
                beforeskip={0pt},
                aftername={\quad},
                % aftername={},
                name={,},
                % fixskip = true,
                % indent = 2\ccwd,
            }
    }
    \zihao{-4}\songti \setlength{\baselineskip}{20pt} \selectfont
}{}{}


% \renewcommand{\frontmatter}{
%     \@mainmatterfalse
%     \pagenumbering{Roman}
%     \pagestyle{plain}
%     \ctexset{
%         chapter={
%           format={\centering\zihao{-2}},
%           pagestyle={plain},
%           afterskip={2\baselineskip},
%           beforeskip={0pt},
%          }
%     }
% }

% \renewcommand{\mainmatter}{
%     \@mainmattertrue
%     \pagenumbering{arabic}
%     \pagestyle{master-thesis-mainmatter}
%     \ctexset{
%         chapter={
%             format = {\zihao{3}\heiti\raggedright},
%             % titleformat={\zihao{3}\heiti\raggedright},
%             % nameformat={\zihao{3}\heiti\raggedright},
%             pagestyle={master-thesis-mainmatter},
%             fixskip = true,
%             afterskip={20pt},
%             beforeskip={0pt},
%             number={\arabic{chapter}},
%             name={,},
%             % aftername={\quad},
%             aftername={}
%          },
%         section={
%             format={\zihao{-3}\heiti\raggedright},
%             % nameformat={\zihao{-3}\heiti\raggedright},
%             % titleformat={\zihao{-3}\heiti\raggedright},
%             afterskip={6pt},
%             beforeskip={6pt},
%             % aftername={\quad},
%             aftername={},
%             name={,},
%             % fixskip = true,
%          },
%         subsection={
%             format={\zihao{4}\heiti\raggedright},
%             % nameformat={\zihao{4}\heiti\raggedright},
%             % titleformat={\zihao{4}\heiti\raggedright},
%             afterskip={3pt},
%             beforeskip={3pt},
%             % aftername={\quad},
%             aftername={},
%             name={,},
%             % fixskip = true,
%             },
%         subsubsection={
%             format={\zihao{-4}\heiti\raggedright},
%             % titleformat={\zihao{-4}\heiti\raggedright},
%             % nameformat={\zihao{-4}\heiti\raggedright},
%             afterskip={0pt},
%             beforeskip={0pt},
%             % aftername={\quad},
%             aftername={},
%             name={,},
%             % fixskip = true,
%             }
%     }
%     \zihao{-4}\songti \setlength{\baselineskip}{20pt} \selectfont
% }


% \apptocmd{\appendix}{\ctexset{chapter={pagestyle={plain}}}
% }{}{}


%% tag: 脚注 设置为带编号数字
% \MakePerPage{footnote}

\DefineFNsymbols{circled}{{\ding{192}}{\ding{193}}{\ding{194}}
        {\ding{195}}{\ding{196}}{\ding{197}}{\ding{198}}{\ding{199}}{\ding{200}}{\ding{201}}}
\setfnsymbol{circled}

%% tag: cleardoublepage 设置清除双面打印时的空白页
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

%% tag: 信息宏定义
\newtoks{\etitle}
\newtoks{\supervisor}
\newtoks{\supervisorOuter}
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

\ExplSyntaxOn
\cs_new:Npn \__thesis_infoTableOne: {
    \str_case:Nn \masterClass {
        {学术}{\renewcommand{\arraystretch}{1.5}
                \begin{tabular}{ll}
                    \makebox[3.5cm][s]{\zihao{4}专业名称}    & \underline{\makebox[5.75cm][c]{\zihao{4}\the\major}}      \\%\hline
                    \makebox[3.5cm][s]{\zihao{4}学位申请人}   & \underline{\makebox[5.75cm][c]{\zihao{4}\cname}}          \\%\hline
                    \makebox[3.5cm][s]{\zihao{4}导师姓名及职称} & \underline{\makebox[5.75cm][c]{\zihao{4}\the\supervisor}} \\%\hline
                    \makebox[3.5cm][s]{\zihao{4}学号}      & \underline{\makebox[5.75cm][c]{\zihao{4}\the\studentid}}  \\%\hline
                    \makebox[3.5cm][s]{\zihao{4}入学时间}    & \underline{\makebox[5.75cm][c]{\zihao{4}\the\EnterDate}}  \\%\hline
                \end{tabular}}
            {专业}{\renewcommand{\arraystretch}{1.5}
                \begin{tabular}{ll}
                    \makebox[3.5cm][s]{\zihao{4}专业学位名称} & \underline{\makebox[5.75cm][c]{\zihao{4}\the\major}}           \\
                    \makebox[3.5cm][s]{\zihao{4}学位申请人}  & \underline{\makebox[5.75cm][c]{\zihao{4}\cname}}               \\
                    \makebox[3.5cm][s]{\zihao{4}校内导师}   & \underline{\makebox[5.75cm][c]{\zihao{4}\the\supervisor}}      \\
                    \makebox[3.5cm][s]{\zihao{4}校外导师}   & \underline{\makebox[5.75cm][c]{\zihao{4}\the\supervisorOuter}} \\
                    \makebox[3.5cm][s]{\zihao{4}学号}     & \underline{\makebox[5.75cm][c]{\zihao{4}\the\studentid}}       \\
                    \makebox[3.5cm][s]{\zihao{4}入学时间}   & \underline{\makebox[5.75cm][c]{\zihao{4}\the\EnterDate}}       \\
                \end{tabular}}
    }
}
\cs_new:Npn \__thesis_infoTableTwo: {
    \str_case:Nn \masterClass {
        {学术}{\renewcommand{\arraystretch}{1.5}
                \begin{tabular}{ll}
                    \makebox[3.5cm][s]{\zihao{4}专业名称}  & \underline{\makebox[5.75cm][c]{\zihao{4}\the\major}}      \\%\hline
                    \makebox[3.5cm][s]{\zihao{4}学位申请人} & \underline{\makebox[5.75cm][c]{\zihao{4}\cname}}          \\%\hline
                    \makebox[3.5cm][s]{\zihao{4}指导教师}  & \underline{\makebox[5.75cm][c]{\zihao{4}\the\supervisor}} \\%\hline
                    \makebox[3.5cm][s]{\zihao{4}学号}    & \underline{\makebox[5.75cm][c]{\zihao{4}\the\studentid}}  \\%\hline
                    \makebox[3.5cm][s]{\zihao{4}入学时间}  & \underline{\makebox[5.75cm][c]{\zihao{4}\the\EnterDate}}  \\%\hline
                \end{tabular}}
            {专业}{\renewcommand{\arraystretch}{1.5}
                \begin{tabular}{ll}
                    \makebox[3.5cm][s]{\zihao{4}专业学位名称} & \underline{\makebox[5.75cm][c]{\zihao{4}\the\major}}           \\
                    \makebox[3.5cm][s]{\zihao{4}学位申请人}  & \underline{\makebox[5.75cm][c]{\zihao{4}\cname}}               \\
                    \makebox[3.5cm][s]{\zihao{4}校内导师}   & \underline{\makebox[5.75cm][c]{\zihao{4}\the\supervisor}}      \\
                    \makebox[3.5cm][s]{\zihao{4}校外导师}   & \underline{\makebox[5.75cm][c]{\zihao{4}\the\supervisorOuter}} \\
                    \makebox[3.5cm][s]{\zihao{4}学号}     & \underline{\makebox[5.75cm][c]{\zihao{4}\the\studentid}}       \\
                    \makebox[3.5cm][s]{\zihao{4}入学时间}   & \underline{\makebox[5.75cm][c]{\zihao{4}\the\EnterDate}}       \\
                \end{tabular}}
    }
}
%% tag: 封面
\newcommand{\makecover}{%
    \begin{titlepage}
        \thispagestyle{empty}%
        \newgeometry{top=3.7truecm,bottom=3.5truecm,left=2.8truecm,right=2.6truecm}
        {\noindent\fangsong\zihao{-4}\bfseries 分类号： UDC\\[-3pt]
            密\quad 级：\\[-3pt]
            编\quad 号：
        }
        \vspace*{0.4cm}
        \begin{center}%
            \includegraphics[width=0.71\textwidth]{gdufelogo.jpg}
            \par\vspace*{2mm} %插入空白
            \rule{0.9\textwidth}{0.5pt}
            \par\vspace*{2mm}
            {\heiti \fontsize{48pt}{\baselinestretch} {\masterClass 学位硕士论文}}\\
            \vspace{60pt}
            {\heiti \zihao{-2} \ctitle}\\
            {\heiti \zihao{-2} \the\etitle \par}
            % \vspace*{2em}
            \vfill\vfill\vfill
            % {\fangsong \infoTable}
            {\fangsong \__thesis_infoTableOne:}
            \vfill
            {\fangsong\zihao{3} \bfseries \the\DefenseDate}
            \vspace{1em}
        \end{center}
    \end{titlepage}
    \restoregeometry
}

%% tag:扉页
\newcommand{\maketitlepage}{%
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
            % \hspace*{2em}\infoTable
            \hspace*{2em}\__thesis_infoTableTwo:
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
                \makebox[4.25cm][s]{ }                & \underline{\makebox[4.75cm][s]{}} \\
            \end{tabular}
        }
        \vfill
    \end{center}
    \restoregeometry
}
\ExplSyntaxOff

%% tag:原创性声明
\newcommand{\makeclaim}{
    \newpage
    \thispagestyle{empty}
    \newgeometry{top=3.7truecm,bottom=3.5truecm,left=2.8truecm,right=2.6truecm}
    \begin{spacing}{2}
        \begin{center}
            {\heiti \origzihao{3} \bfseries 广东财经大学学位论文原创性声明}
        \end{center}
        % \vspace{0.72cm}

        \fangsong \origzihao{4}
        本人郑重声明：所呈交的学位论文是本人在导师的指导下独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本论文不含任何其他个人或集体已经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。因本学位论文引起的法律后果完全由本人承担。
        \newline
        \makebox[11cm][r]{学位论文作者签名：} \makebox[3.75cm][l]{\includegraphics[width=3.5cm]{author-sign}}\\
        \makebox[11cm][r]{签字日期：} \makebox[3.75cm][l]{\the\SignDate}

    \end{spacing}
    \begin{spacing}{1.8}
        \begin{center}
            \heiti \bfseries \origzihao{3} 广东财经大学学位论文版权使用授权书
        \end{center}

        \fangsong \origzihao{4}
        本学位论文作者完全了解广东财经大学有关保留、使用学位论文的规定，有权保留并向国家有关部门或机构送交论文的纸质版和电子版，允许论文被查阅和借阅。本人授权广东财经大学可以将学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存、汇编学位论文。

        （保密的学位论文在解密后适用本授权书）

        \vspace*{0.75cm}
        \noindent
        \makebox[9.5cm][l]{学位论文作者签名：\includegraphics[width=3.5cm]{author-sign}} \makebox[5truecm][l]{导师签名：\includegraphics[width=3.5cm]{supervisor-sign}}\\
        \makebox[9.5cm][l]{签字日期：\the\SignDate} \makebox[5truecm][l]{签字日期：\the\SignDate}
    \end{spacing}
    \songti
    \restoregeometry
    % \makeatother
}


%% tag: 开题报告
% 信息部分
\newtoks{\gender}
\newtoks{\researchDirection}
% 封面页
\newcommand{\makeProposalCover}{
    \begin{titlepage}
        \thispagestyle{empty}%
        \begin{center} \leavevmode
            {%
                \centering
                \includegraphics[width=0.71\textwidth]{gdufelogo.jpg}
            }
            \par\vspace*{2mm} %插入空白
            \rule{0.9\textwidth}{0.5pt}
            \par\vspace*{2mm}
            \begin{spacing}{1.5}
                \bfseries \fangsong \zihao{-1} 硕士研究生学位论文开题报告
            \end{spacing}
            \vspace{60pt}
            {\heiti \zihao{-2} \ctitle\\\the\etitle}\\
            % \vspace*{2em}
            \vfill
            {\heiti\setlength\baselineskip{35pt}
                \makebox[2cm][s]{\zihao{4}姓名}:           \underline{\makebox[3.75cm][c]{\zihao{4}\cname}}          \\
                \makebox[2cm][s]{\zihao{4}学号}:           \underline{\makebox[3.75cm][c]{\zihao{4}\the\studentid}}  \\
                \makebox[2cm][s]{\zihao{4}专业}:           \underline{\makebox[3.75cm][c]{\zihao{4}\the\major}}      \\
                \makebox[2cm][s]{\zihao{4}入学时间}:        \underline{\makebox[3.75cm][c]{\zihao{4}\the\EnterDate}}  \\
                \makebox[2cm][s]{\zihao{4}指导教师}:        \underline{\makebox[3.75cm][c]{\zihao{4}\the\supervisor}} \\
                \makebox[2cm][s]{\zihao{4}开题时间}:        \underline{\makebox[3.75cm][c]{\zihao{4}\the\EnterDate}}  \\
            }
            \vfill
            \zihao{-4}
            广东财经大学研究生处制\\[8pt]
            \the\DefenseDate
            \vspace{5mm}
        \end{center}
    \end{titlepage}
}

% 须知页
\newcommand{\makeProposalNote}{\clearpage
    \vspace*{0.5cm}
    \pagestyle{master-proposal-style}
    \par

    \begin{spacing}{2}
        \begin{center}
            {\zihao{3} \bfseries \setlength{\baselineskip}{30pt} \selectfont 填表须知}
        \end{center}
        {
        \zihao{4} \setlength{\baselineskip}{30pt}\selectfont
        \noindent 一、本表统一使用A4纸{\heiti \bfseries 双面}打印。所需填写内容超出页面限制，可扩充表格；

        \noindent 二、表格中需签名部分须用黑色的签字笔或钢笔填写；

        \noindent 三、一表一式两份，可复印。原件交研究生处存档，复印件由培养单位留存。
        }
    \end{spacing}
}

\newcommand{\ProposalMatter}{% 格式设置
    \clearpage
    \zihao{5} \setlength{\baselineskip}{20pt}\selectfont
    \pagestyle{master-proposal-style}
    \ctexset{
        section={
          format={\zihao{5}\bfseries\raggedright},
          afterskip={0pt},
          beforeskip={0pt},
          aftername={. }
         },
        subsection={
                format={\zihao{5}\bfseries\raggedright},
                afterskip={0pt},
                beforeskip={0pt},
                aftername={. }
            },
        subsubsection={
                format={\zihao{5}\bfseries\raggedright},
                afterskip={0pt},
                beforeskip={0pt},
                aftername={. }
            }
    }
}
\newcommand{\makeProposalInfoTable}{%
    \renewcommand{\arraystretch}{1.4}
    \noindent
    \begin{tabular*}{\linewidth}%
        {@{\extracolsep{\fill}}|>{\arraybackslash}m{0.1\linewidth}|l|l|l|p{2em}|l|l|@{}}
        \hline
        姓名 & \multicolumn{2}{>{\arraybackslash}p{0.15\linewidth}|}{\cname} & 性别& \the\gender    & 入学时间 & \the\EnterDate\\
        \hline
        学科 & \multicolumn{4}{>{\arraybackslash}p{0.25\linewidth}|}{\the\major} & 研究方向 & \the\researchDirection\\
        \hline
        论文 & 中文 & \multicolumn{5}{>{\arraybackslash}p{0.76\linewidth}|}{\ctitle}\\
        \cline{2-7}
        题目 & 英文 & \multicolumn{5}{>{\arraybackslash}p{0.76\linewidth}|}{\the\etitle}\\
        \hline
    \end{tabular*}
    \renewcommand{\arraystretch}{1}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\graphicspath{{figures/}}        % 图片文件路径
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \allowdisplaybreaks

\raggedbottom

\endlinechar `\^^M
\endinput
