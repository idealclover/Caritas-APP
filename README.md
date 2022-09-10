# Caritas

<p align="center">
<img src="./res/icon.png" alt="Caritas" width="100">
</p>
<h1 align="center">Caritas</h1>
<p align="center">
<a href="https://zhuanlan.zhihu.com/p/556201282">使用说明&下载地址</a>
</p>

> 🔥 于浩歌狂热之际中寒；于天上看见深渊。于一切眼中看见无所有；于无所希望中得救。


## Demo

<p align="center">
<img src="https://image.idealclover.cn/blog/635/1.png" alt="Caritas" width="400">
</p>
<p align="center">
<img src="https://image.idealclover.cn/blog/635/2.png" alt="Caritas" width="400">
</p>
<p align="center">
<img src="https://image.idealclover.cn/blog/635/3.png" alt="Caritas" width="400">
</p>
<p align="center">
<img src="https://image.idealclover.cn/blog/635/4.png" alt="Caritas" width="400">
</p>
<p align="center">
<img src="https://image.idealclover.cn/blog/635/5.png" alt="Caritas" width="400">
</p>

## 开发攻略

### 环境构建

项目整体使用 [Flutter](https://flutter.dev/) 框架（[中文站](https://flutter.cn/)），环境搭建可参考相关说明

### 项目结构

```
├─ analysis_options.yaml --语法检查 把一些lint rules 关了
├─ android --安卓原生
│  ├─ app --需要动原生代码的话这里下刀
│  ├─ build.gradle --gradle build脚本
│  ├─ key.properties --配置文件，需要自己新建哦
│  ├─ ...
├─ api --需要部署到服务器上的静态文件
│  ├─ android.json --安卓版本检查文件
│  ├─ database.json --服务器版本检查文件
│  ├─ ios.json --iOS版本检查文件
│  └─ privacy.json --隐私协议文件
├─ ios --iOS原生
│  ├─ Podfile --iOS描述文件，如果需要额外权限需要改这里
│  ├─ Runner --需要动原生代码的话这里下刀
│  ├─ Runner.xcworkspace --iOS主工程，XCode开这个
│  └─ ...
├─ lib --这里是主要代码
│  ├─ Components --功能组件
│  │ ├─ ArticleList.dart --文章列表公共组件
│  │ ├─ ArticleListItem.dart --列表中的item
│  │ ├─ Dialog.dart --公共弹窗组件
│  │ ├─ DownloadDialog.dart --数据库更新弹窗
│  │ ├─ Drawer.dart --侧抽屉公共组件
│  │ ├─ Markdown.dart --markdown渲染组件
│  │ ├─ SnackBar.dart --弹出snackbar公共组件
│  │ ├─ Toast.dart --Toast公共组件（已不用）
│  │ └─ TransBgTextButton.dart --为了适配黑夜模式的按钮
│  ├─ Libs --魔改过的本地用lib
│  │ ├─ cloud_kit
│  │ ├─ flutter-search-bar
│  │ └─ umeng_common_sdk
│  ├─ Models --数据结构（公共M层）
│  │ ├─ Db --文章、分类hive表结构
│  │ │ ├─ DbHelper.dart
│  │ │ └─ DbHelper.g.dart --自动生成的文件
│  │ └─ HomeCategoryModel.dart --分类的对象
│  ├─ Pages --页面（V层/P层）
│  │ ├─ About --关于
│  │ ├─ Article --文章浏览页面
│  │ ├─ Favorite --收藏列表页
│  │ ├─ History --历史列表页
│  │ ├─ HomePage --首页
│  │ ├─ Settings --设置页
│  │ └─ Sync --设置-同步数据二级页面
│  ├─ Resources --静态资源
│  │ ├─ Config.dart --这个需要复制sample哦
│  │ ├─ Config.sample.dart
│  │ ├─ Constant.dart
│  │ └─ Themes.dart
│  ├─ Utils --工具类
│  │ ├─ DataSyncUtil.dart --数据同步相关函数
│  │ ├─ InitUtil.dart --启动时调用的方法
│  │ ├─ PrivacyUtil.dart --校验隐私协议
│  │ ├─ SettingsUtil.dart --设置中需要的工具函数
│  │ ├─ ThemeUtil.dart --主题切换工具函数
│  │ ├─ URLUtil.dart --外部链接打开工具函数
│  │ ├─ UmengUtil.dart --友盟统计工具函数
│  │ ├─ UpdateUtil.dart --更新弹窗工具函数
│  │ └─ VersionUtil.dart --获取当前包版本
│  ├─ generated --自动生成的i18n文件
│  ├─ l10n --文案在这里设置
│  │ ├─ intl_en.arb
│  │ └─ intl_zh.arb
│  ├─ main.dart --主函数入口
│  └─ ...
├─ linux --Linux原生
├─ macos --MacOS原生
│  ├─ Podfile --MacOS描述文件，如果需要额外权限需要改这里
│  ├─ Runner --需要动原生代码的话这里下刀
│  ├─ Runner.xcworkspace --MacOS主工程，XCode开这个
│  ├─ appdmg --用来生成dmg包
│  │ ├─ appdmg.json --appdmg设置文件
│  │ └─ ...
│  └─ ...
├─ pubspec.yaml --pub文件
├─ res --资源文件
│  ├─ data.json --数据库
│  └─ icon.png --图标
├─ script --其他脚本
│  ├─ audio.py --声音处理脚本
│  ├─ delete_empty.py --文件处理脚本
│  └─ main.py --数据库打包脚本
├─ test --测试函数（TBD）
│  └─ widget_test.dart
├─ web --Web原生
│  ├─ index.html
│  └─ ...
├─ windows --Windows原生
│  ├─ runner
│  └─ ...
└─ ...
```

### 运行前准备

* 在 Android Studio 中安装 flutter 和 flutter intl 插件
* 复制 `lib/Resources/Config.sample.dart` 并~~乱写一气~~
* 安卓打包：自己生成 `key.properties` 或 在 `build.gradle` 中进行豁免
* 剩下的，就等项目运行起来再探索吧 :)

### 计划 Feature

- [ ] 字号修改（P2）
- [ ] 更新推送通知
- [ ] 接入azure tts
- [ ] 跨端复制 https://github.com/flutter/flutter/issues/99819
- [x] 各端初版发布
- [x] 接入友盟埋点
- [x] 历史功能
- [x] 已读标记

## Open-source Licenses

[MIT License](./LICENSE), have fun coding.

Long Live Open Source.
