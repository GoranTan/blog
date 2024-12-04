# 

﻿```toml
title: paddleOCR——一个AI图片识别项目
date: 2024-12-03
# tags分为Github,前端，python，AI等
# categories分为code和life以及study
tags:
  - Github
categories:
  - code
# 进入文章的第一张图
featuredImage: &#34;https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204091417902.jpg&#34;
# 还没进入文章的封面图，可在网站自动生成：https://coverview.lruihao.cn/
featuredImagePreview: &#34;https://gorantan-blog.oss-cn-shanghai.aliyuncs.com/pic/20241204092800261.png&#34;

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



## **PaddleOCR 介绍**

这篇文章呢，将介绍一个新的 Github 项目，同样用于 OCR 识别、该项目名叫 PaddleOCR，是 Paddle 的一个分支；PaddleOCR 基于深度学习技术实现的， 所以使用时需要训练好的权重文件，但这个不需要我们担心，因为官方提供的有~

项目地址：[github链接](https://github.com/PaddlePaddle/PaddleOCR)

![效果展示](/imgs/2024-11-08/pAvB0Hs9Bxg5JKXB.png)


在 PaddleOCR 识别中，会依次完成三种任务：检测、方向分类及文本识别；

关于预训练权重，PaddleOCR 官网根据提供权重文件大小分为两类：  
-  一类为轻量级，（检测&#43;分类&#43;识别）三类权重加起来大小一共才 9.4 M，适用于手机端和服务器部署；
-   另一类（检测&#43;分类&#43;识别）三类权重内存加起来一共 143.4 MB ，适用于服务器部署；
-   无论模型是否轻量级，识别效果都能与商业效果相比，在本期教程中将选用轻量级权重用于测试；


而且他还支持多语言识别，目前能够支持 80 多种语言；
-   除了能对中文、英语、数字识别之外，还能应对字体倾斜、文本中含有小数点字符等复杂情况
-   提供有丰富的 OCR 领域相关工具供我们使用，方便我们制作自己的数据集、用于训练  半自动数据标注工具， 数据合成工具；

想要体验可以在[体验网站](https://www.paddlepaddle.org.cn/hub/scene/ocr)上传图片测试一下。

## **快速上手**
### **安装**
我并没有找到PaddleOCR集成的线上使用网站，如果要大规模使用，还是得配置在本地。PaddleOCR是paddle的一个分支。所以想要使用得先下好paddle库。按照下面的[paddle技术文档](https://www.paddlepaddle.org.cn/install/quick?docurl=/documentation/docs/zh/install/pip/windows-pip.html)里面的安装部分操作。

我的环境是：

&gt; Windows10，python3.9，cuda11.6。

所以我的下载命令是：
`python -m pip install paddlepaddle-gpu==2.6.1.post116 -f https://www.paddlepaddle.org.cn/whl/windows/mkl/avx/stable.html`

在下载的时候有时候会遇上有一些依赖包版本不对的情况，按照报错提示pip安装好依赖宝对应版本之后，重新执行下载命令即可

