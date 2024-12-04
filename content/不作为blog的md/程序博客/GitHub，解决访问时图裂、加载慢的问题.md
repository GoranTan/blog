 

```
title:  解决git连接失败的问题
date: 2024-12-03
# tags分为Github,前端，python，AI等
# categories分为code和life以及study
tags:
  -  Github
categories:
  -  code
# 进入文章的第一张图
featuredImage: ""
# 还没进入文章的封面图，可在网站自动生成：https://coverview.lruihao.cn/
featuredImagePreview: ""

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



问题：**GitHub，解决访问时图裂、加载慢的问题**
在写markdown文档过程中遇到了github图床展示图片破损的问题。原因：dns污染，解决方法：修改host文件。网上找到两种方法，第一种手动改，这里推荐第二种自动更改。`SwitchHosts`是一个用于快速切换`hosts`文件的开源软件（https://github.com/oldj/SwitchHosts ）

下载后直接正常安装，接着以**管理员身份**打开，点击左下角`+`新建`hosts`，以 SwitchHosts 为例，看一下怎么使用的，配置参考下面：

- Hosts 类型: `Remote`
- Hosts 标题: 随意
- URL: `https://raw.hellogithub.com/hosts`
- 自动刷新: 最好选 `1 小时`这样每隔一小时

`SwitchHosts`就会自动访问URL并更新`hosts`信息：
![image-20241203174101278](https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241203174101330.png)

参考来源：[521xueweihan/GitHub520: 😘 让你“爱”上 GitHub，解决访问时图裂、加载慢的问题。（无需安装）](https://github.com/521xueweihan/GitHub520)

