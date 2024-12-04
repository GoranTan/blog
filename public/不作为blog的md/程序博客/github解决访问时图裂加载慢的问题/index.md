# 

 

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
featuredImage: &#34;&#34;
# 还没进入文章的封面图，可在网站自动生成：https://coverview.lruihao.cn/
featuredImagePreview: &#34;&#34;

author:
  name: Goran
  link: https://github.com/GoranTan
  email: &#34;2446040095@qq.com&#34;
  avatar: &#34;https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241203195700868.png&#34;

page:
  - authorAvatar: true
  - wordCount : true
  - readingTime : true
  - endFlag: &#34;end&#34;
  - toc: true
```



问题：**GitHub，解决访问时图裂、加载慢的问题**
在写markdown文档过程中遇到了github图床展示图片破损的问题。原因：dns污染，解决方法：修改host文件。网上找到两种方法，第一种手动改，这里推荐第二种自动更改。`SwitchHosts`是一个用于快速切换`hosts`文件的开源软件（https://github.com/oldj/SwitchHosts ）

下载后直接正常安装，接着以**管理员身份**打开，点击左下角`&#43;`新建`hosts`，以 SwitchHosts 为例，看一下怎么使用的，配置参考下面：

- Hosts 类型: `Remote`
- Hosts 标题: 随意
- URL: `https://raw.hellogithub.com/hosts`
- 自动刷新: 最好选 `1 小时`这样每隔一小时

`SwitchHosts`就会自动访问URL并更新`hosts`信息：
![image-20241203174101278](https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241203174101330.png)

参考来源：[521xueweihan/GitHub520: 😘 让你“爱”上 GitHub，解决访问时图裂、加载慢的问题。（无需安装）](https://github.com/521xueweihan/GitHub520)



---

> 作者:   
> URL: http://localhost:1313/%E4%B8%8D%E4%BD%9C%E4%B8%BAblog%E7%9A%84md/%E7%A8%8B%E5%BA%8F%E5%8D%9A%E5%AE%A2/github%E8%A7%A3%E5%86%B3%E8%AE%BF%E9%97%AE%E6%97%B6%E5%9B%BE%E8%A3%82%E5%8A%A0%E8%BD%BD%E6%85%A2%E7%9A%84%E9%97%AE%E9%A2%98/  

