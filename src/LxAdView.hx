/**
 * 连信广告组件
 */
extern class LxAdView {

	/**
	 * 创建一个横幅广告
	 */
	public static function createFootBannerAd(data:ADParam):LxBannerAd;

	/**
	 * 创建一个激励视频
	 */
	public static function createRewardedVideoAd(data:ADParam):LxVideoAd;

	/**
	 * 创建一个标准的插屏广告
	 * @param data 
	 * @return LxInterAd
	 */
	public static function createNewInterstitialAd(data:ADParam):LxInterAd;
}

typedef ADParam = {
	adUnitId:String
}

extern class LxInterAd extends BaseAd {
	public function show(cb:Dynamic->Void):Void;

	public function hide(cb:Dynamic->Void):Void;
}

extern class BaseAd {
	public var onLoad:Dynamic;

	public var onError:Dynamic;

	public var onClose:Dynamic;
}

extern class LxVideoAd extends BaseAd {
	public function show(cb:Dynamic->Void):Void;
}

extern class LxBannerAd extends BaseAd {
	public function show(cb:Dynamic->Void):Void;

	public function hide(cb:Dynamic->Void):Void;
}