### **命令行使用**
之后的具体操作在[paddleOCR技术文档](https://paddlepaddle.github.io/PaddleOCR/v2.9/ppocr/quick_start.html)里面。
支持命令行使用和python脚本使用。命令行操作看教程，简单说一下。
中英文模型：-   检测&#43;方向分类器&#43;识别全流程：`use_angle_cls true`设置使用方向分类器识别180度旋转文字，`use_gpu false`设置不使用GPU。
```
paddleocr --image_dir ./imgs/11.jpg --use_angle_cls true --use_gpu false
```
返回结果是一个list，每个item包含了文本框，文字和识别置信度。
```
[[[28.0, 37.0], [302.0, 39.0], [302.0, 72.0], [27.0, 70.0]], (&#39;纯臻营养护发素&#39;, 0.9658738374710083)]
......
```
paddleocr也支持输入pdf文件，并且可以通过指定参数`page_num`来控制推理前面几页，默认为0，表示推理所有页。
```
paddleocr --image_dir ./xxx.pdf --use_angle_cls true --use_gpu false --page_num 2
```

### Python脚本使用
通过Python脚本使用PaddleOCR whl包，whl包会自动下载ppocr轻量级模型作为默认模型。
-   检测&#43;方向分类器&#43;识别全流程
```
from paddleocr import PaddleOCR, draw_ocr

# Paddleocr目前支持的多语言语种可以通过修改lang参数进行切换
# 例如`ch`, `en`, `fr`, `german`, `korean`, `japan`
ocr = PaddleOCR(use_angle_cls=True, lang=&#34;ch&#34;)  # need to run only once to download and load model into memory
img_path = &#39;./imgs/11.jpg&#39;
result = ocr.ocr(img_path, cls=True)
for idx in range(len(result)):
    res = result[idx]
    for line in res:
        print(line)

# 显示结果
from PIL import Image
result = result[0]
image = Image.open(img_path).convert(&#39;RGB&#39;)
boxes = [line[0] for line in result]
txts = [line[1][0] for line in result]
scores = [line[1][1] for line in result]
im_show = draw_ocr(image, boxes, txts, scores, font_path=&#39;./fonts/simfang.ttf&#39;)
im_show = Image.fromarray(im_show)
im_show.save(&#39;result.jpg&#39;)
```
结果是一个list，每个item包含了文本框，文字和识别置信度。
如果输入是PDF文件，那么可以参考下面代码进行可视化：
```
from paddleocr import PaddleOCR, draw_ocr

# Paddleocr目前支持的多语言语种可以通过修改lang参数进行切换
# 例如`ch`, `en`, `fr`, `german`, `korean`, `japan`
PAGE_NUM = 10 # 将识别页码前置作为全局，防止后续打开pdf的参数和前文识别参数不一致 / Set the recognition page number
pdf_path = &#39;default.pdf&#39;
ocr = PaddleOCR(use_angle_cls=True, lang=&#34;ch&#34;, page_num=PAGE_NUM)  # need to run only once to download and load model into memory
# ocr = PaddleOCR(use_angle_cls=True, lang=&#34;ch&#34;, page_num=PAGE_NUM,use_gpu=0) # 如果需要使用GPU，请取消此行的注释 并注释上一行 / To Use GPU,uncomment this line and comment the above one.
result = ocr.ocr(pdf_path, cls=True)
for idx in range(len(result)):
    res = result[idx]
    if res == None: # 识别到空页就跳过，防止程序报错 / Skip when empty result detected to avoid TypeError:NoneType
        print(f&#34;[DEBUG] Empty page {idx&#43;1} detected, skip it.&#34;)
        continue
    for line in res:
        print(line)
# 显示结果
import fitz
from PIL import Image
import cv2
import numpy as np
imgs = []
with fitz.open(pdf_path) as pdf:
    for pg in range(0, PAGE_NUM):
        page = pdf[pg]
        mat = fitz.Matrix(2, 2)
        pm = page.get_pixmap(matrix=mat, alpha=False)
        # if width or height &gt; 2000 pixels, don&#39;t enlarge the image
        if pm.width &gt; 2000 or pm.height &gt; 2000:
            pm = page.get_pixmap(matrix=fitz.Matrix(1, 1), alpha=False)
        img = Image.frombytes(&#34;RGB&#34;, [pm.width, pm.height], pm.samples)
        img = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
        imgs.append(img)
for idx in range(len(result)):
    res = result[idx]
    if res == None:
        continue
    image = imgs[idx]
    boxes = [line[0] for line in res]
    txts = [line[1][0] for line in res]
    scores = [line[1][1] for line in res]
    im_show = draw_ocr(image, boxes, txts, scores, font_path=&#39;doc/fonts/simfang.ttf&#39;)
    im_show = Image.fromarray(im_show)
    im_show.save(&#39;result_page_{}.jpg&#39;.format(idx))
```

要使用滑动窗口进行光学字符识别（OCR），可以使用以下代码片段：
```
from paddleocr import PaddleOCR
from PIL import Image, ImageDraw, ImageFont

# 初始化OCR引擎
ocr = PaddleOCR(use_angle_cls=True, lang=&#34;en&#34;)

img_path = &#34;./very_large_image.jpg&#34;
slice = {&#39;horizontal_stride&#39;: 300, &#39;vertical_stride&#39;: 500, &#39;merge_x_thres&#39;: 50, &#39;merge_y_thres&#39;: 35}
results = ocr.ocr(img_path, cls=True, slice=slice)

# 加载图像
image = Image.open(img_path).convert(&#34;RGB&#34;)
draw = ImageDraw.Draw(image)
font = ImageFont.truetype(&#34;./doc/fonts/simfang.ttf&#34;, size=20)  # 根据需要调整大小

# 处理并绘制结果
for res in results:
    for line in res:
        box = [tuple(point) for point in line[0]]
        # 找出边界框
        box = [(min(point[0] for point in box), min(point[1] for point in box)),
               (max(point[0] for point in box), max(point[1] for point in box))]
        txt = line[1][0]
        draw.rectangle(box, outline=&#34;red&#34;, width=2)  # 绘制矩形
        draw.text((box[0][0], box[0][1] - 25), txt, fill=&#34;blue&#34;, font=font)  # 在矩形上方绘制文本

# 保存结果
image.save(&#34;result.jpg&#34;)
```


---

> 作者:   
> URL: http://localhost:1313/%E4%B8%8D%E4%BD%9C%E4%B8%BAblog%E7%9A%84md/%E7%A8%8B%E5%BA%8F%E5%8D%9A%E5%AE%A2/paddleocr/  

