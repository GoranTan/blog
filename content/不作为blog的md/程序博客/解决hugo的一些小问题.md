

```toml
title: 解决hugo的一些小问题
date: 2024-12-03
# tags分为Github,前端，python，AI等
# categories分为code和life以及study
tags:
  - 前端
categories:
  - code
# 进入文章的第一张图
featuredImage: "https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204093059688.jpg"
# 还没进入文章的封面图，可在网站自动生成：https://coverview.lruihao.cn/
featuredImagePreview: "https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204093453089.png"

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





# - 简介(Introduction)：

布置hugo遇到的bug和问题，目前已实现功能：本地部署网站发布第一篇帖子，更改网站字体，更改网站宽度，部署到github page，使用github action自动部署。

## 问题1：配置文件的处理

1.使用主题，不同的主题配置文件不同，需要做的就是不要找这么多教学，把官方文档看懂，跟着一个走就行。了解基础知识，比如说public文件夹是静态资源文件，原本里面是没有东西的，跑起来之后就有了，比如配置文件可以放在单独的文件夹也可以方法根目录下，但只能有一个，名字还可以不一样。
2.下载有很多方式，推荐直接github下载，然后主题里面的内容是可以不用去管的，文档让你下载哪些资源，创建哪些文件夹是在自己新建的空项目里面做。
3.不建议直接搬过来，但是可以试试，我没试过。

## 问题2：更改网站宽度

很多主题的宽度是按照hugo默认的，在读起来一句话很长看起来很难受。不知道大家选的主题是哪一个，这个设置一般是在assets的scss文件里面设置，我用的fixit主题可以支持自己在自己的assets文件夹下建立_override.scss文件，里面可以覆盖主题的样式，还有_custom.scss，fixit支持按照以下格式定义页面宽度。

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
      }
    }
      
    @media only screen and (max-width: 1200px) {
      %page-style {
        width: 100%; // 小屏幕时宽度100%
      }
    }
  }

## 问题3：更改网站字体
这里原本是按照主题的文档来写的，下载好了字体ttf文件，但是没有成功，遇到报错。

在_override.scss文件中自定义字体，然后将全局变量global-font-family修改，但是系统识别不了字体，读取不到，反复尝试多次不同的相对路径，确定不是路径问题。
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



后面也没找到原因，不过有另外一个方法，通过字体cdn网站成功解决，这个网站是线上配置字体资源，不需要本地下载，只需要引用就可以实现，非常方便。
@import url('https://chinese-fonts-cdn.deno.dev/packages/lxgwwenkai/dist/LXGWWenKai-Regular/result.css');
$global-font-family: 'LXGW WenKai', yinbi1, yinbi2, sans-serif!important;
检查方式：可以打开网站，使用F12检查网络，网络刷新一下看是否有自己设定的字体刷出来。
