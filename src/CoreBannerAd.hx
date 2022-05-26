import haxe.macro.Compiler;
import LxAdView.LxBannerAd;
import js.ad.base.BaseBannerAd;

/**
 * BannerAd广告
 */
class CoreBannerAd extends BaseBannerAd {
	private var _bannerAd:LxBannerAd;
	private var _isShow:Bool = false;

	override function init() {
		super.init();
	}

	override function show() {
		super.show();
		_isShow = true;
		if (_bannerAd != null) {
			_bannerAd.show(function(res) {});
			return;
		}
		_bannerAd = LxAdView.createFootBannerAd({adUnitId: Compiler.getDefine("bannerPosId")});
		_bannerAd.onLoad = function(res) {
			trace("连信横幅展示", res);
			if (_isShow)
				_bannerAd.show(function(res) {});
		}
		_bannerAd.onError = function(res) {
			trace("连信横幅错误：", res);
			_bannerAd = null;
		}
	}

	override function close() {
		super.close();
		_isShow = false;
		if (_bannerAd != null) {
			trace("连信横幅关闭");
			_bannerAd.hide(function(res) {});
			// _bannerAd = null;
		}
	}
}
