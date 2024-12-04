# 



 

```

title:  解决Error: fatal: No url found for submodule path &#39;public&#39; in .gitmodules：使用github page部署失败。
date: 2024-12-04
# tags分为Github,前端，python，AI等
# categories分为code和life以及study
tags:
  - Github
  - 前端
categories:
  - code
# 进入文章的第一张图
featuredImage: &#34;&#34;
# 还没进入文章的封面图，可在网站自动生成：https://coverview.lruihao.cn/
featuredImagePreview: &#34;https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204120301258.png&#34;

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



# 解决Error: fatal: No url found for submodule path &#39;public&#39; in .gitmodules：使用github page部署失败。

使用Github page部署博客，push之后在仓库发生报错，GitHub部署失败，查看details：`Error: fatal: No url found for submodule path &#39;public&#39; in .gitmodules`，发现是.gitmodules的错误。

![image-20241204114907255](https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204114907288.png)

![image-20241204114842445](https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204114842512.png)

查看本地的.gitmodules只有三行代码，且path和url都没有问题。并且本地没有任何跟public有关的.gitmodules，找遍了其他配置文件都没看到。在网上的解决方法是更新submudule，无效，报错。

```bash
git submodule init
git submodule update
```

查看状态，依旧报错

```bash
git submodule status
```

![image-20241204115642958](https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204115642989.png)

最后参考：[同步子模块时出现gitmodules里不存在的path - 某人的小栈](https://www.fordece.cn/posts/同步子模块时出现gitmodules里不存在的path/)得已解决

是缓存的问题，原因：之前手动把.gitmodules的文件删了一部分，但是缓存没有更新。

解决方法：清楚缓存，有几个删几个。

```bash
$ # 把缓存里的public目录清理掉
git rm --cached public
```

![image-20241204115855875](https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204115855913.png)

---

> 作者:   
> URL: http://localhost:1313/%E4%B8%8D%E4%BD%9C%E4%B8%BAblog%E7%9A%84md/%E7%A8%8B%E5%BA%8F%E5%8D%9A%E5%AE%A2/github-page%E6%8A%A5%E9%94%99/  

