# 解决git连接失败的问题






# 问题描述

在修改git代理后再运行git push -u origin master时出现如下问题：

```
git: Failed to connect to 127.0.0.1 port 1080: Connection refused
```

&lt;!--more--&gt;

# 解决方法

网上有很多解决方法，但我在尝试的时候运行并没有反映。后来经过尝试后发现如何有效地利用这些方法解决这个问题。
网上方法：GitHub，解决访问时图裂、加载慢的问题

```
git config --global --unset http.proxy  
git config --global --unset https.proxy
```

这个我在终端运行时并没有反映，经尝试后我发现只有在git的仓库位置（初始化的位置）运行才会取消gitconfig中的http.proxy=127.0.0.1:1080或者https.proxy=127.0.0.1:1080。

我的Git初始化位置在总项目下的，前几次尝试都是在子目录git clone，于是我在主目录运行git config --list后果然发现存在代理问题（而你在其他位置运行就不会显示这个代理），最后只需要在你git对应的目录下运行以上方法即可成功解决。



---

> 作者: [Goran](https://github.com/GoranTan)  
> URL: http://localhost:1313/posts/%E5%AE%8C%E7%BE%8E%E8%A7%A3%E5%86%B3git-failed-to-connect-to-127.0.0.1-port-1080-connection-refused%E6%8A%A5%E9%94%99%E9%97%AE%E9%A2%98/  

