# 连信SDK
连信的详细文档：https://open.lianxinapp.com/doc?id=6&vid=0

## 基础配置
需要在zproject.xml中进行配置：
```xml
<!-- 基础配置 -->
<define name="lxappid" value="连信APPID" />
<define name="lxclientkey" value="连信客户端KEY" />
<!-- 分享配置 -->
<define name="authorIcon" value="作者/公司图标，建议144*144"/>
<define name="authorName" value="作者/公司名称"/>
<define name="linkUrl" value="游戏发布地址"/>
<define name="subject" value="分享卡片上的标题"/>
<define name="desc" value="分享卡片上的描述"/>
<define name="iconUrl" value="游戏分享图标，建议144*144"/>
<!-- 广告配置 -->
<define name="videoPosId" value="视频广告位"/>
<define name="bannerPosId" value="横幅广告位"/>
<define name="adPosId" value="插屏广告位"/>
<!-- 支付组件导入，如果不绑定haxelib会无法生成支付组件功能 -->
<haxelib name="lianxin-sdk" bind="true" if="lianxin" />
```

## 初始化
需要在入口文件中，进行初始化：
```haxe
#if lianxin
LXSdk.init();
#end
```

## 广告SDK
连信支持视频、底部横幅、普通插屏3种类型的广告。

## 如何测试
打开连信app的扫指定的二维码。(注意连信app的版本号,低版本不支持)
附：生成专用二维码的在线工具: https://open.lianxinapp.com/utils/qr