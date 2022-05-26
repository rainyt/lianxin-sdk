import haxe.crypto.Md5;
import haxe.macro.Compiler;
import CoreVideoAd;

/**
 * 连信SDK
 */
class LXSdk {
	static function main() {}

	/**
	 * 初始化连信SDK
	 */
	public static function init():Void {
		untyped window.onShareAppMessage = function() {
			trace('onShareAppMessage----------------------------');
			return {
				shareType: 0,
				authorIcon: Compiler.getDefine("authorIcon"), // 作者头像，如果没有就传应用icon
				authorName: Compiler.getDefine("authorName"), // 作者名称，如果没有就传应用名称
				linkUrl: Compiler.getDefine("linkUrl"), // 点击分享卡片需要跳转的链接
				subject: Compiler.getDefine("subject"), // 分享卡片的标题
				desc: Compiler.getDefine("desc"), // 分享卡片的summary
				iconUrl: Compiler.getDefine("iconUrl") // 分享卡片上的icon
			};
		}

		var args:Dynamic = {};
		// 设置窗口样式仅支持"fullscreen","statusbar","actionbar"三种样式
		args.windowStyle = "fullscreen";
		// 悬浮菜单及系统状态栏信息颜色，仅支持"#ffffff"或"#000000"
		// args.colorStyle = "#ffffff";
		// 窗口颜色，statusbar和actionbar的颜色，仅对statusbar和actionbar样式时有效
		// args.windowColor = windowColor;
		// 是否将页面设置为横屏，true横屏，false竖屏
		args.isLandscape = false;
		// 使用应用期间是否需要保持屏幕常亮，true常亮，false无需常亮（版本覆盖中）
		args.keepScreenOn = true;
		if (untyped window.LxUIWindow != null)
			LxUIWindow.setWindowStyle(haxe.Json.stringify(args));

		untyped document.addEventListener('deviceready', function() {
			// 为确保config成功，请将lx.config方法在此处调用
			trace("连信deviceready");
			var req = {
				thirdAppId: Compiler.getDefine("lxappid"),
				timestamp: Std.string(Date.now().getTime()), // 注意,不要用long,要使用字符串
				nonceStr: 'random123', // 例如:a234567890
				jsApiList: [] // 若想使用广告api,不需要加入jsApiList
			};
			putSign(req, function(reqParam) {
				trace("连信鉴权数据：", reqParam);
				LX.config(reqParam, function(data) {
					trace("连信鉴权结果：", data);
					if (data.retCd == '0') {
						// 鉴权成功
						// 连信登录
						LX.login({
							appId: Compiler.getDefine("lxappid"),
							key: Compiler.getDefine("lxclientkey"),
							scope: "BASE",
							scene: "Main"
						}, function(data) {
							trace("连信登录结果：", data);
							// 获取AccessToken
							LXApi.getAccessToken(data.code, function(data) {
								trace("连信登录OID：", data);
								UserData.userInfo.openid = data.obj.data.oid;
							});
						});
					} else {
						// 鉴权失败
					}
				});
			});
		}, false);
	}

	public static function putSign(req:Dynamic, cb:Dynamic->Void):Void {
		LXApi.getClientSignKey(req.nonceStr, function(data) {
			trace("连信Sign=", data);
			if (data.code == 0) {
				req.signature = data.obj.data.sign;
				req.timestamp = Std.string(data.obj.data.time);
				cb(req);
			} else {
				cb(null);
			}
		});
		// req.signature = Md5.encode(req.nonceStr + req.timestamp + "02f2b244edd411eb94bd525400c34b90");
	}
}
