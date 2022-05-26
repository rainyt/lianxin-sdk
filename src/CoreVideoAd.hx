package;

import zygame.components.ZModel;
import haxe.macro.Compiler;
import LxAdView.LxVideoAd;
import js.ad.base.BaseVideoAd;

/**
 * 连信视频组件实现
 */
class CoreVideoAd extends BaseVideoAd {
	private var _isReady:Bool = false;
	private var _video:LxVideoAd;

	/**
	 * 是否支持视频广告
	 */
	private var _isSupportVideoAd:Bool = true;

	override function init() {
		super.init();
	}

	private function _onLoadShow() {
		if (_video != null)
			return;
		_video = LxAdView.createRewardedVideoAd({
			adUnitId: Compiler.getDefine("videoPosId")
		});
		_video.onLoad = function(res) {
			trace("连信视频加载完成：", res);
			_isReady = true;
			_video.show(function(res) {});
		}
		_video.onError = function(res) {
			trace("连信视频加载失败：", res);
			_isReady = false;
			this.onError("无法加载视频广告");
			_video = null;
			ZModel.showTextModel("暂无广告，请稍后再试");
		}
		_video.onClose = function(res) {
			trace("连信视频关闭：", res);
			this.onReward(res.isEnded);
			_video = null;
		}
	}

	private var _inited = false;

	override function show() {
		if (!_inited) {
			trace("连信视频初始化");
			LX.getDeviceInfo(function(data) {
				trace("数据：", data);
				var version:String = data.appVerName;
				if (version == null) {
					// 直接不支持
					_isSupportVideoAd = false;
					return;
				}
				// var array = version.split(".");
				// var checkArray = [5, 0, 16];
				// trace("版本确认：", array, ">=", checkArray);
				// for (index => value in array) {
				// 	if (Std.parseInt(value) < checkArray[index]) {
				// 		_isSupportVideoAd = false;
				// 		trace("不支持视频广告的版本");
				// 		return;
				// 	}
				// }
				if (!_isSupportVideoAd) {
					this.onReward(true);
				} else
					_onLoadShow();
				_inited = true;
			});
		} else {
			// 不支持视频广告的低版本连信，直接放发奖励
			if (!_isSupportVideoAd) {
				this.onReward(true);
			} else
				_onLoadShow();
		}
	}

	override function isReady():Bool {
		return _isSupportVideoAd;
	}
}
