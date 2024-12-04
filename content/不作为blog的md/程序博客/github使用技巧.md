```toml
title: 我的第一个博客：使用Github的小技巧
date: 2024-11-03
# tags分为Github,前端，python，AI等
# categories分为code和life以及study
tags:
  - Github
categories:
  - code
# 进入文章的第一张图
featuredImage: "https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204091417901.jpg"
# 还没进入文章的封面图，可在网站自动生成：https://coverview.lruihao.cn/
featuredImagePreview: "https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204093206748.png"

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
```

简介：本文分享我作为新手的一些github的使用技巧，分别是如何快速的访问github，如何不进入github实现加速github项目的下载和clone，以及github的项目文档书写规范。



# 1.如何快速的访问github

内容：本人实测的可行的加速github方法，网上发布的很多方法经过测试已经无法使用，比如修改host地址，目前是2024年10月30日，以下方法仍然可用。



## 1.1. 下载使用steam++

这个方法本人并未使用，但是在搜索时在2024年有多条评论显示steam++可以实现github加速。



## 1.2. 下载devsidecar

devsidecar是一个github的开源项目，可以实现：dns优选，请求拦截，github直连加速，npm加速，Stack Overflow加速。

项目路径：[docmirror/dev-sidecar: 开发者边车，github打不开，github加速，git clone加速，git release下载加速，stackoverflow加速](https://github.com/docmirror/dev-sidecar)

下载路径：[Releases · docmirror/dev-sidecar](https://github.com/docmirror/dev-sidecar/releases)

使用方法：按照教程下载安装之后，在首页打开默认模式。如果打不开github连接，可以复制下载链接在下面介绍的加速下载网站打开。

<center>{{<figure src="../assets/app1.png" width="100%" title="软件图片">}}</center>



# 2.如何加速github的下载和clone

大家经常可以遇到clone速度以kb/s甚至b/s计数，在网上找到一个好用的方法，有两个网站，可以把要clone的网址复制下来，粘贴到网站里，第一个网站速度接近1mb，第二个网站可以达到2到4mb，这个也和网络有关。

[GitHub加速下载](https://github.moeyy.xyz/)
[GitHub 文件加速](https://gh.api.99988866.xyz/)



# 3.如何培养好的文档编写习惯

从一个github大佬那里参考过来的，有点忘记名字了，一个好的文档编写习惯对于小白来说还是挺重要的。

软件手册是一部完整的书，建议采用下面的结构。

- 简介(Introduction)：[必备][文件]提供对产品和文档本身的总体的、扼要的说明。
- 快速上手(Getting Started)：[可选][文件]如何最快速地使用产品。
- 入门篇(Basics)：[必备][目录]又称“使用篇”，提供初级的使用教程。
  - 环境准备(Prerequisite)：[必备][文件]软件使用需要满足的前置条件。
  - 安装(Installation)：[可选][文件]软件的安装方法。
  - 设置(Configuration)：[必备][文件]软件的设置。
- 进阶篇(Advanced)：[可选][目录]又称“开发篇”。提供中高级的开发教程。
  - API(Reference)：[可选][目录/文件]软件 API 的逐一介绍。
  - FAQ：[可选][文件]常见问题解答。
- 附录(Appendix)：[可选][目录]不属于教程本身、但对阅读教程有帮助的内容。
  - Glossary：[可选][文件]名词解释。
  - Recipes：[可选][文件]最佳实践。
  - Troubleshooting：[可选][文件]故障处理。
- ChangeLog：[可选][文件]版本说明。
- Feedback：[可选][文件]反馈方式。

<!-- 采用 HTML 标签的方法来插入图片

<center><img src="../assets/content.png" width="50%" /></center> -->

<!-- Hugo 官方提供了一些 shortcodes 短代码，其中就包含插入图片的短代码 figure
<center>{{<figure src="../assets/content.png" width="50%" title="这是一个测试图片，位于assets文件夹下">}}</center> -->

<center>{{<figure src="../assets/content.png" width="100%" title="原文截图">}}</center>
