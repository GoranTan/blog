---
title: 解决Error:fatal:No url found for submodule path 'public' in .gitmodules.使用github page部署失败。
date: 2024-12-04
# tags分为Github,前端，python，AI等
# categories分为code和life以及study
tags:
  - Github
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



即使如此，还是报错，这里怀疑是git的本地仓库一直有文件储藏了submodule的信息。尝试直接删除，强制推送。

在执行 `git add.` 操作时，发现自己忽略的warning可能是报错的原因：Git 检测到你正在将项目内的 `themes/hugo-theme-reimu` 和 `themes/hugo-theme-stack` 这两个本身是 `git` 仓库（也就是嵌入式 `git` 仓库）的目录添加进来。这意味着它们可能不是以正确的子模块形式存在于当前仓库中，而只是单纯作为嵌套的 `git` 仓库被添加，这样会导致一些潜在问题，比如克隆外层仓库时不会包含这些嵌入式仓库的内容，并且也不知道如何获取它们。

```bash
Administrator@DESKTOP-CADL72R MINGW64 /g/code/github/hugo-FixIt/my-blog (main)
$ git add .
warning: adding embedded git repository: themes/hugo-theme-reimu
hint: You've added another git repository inside your current repository.
hint: Clones of the outer repository will not contain the contents of
hint: the embedded repository and will not know how to obtain it.
hint: If you meant to add a submodule, use:
hint:
hint:   git submodule add <url> themes/hugo-theme-reimu
hint:
hint: If you added this path by mistake, you can remove it from the
hint: index with:
hint:
hint:   git rm --cached themes/hugo-theme-reimu
hint:
hint: See "git help submodule" for more information.
warning: adding embedded git repository: themes/hugo-theme-stack
```

而在github action的部署文件中也有一行：

```
submodules: recursive # Fetch Hugo themes (true OR recursive)
```

- 在这里`recursive`表示递归地获取子模块。如果项目使用了 Hugo 主题（Hugo themes）并且这些主题是以子模块的形式包含在项目中的，这个设置就会将主题相关的子模块以及这些子模块可能依赖的其他更深层次的子模块（如果有的话）全部获取下来。



**错误的原因：**我git拉取了好几个hugo的theme，但是只使用了一个，在action配置文件中有一个参数`recursive`表示递归地获取子模块，所以导致每次都会有文件外的submodule找不到url和path。

**解决方法：**删除这两个主题，并且清除子模块配置残留（本地）**删除本地子模块目录（如果存在）**：使用`rm -rf`命令删除本地仓库中对应的子模块目录。例如：

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

使用`git push - - force`将修改后的历史记录推送到远程仓库。

**成功解决**
