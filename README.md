<p align="center">
<img src="./res/icon.png" alt="Caritas" width="100">
</p>
<h1 align="center">Caritas</h1>

> 🔥 于浩歌狂热之际中寒；于天上看见深渊。于一切眼中看见无所有；于无所希望中得救。

想写这样的一款 APP，于是就写了。

> 感谢 @大卫 提供的 1.0 版本、图标等关键信息
> 感谢 @g9qad @nell nell 的内容授权
> 感谢 @阿寜寜 @流水浮灯 提供的笔记文件

在之前大卫的 [Caritas 1.0](https://zhuanlan.zhihu.com/p/488034619) 版本上进行了整体的重构，希望能将这样一些引人启发的回答，以最纯净的形式带给你。

依旧使用 flutter 架构，因此通过一套代码在 ```安卓/iOS/MacOS/Windows/Web``` 各端上都进行了支持，在最后附上了各端的安装方式。

# 功能说明

一句话说明：将部分答主（当前 @g9qad 和 @nell nell）的内容做成了单独的 APP，分门别类进行整理，以供离线使用与阅读

![](https://image.idealclover.cn/blog/635/1.png)

那，和 1.0 相比，主要更新了哪些内容呢？

首先由原来仅支持安卓/iOS（企业签名）变为了移动端/电脑端/网页端均支持的形式，可以在不同操作系统的手机/平板/电脑上以统一的体验使用。

![](https://image.idealclover.cn/blog/635/2.png)

之后，与 1.0 版本一致，作为一个纯客户端的应用，所有的内容都将存储在本地，不需要联网（没错，好几次出差的飞机上，这个 APP 都陪伴过度过了整个航班）

但不同的是，这次支持了数据的热更新，这意味着我会随着上游数据的更新（感谢 @阿寜寜 的 [AaNingNing/Sth-Matters](https://github.com/AaNingNing/Sth-Matters) 与 [AaNingNing/Nell-Nell](https://github.com/AaNingNing/Nell-Nell) 两个数据源）随之更新数据，更新后最新的数据依旧会存放在您的本地，不必担心后续变数

![](https://image.idealclover.cn/blog/635/3.png)

此外，为了最大程度优化长文字的阅读体验，也进行了一些工作。支持了已读标记、历史记录查看、收藏等功能，支持自定义颜色主题，同时为了更好地在夜晚阅读（社畜不配拥有白天 QAQ）支持了暗色模式，并能随系统自动切换模式或手动调整。

![](https://image.idealclover.cn/blog/635/4.png)

以及考虑到不同设备间的数据同步问题，支持将当前的收藏与历史阅读记录通过文件或二维码的形式进行导入导出；针对 iOS 设备额外支持了通过 iCloud 进行跨设备同步的方式（不过由于技术与苹果同步机制原因，暂未做成自动同步，需要手动出发）

![](https://image.idealclover.cn/blog/635/5.png)

最后，全项目代码以 MIT License 开源在 [Github-idealclover/Caritas-APP](https://github.com/idealclover/Caritas-APP) 上，可以进行查看与修改，也欢迎有能力的朋友帮助进行代码优化与功能扩展。

如果在使用过程中有任何问题，可以在应用内通过 QQ 与我进行联系，或直接通过知乎私信或进行评论。如果觉得好用，也欢迎您的分享与其他支持！

# 安装说明

为了避免使用其他渠道分发带来的不可控性，尽可能使用了自己自费的 CDN 进行分发，速度可能会稍慢点，希望大家理解 hh

## 移动端 - 安卓

> 由于安卓应用商店众多且审核标准不一致，信息类 APP 也比较难过审，因此直接使用 apk 形式进行应用分发

下载地址：http://cdn.idealclover.cn/Projects/caritas/caritas_android_latest.apk

由于现在各安卓厂商的拦截、限制策略，可能会在安装 APP 时引导“去应用商店安装”，忽略即可（估计大家也都已经习惯了吧 = =|||）

另外，之前安装过 Caritas 1.0 版本的朋友，由于包名、签名不一致，因此可能会看到两个版本在手机并存的情况，属正常现象

## 移动端 - iOS

> 由于 iOS 正式版被苹果应用商店以 4.2.2 理由拒审，因此暂时使用 testflight 进行发布，限额 1000 先使用先得（应该不会满员吧）
> 
> 如果你了解如何进一步修改以过审，也欢迎来联系我，需要你的帮助。

使用地址：https://testflight.apple.com/join/XBsy7KXQ

之前使用过 testflight 的朋友估计会比较熟悉了，点击链接直接可以参与测试、安装APP；没有用过的朋友可能需要先根据引导下载一个 testflight（苹果官方的测试版本发布工具）

## 桌面端 - Windows

下载地址：http://cdn.idealclover.cn/Projects/caritas/caritas_windows_latest.exe

下载后按照安装引导步骤安装即可

## 桌面端 - MacOS

> Testflight 过审中（另外电脑端也不推荐使用 APPStore 安装软件，直接用 dmg 包吧）

下载地址：http://cdn.idealclover.cn/Projects/caritas/caritas_macos_latest.dmg

下载打开之后按安装流程将图标拖入 Applications 文件夹即可进行使用

## 网页端

> 提示：网页端由于需加载文件较大（10+M）且 flutter web 架构本身不够稳定，不推荐进行使用，使用过程中可能会出现更多未知 bug

网页链接：https://caritas.idealclover.cn/

直接使用浏览器打开即可

# 写在最后

并不是科班出身，目前做的也不是实际开发工作。写的代码也不过靠着自己的业余兴趣，如果性能上有问题，或者出现了奇奇怪怪的 bug，欢迎随时来找我反馈。

嗯，既然是兴趣，那就要“当女儿一般养起来”的。不会接入广告，也不会有收费，包括苹果开发者账号（688/年）在内也均为自费，你的点赞分享和使用就是我继续维护的最大动力嘿嘿。

以及，“鼓励利用此 APP 的代码盈利”——如果这些代码值得的话。

希望这个 APP 可以帮到你，至少，这些内容曾帮助过我自己，过去、现在、以及可能的未来。

所以我把这火炬，与你分享。
