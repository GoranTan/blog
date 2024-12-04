---
title:  解决Error: fatal: No url found for submodule path 'public' in .gitmodules：使用github page部署失败。
date: 2024-12-04
# tags分为Github,前端，python，AI等
# categories分为code和life以及study
tags:
  - Github
  - 前端
categories:
  - code
# 进入文章的第一张图
featuredImage: "https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204102529533.jpg"
# 还没进入文章的封面图，可在网站自动生成：https://coverview.lruihao.cn/
featuredImagePreview: "https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204120301258.png"

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



即使如此，还是报错，这里怀疑是git的本地仓库一直有文件储藏了submodule的信息。尝试直接删除，强制推送

1. - 清除子模块配置残留（本地）
     - **检查`.gitmodules`文件**：再次确认`.gitmodules`文件，确保其中已经没有关于`public`、`themes/hugo - theme - reimu`和`themes/hugo - theme - stack`的配置信息。如果还有残留，手动删除这些子模块相关的部分。
     - **删除本地子模块目录（如果存在）**：使用`rm -rf`命令删除本地仓库中对应的子模块目录。例如：

```plaintext
rm -rf public
rm -rf themes/hugo - theme - reimu
rm -rf themes/hugo - theme - stack
```

- **清除`Git`缓存中的子模块信息**：执行以下命令来清除`Git`缓存中的子模块信息，这有助于确保`Git`不会再尝试使用已删除子模块的旧配置。

```plaintext
git config - - remove - section submodule.public
git config - - remove - section submodule.themes/hugo - theme - reimu
git config - - remove - section submodule.themes/hugo - theme - stack
```

使用`git push - - force`将修改后的历史记录推送到远程仓库。这会覆盖远程仓库的现有历史记录。