

 

```

title:  解决Error: fatal: No url found for submodule path 'public' in .gitmodules：使用github page部署失败。
date: 2024-12-04
# tags分为Github,前端，python，AI等
# categories分为code和life以及study
tags:
  - Github
  - 前端
categories:
  - 
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



# 解决Error: fatal: No url found for submodule path 'public' in .gitmodules：使用github page部署失败。

使用Github page部署博客，push之后在仓库发生报错，GitHub部署失败，查看details：`Error: fatal: No url found for submodule path 'public' in .gitmodules`，发现是.gitmodules的错误。

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