---
title: hugo的使用
date: 2024-12-03
# tags分为Github,前端，python，AI，bug等
# categories分为code和life以及study
tags:
  - 前端
categories:
  - code
featuredImage: "https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204102537502.jpg"
featuredImagePreview: "https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241203203116927.png"

author:
  name: Goran
  link: https://github.com/GoranTan
  email: "2446040095@qq.com"
  avatar: "https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241203195700868.png"

page:
  - authorAvatar: true
  - wordCount : true
  - readingTime : true
  - endFlag: "end"
  - toc: true

---













# 1.配置自己的初始网站，上传第一个博客。

# 1.1先决条件

在开始本教程之前，你必须：

1. [安装 Hugo](https://gohugo.io/getting-started/installing/)（扩展版，v0.134.1 或更高版本）
2. [安装 Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

# 1.2创建网站

### 1.2.1 命令

验证你是否安装了 Hugo v0.134.1 或更高版本。

```bash
hugo version
```

运行以下命令来创建一个带有 [FixIt](https://github.com/hugo-fixit/FixIt) 主题的 Hugo 网站。下一节将对每个命令进行解释。

```bash
hugo new site my-blog
cd my-blog
git init
git submodule add https://github.com/hugo-fixit/FixIt.git themes/FixIt
echo "theme = 'FixIt'" >> hugo.toml
echo "defaultContentLanguage = 'zh-cn'" >> hugo.toml
hugo server
```

windows系统下的可以在主目录或者配置目录中的toml手动将theme = ‘FixIt’，"defaultContentLanguage = ‘zh-cn’"添加进去。

通过终端中显示的 URL 查看你的站点。按 `Ctrl + C` 停止 Hugo 的开发服务器。

### 1.2.2 命令解释

在 `my-blog` 目录中为你的项目创建 [目录结构骨架](https://gohugo.io/getting-started/directory-structure/)。

```bash
hugo new site my-blog
```

将当前目录更改为项目的根目录。

```bash
cd my-blog
```

在当前目录中初始化一个空的 Git 存储库。

```bash
git init
```

将 [FixIt](https://github.com/hugo-fixit/FixIt) 主题作为 [Git 子模块](https://git-scm.com/book/en/v2/Git-Tools-Submodules) 添加到你的项目中的 `themes` 目录。

```bash
git submodule add https://github.com/hugo-fixit/FixIt.git themes/FixIt
```

在站点配置文件中添加一行，指定当前主题。

```bash
echo "theme = 'FixIt'" >> hugo.toml
```

在站点配置文件中添加一行，指定默认的内容语言。

```bash
echo "defaultContentLanguage = 'zh-cn'" >> hugo.toml
```

启动 Hugo 的开发服务器以查看站点。

```bash
hugo server
```

按 `Ctrl + C` 停止 Hugo 的开发服务器。

## 1.3 必要配置

为了能完整地使用 FixIt 主题的所有功能，务必在站点配置文件中添加以下内容。

```toml
[markup]
  _merge = "shallow"
[outputs]
  _merge = "shallow"
[taxonomies]
  _merge = "shallow"
```

以上配置表示继承 FixIt 主题的 `markup`，`outputs` 和 `taxonomies` 配置。

## 1.4 添加内容

给你的网站添加新页面。

```bash
hugo new content posts/my-first-post.md
```

Hugo 在 `content/posts` 目录中创建了该文件，使用编辑器打开文件。

```markdown
---
title: 我的第一篇文章
date: 2024-03-01T17:10:04+08:00
draft: true
# ...
---
```

注意：新建的md文件前面会有一段注释，用于hugo识别文档的一些配置信息，比如标题，所属类别，作者头像，是否在文章末尾显示集合导航等等。

请注意，[front matter](https://gohugo.io/content-management/front-matter/) 中的 `draft` 值为 `true`。默认情况下，Hugo 在你构建网站时不会发布草稿内容。详细了解 [草稿、未来和过期内容](https://gohugo.io/getting-started/usage/#draft-future-and-expired-content)。

在帖子正文中添加一些 [Markdown](https://commonmark.org/help/)，但不要更改 `draft` 值。

```markdown
---
title: 我的第一篇文章
date: 2024-03-01T17:10:04+08:00
draft: true
# ...
---

博客（英语：Blog）是一种在线日记型式的个人网站，借由张帖子章、图片或视频来记录生活、抒发情感或分享信息。博客上的文章通常根据张贴时间，以倒序方式由新到旧排列。
```

保存文件，然后启动 Hugo 的开发服务器来查看站点。你可以运行以下任一命令来包含草稿内容。

```bash
hugo server --buildDrafts
hugo server -D
hugo server -D --disableFastRender
```

由于本主题使用了 Hugo 中的 `.Scratch` 和 `.Store` 来实现一些特性， 非常建议你为 `hugo server` 命令添加 `--disableFastRender` 参数来实时预览你正在编辑的文章页面。
[![基本配置下的预览](https://fixit.lruihao.cn/zh-cn/documentation/getting-started/quick-start/simple-preview.webp)](https://fixit.lruihao.cn/zh-cn/documentation/getting-started/quick-start/simple-preview.webp?size=large)

基本配置下的预览

当对新内容感到满意时，将 front matter 中的 `draft` 值更改为 `false`，然后保存文件。

## 1.5 发布网站

在此步骤中，你将发布你的网站，但不会 *部署* 它。

当你发布站点时，Hugo 在项目根目录的 `public` 目录中创建整个静态站点。这包括 HTML 文件以及图像、CSS 文件和 JavaScript 文件等资源。

当你发布网站时，你通常不希望包含 [草稿、未来或过期的内容](https://gohugo.io/getting-started/usage/#draft-future-and-expired-content)，命令很简单。

```bash
hugo
```

我们的大多数用户使用 CI/CD 工作流程部署他们的网站，通过推送 [1](https://fixit.lruihao.cn/zh-cn/documentation/getting-started/quick-start/#fn:1)到他们的 GitHub 或 GitLab 存储库会触发构建和部署。流行的提供商包括 [Vercel](https://vercel.com/)[2](https://fixit.lruihao.cn/zh-cn/documentation/getting-started/quick-start/#fn:2)、[Netlify](https://www.netlify.com/)[3](https://fixit.lruihao.cn/zh-cn/documentation/getting-started/quick-start/#fn:3)、[AWS Amplify](https://aws.amazon.com/amplify/)、[CloudCannon](https://cloudcannon.com/)、[Cloudflare Pages](https://pages.cloudflare.com/)、 [GitHub pages](https://pages.github.com/) 和 [GitLab pages](https://docs.gitlab.com/ee/user/project/pages/)。

# 2.通过GitHub Pages 将自己的个人博客部署到云端，再通过github action实现本地自动上传更新。

## 2.1 概念，搭建思路和运行环境

### 2.1.1 什么是 GitHub Pages？

Github Pages 是一个可以从你的 Github 源码仓库中直接生成个人、组织或者项目页面的静态站点托管服务。

Github Pages 只能托管静态站点，不能运行服务器端源码，比如 PHP、Java、Python 或者 Ruby。

### 2.1.2 什么是 Hugo？

[Hugo](https://gohugo.io/) 是用 Go 语言写的静态网站生成器（Static Site Generator）。可以把 Markdown 文件转化成 HTML 文件。

### 2.1.3 网站搭建思路

1. 创建 2 个 GitHub 仓库
   - **博客源仓库**：储存所有 Markdown 源文件（博客内容），和博客中用到的图片等。
   - **GitHub Pages 仓库**：储存由 Hugo 从Markdown 文件生成的 HTML 文件。
2. 将在**博客源仓库**中 Hugo 生成的静态 HTML 文件部署到远端 **GitHub Pages 仓库**中。

## 2.2 创建 GitHub 仓库

### 2.2.1 创建博客源仓库

1. 命名**博客源仓库**（whatever you want）
2. 勾选 **Pricate**，设置为公开仓库。
3. 勾选添加 **README** 文件。

我将博客源码分开存放到一个private repo里，也可以将源码放到github pages repo中，但这样其他人能获取文章的源文件。

![img](https://cdn.jsdelivr.net/gh/krislinzhao/IMGcloud/img/Snipaste_2024-01-03_20-47-09.png)

### 2.2.2 创建 GitHub Page 仓库

1. 命名 **GitHub Pages** 仓库，这个仓库必须使用特殊的命名格式 `<username.github.io>`， `<username>` 是自己的 GitHub 的用户名。
2. 勾选 **Public**，设置为公开仓库。
3. 勾选添加 **README** 文件，这会设置 `main` 分支为仓库的默认主分支，这在后面提交推送博客内容时很重要。

![img](https://cdn.jsdelivr.net/gh/krislinzhao/IMGcloud/img/Snipaste_2024-01-03_20-51-25.png)

![image-20241203174347684](https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241203174347771.png)

使用Github Actions功能实现提交源码后自动发布。

### 2.2.3 生成Actions secrets

1. 生成Personal access tokens 首先点击github头像在下拉栏里进入Setting->Developer Settings->Personal access tokens -> tokens (classic)

   ![img](https://cdn.jsdelivr.net/gh/krislinzhao/IMGcloud/img/20240103211119.png)

选择Generate new token

![img](https://cdn.jsdelivr.net/gh/krislinzhao/IMGcloud/img/20240103211322.png)

点击Generate token生成token，并先复制保存该token。(这个token只有显示一次，所以一定要复制保存)

1. 生成Actions secrets 接下来在源码repo中添加上面的personal access token：

进入repo的Settings->Secrets and variable一栏，选择New repository secret

![img](https://cdn.jsdelivr.net/gh/krislinzhao/IMGcloud/img/20240103211622.png)

名称自取，Secret复制上面生成的Personal access tokens

![img](https://cdn.jsdelivr.net/gh/krislinzhao/IMGcloud/img/20240103211853.png)

### 2.2.4 配置actions文件

在repo根目录新建嵌套的两个文件夹.github/workflows

在workflows里新建一个后缀为.yml的配置文件，名字自取。

![img](https://cdn.jsdelivr.net/gh/krislinzhao/IMGcloud/img/20240103212223.png)

写进去以下配置（从hugo官方文档修改而来）：

```yml
name: github pages # 名字自取

on:
  push:
    branches:
      - main  # 这里的意思是当 main分支发生push的时候，运行下面的jobs，这里先改为github-actions

jobs:
  deploy: # 任务名自取
    runs-on: ubuntu-latest	# 在什么环境运行任务
    steps:
      - uses: actions/checkout@v2	# 引用actions/checkout这个action，与所在的github仓库同名
        with:
          submodules: true  # Fetch Hugo themes (true OR recursive) 获取submodule主题
          fetch-depth: 0    # Fetch all history for .GitInfo and .Lastmod

      - name: Setup Hugo	# 步骤名自取
        uses: peaceiris/actions-hugo@v2	# hugo官方提供的action，用于在任务环境中获取hugo
        with:
          hugo-version: 'latest'	# 获取最新版本的hugo
          # extended: true

      - name: Build
        run: hugo --minify	# 使用hugo构建静态网页

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3	# 一个自动发布github pages的action
        with:
          # github_token: ${{ secrets.GITHUB_TOKEN }} 该项适用于发布到源码相同repo的情况，不能用于发布到其他repo
          external_repository: krislinzhao/krislinzhao.github.io	# 发布到哪个repo
          personal_token: ${{ secrets.ACTION_ACCESS_TOKEN }}	# 发布到其他repo需要提供上面生成的personal access token
          publish_dir: ./public	# 注意这里指的是要发布哪个文件夹的内容，而不是指发布到目的仓库的什么位置，因为hugo默认生成静态网页到public文件夹，所以这里发布public文件夹里的内容
          publish_branch: main	# 发布到哪个branch
```

yml文件中只需要改external_repository为自己的github page仓库，personal_token: ${{ [secrets.XXX](http://secrets.xxx/) }} XXX改成上面生成Actions secrets步骤中取得名称。

### 2.2.5推送代码到源码仓库

1. 将BlogSource文件夹初始化为 Git 仓库，并设置默认主分支名为 main。这么做的原因是：

   GitHub 创建仓库时生成的默认主分支名是 main 用 git init 初始化 Git 仓库时创建的默认主分支名是 master 将 git init 创建的 master 修改成 main ，再推送给远端仓库，这样才不会报错。

   ```shell
   git init -b main
   ```

2. 将 public 文件夹关联远程 GitHub Pages 仓库，使用 GitHub Pages 仓库的 SSH 链接。

   ```shell
   git remote add origin ggit@github.com:krislinzhao/BlogSource.git
   ```

3. 推送本地文件到远程仓库

   ```shell
    git pull --rebase origin main
    git add .
    git commit -m "...(修改的信息)"
    git push origin main
   ```

推送完成之后到github仓库中的Actions中就可以看到runs运行成功，你的github pages仓库就会有hugo生成的html文件了，然后你就可以通过 [https://krislinzhao.github.io](https://krislinzhao.github.io/) 访问你的博客了。

# 3.个性化设置试一下 hugo-theme-reimu主题和fixit主题

布置hugo遇到的bug和问题，目前已实现功能：本地部署网站发布第一篇帖子，更改网站字体，更改网站宽度，部署到github page，使用github action自动部署。

## 3.1：配置文件的处理

1.使用主题，不同的主题配置文件不同，需要做的就是不要找这么多教学，把官方文档看懂，跟着一个走就行。了解基础知识，比如说public文件夹是静态资源文件，原本里面是没有东西的，跑起来之后就有了，比如配置文件可以放在单独的文件夹也可以方法根目录下，但只能有一个，名字还可以不一样。

2.下载有很多方式，推荐直接github下载，然后主题里面的内容是可以不用去管的，文档让你下载哪些资源，创建哪些文件夹是在自己新建的空项目里面做。

3.不建议直接搬过来，但是可以试试，我没试过。

## 3.2：更改网站宽度

很多主题的宽度是按照hugo默认的，在读起来一句话很长看起来很难受。不知道大家选的主题是哪一个，这个设置一般是在assets的scss文件里面设置，我用的fixit主题可以支持自己在自己的assets文件夹下建立_override.scss文件，里面可以覆盖主题的样式，还有_custom.scss，fixit支持按照以下格式定义页面宽度。

```
// 自定义页面宽度

[data-page-style='custom'] {
@media only screen and (min-width: 1441px) {
%page-style {
width: 720px; // 设置宽度为800像素
	}
}

@media only screen and (min-width: 1200px) {
	%page-style {
		width: 720px; // 设置宽度为800像素
}	}

@media only screen and (max-width: 1200px) {

%page-style {

width: 100%; // 小屏幕时宽度100%

}	
	}	
		}
```

## 3.3：更改网站字体

这里原本是按照主题的文档来写的，下载好了字体ttf文件，但是没有成功，遇到报错。

在_override.scss文件中自定义字体，然后将全局变量global-font-family修改，但是系统识别不了字体，读取不到，反复尝试多次不同的相对路径，确定不是路径问题。

```
//以My-Blog为根目录

@font-face {

font-family: xgw-wenkai;

src: url('../font/LXGWWenKaiGBScreen.ttf') format("ttf");

font-display: swap;

}

//以assets为根目录

@font-face {

font-family: yinbi2;

src: url('../font/正心格硬笔楷书简.ttf')format("ttf");

font-display: swap;

}

//以myblog（cmd下的目录）为根目录

@font-face {

font-family: yinbi1;

src: url('../font/瑞美加张清平硬笔楷书.ttf')format("ttf");

font-display: swap;

}

$global-font-family: 'LXGW WenKai', yinbi1, yinbi2, sans-serif!important;
```

后面也没找到原因，不过有另外一个方法，通过字体cdn网站成功解决，这个网站是线上配置字体资源，不需要本地下载，只需要引用就可以实现，非常方便。

```
@import url('https://chinese-fonts-cdn.deno.dev/packages/lxgwwenkai/dist/LXGWWenKai-Regular/result.css');

$global-font-family: 'LXGW WenKai', yinbi1, yinbi2, sans-serif!important;
```

检查方式：可以打开网站，使用F12检查网络，网络刷新一下看是否有自己设定的字体刷出来。

## 3.4：插入图片

Hugo 官方提供了一些 shortcodes 短代码，其中就包含插入图片的短代码 figure

```
<center>{{<figure src="../assets/content.png" width="100%" title="原文截图">}}</center>

<center>{{<figure src="../assets/OIP-C.jfif" width="100%" title="测试">}}</center>
```

## 3.5：一个好用的md编写文件+图床

**为什么要搭建博客图床?**
在本地的markdown文件.md中，图片是以“外链”这一形式存在的

Office word中，图片是直接插入docx文件里面
Markdown中，图片只是一个本地/联网的地址
也就是说，如果我们使用本地markdown编译器（如typora）来编辑MD文件的时候，如果MD里面插入的图片的源文件被移动或者删除了，我们的MD文档里面对应的图片也无法显示出来。

同时，如果我们用本地编辑器写好了一篇博客，想把它上传到CSDN上。CSDN是无法自动转存文件里面的图片的（因为这个图片只是一个你硬盘里面的文件路径）

[外链图片转存失败,源站可能有防盗链机制,建议将图片保存下来直接上传(img-0gNYdqHb-1647670910810)(photo/image-20220318140612548.png)]

这时候我们就需要用图床来解决这个问题

**什么是图床？**

在我们往typora里插入图片的时候，PicGO会自动上传图片到图床，并返回一个图片的链接

这时候你的图片就是一个网络的链接(网址)，不再是本地路径。

你也可以在任何有网络的地方、用任何设备访问这张图片了

即便是本地的那张图片移动or删除，也不会影响图床里的这张图片

markdown本地文件里面的图片也就不会失效了！

[Typora+PicGo+阿里云OSS搭建博客图床（超详细）-CSDN博客](https://blog.csdn.net/muxuen/article/details/122441469)

**其它主题展示：**

reimu主题：

![](https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241203174536948.png)

blowfish主题：

![](https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241203174506842.png)

stack主题：

![](https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241203174434031.png)