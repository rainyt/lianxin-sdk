import zygame.cmnt.Cmnt;
import zygame.cmnt.callback.CmntCallBackData;
import zygame.cmnt.v3.V3Api;

/**
 * 连信API
 */
class LXApi {
	/**
	 * 获取AccessToken
	 * @param code 
	 * @param cb 
	 */
	public static function getAccessToken(code:String, cb:CmntCallBackData->Void):Void {
		V3Api.getAPI("third/nl/line/getAccessToken", ["str" => code], cb);
	}

	/**
	 * 获取客户端签名
	 * @param cb 
	 */
	public static function getClientSignKey(key:String, cb:CmntCallBackData->Void):Void {
		V3Api.getAPI("third/nl/line/getClientSign", ["str" => key], cb);
	}

	/**
	 * 创建订单
	 * @param tradeType 支付类型
	 * @param totalFee 价格，单位：分
	 * @param desc 物品描述
	 * @param cb 回调
	 * @param attach 物品备注
	 */
	public static function createOrderId(tradeType:String,totalFee:Int, desc:String, cb:CmntCallBackData->Void, attach:String = "无"):Void {
		var openid = Cmnt.userData.getOpenID();
		if (openid == null)
			openid = V3Api.getOpenID();
		V3Api.getAPI("third/nl/line/unifiedOrder", [
			"totalFee" => Std.string(totalFee),
			"tradeType" => tradeType,
			"body" => desc,
			"attach" => attach,
			"unionId" => openid,
			"vendorId" => LX.getVendorId()
		], cb);
	}
}
