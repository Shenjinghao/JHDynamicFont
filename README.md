# JHDynamicFont
通过为UIFontDescriptor添加category方法实现动态改变指定控件（如UILabel UIButtonLabel等）的字体大小。

## 详细使用方法
[简书链接](http://www.jianshu.com/p/a1339d45a324)

## 已上传至cocoapods trunk

可以直接在终端使用下面命令来搜索

`
pod search JHDynamicFont
`

## Overview

![gif](https://github.com/Shenjinghao/JHDynamicFont/blob/master/snapshot/DynamicFont.gif)

- 2017年03月24日15:36:36   新增feature/MethodSwizzle分支，主要是利用runtime运行时包含的method swizzle来整体修改字体或者颜色等等
 - 想要了解的可以下载项目后直接切换到feature/MethodSwizzle分支，更新代码即可
```
git co feature/MethodSwizzle
git pull
```
