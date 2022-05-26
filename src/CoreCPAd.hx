import haxe.macro.Compiler;
import js.ad.base.BaseAd;

/**
 * 插屏广告
 */
class CoreCPAd extends BaseAd {
	override function show() {
		super.show();
		trace("连信插屏尝试展示");
		var ad = LxAdView.createNewInterstitialAd({adUnitId: Compiler.getDefine("adPosId")});
		ad.onLoad = function() {
			trace("连信插屏展示");
			ad.show(function(res) {});
		}
		ad.onError = function(res) {
			trace("连信插屏加载失败", res);
		}
	}
}
