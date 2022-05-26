/**
 * SDK原生SDK
 */
@:native("lx")
extern class LX {
	/**
	 * 支付
	 * @param scene 支付场景
	 * @param platform 支付平台
	 * @param orderInfo 订单数据
	 * @param cb 支付回调
	 */
	public static function pay(scene:String, platform:String, orderInfo:Dynamic, cb:Dynamic->Void):Void;

	/**
	 * 初始化接口
	 * @param data 
	 * @param cb 
	 */
	public static function config(data:Dynamic, cb:Dynamic->Void):Void;

	/**
	 * 登录接口
	 * @param data 
	 * @param call 
	 */
	public static function login(data:{
		appId:String,
		key:String,
		scope:String,
		scene:String
	}, call:Dynamic->Void):Void;

	/**
	 * 获取支付环境
	 * @return String
	 */
	public static function getVendorId():String;

	/**
	 * 获取支付平台列表
	 * @param cb 
	 */
	public static function getPaySupportPlatform(cb:Dynamic->Void):Void;

	/**
	 * 获取设备信息
	 */
	public static function getDeviceInfo(cb:Dynamic->Void):Void;
}
