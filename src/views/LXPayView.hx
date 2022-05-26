package views;

import zygame.components.ZBuilderScene;

@:build(zygame.macro.AutoBuilder.build("LXPayView"))
class LXPayView extends ZBuilderScene {
	/**
	 * 发起支付通道，alipay_app支付宝支付，shengpay_app连信钱包支付，wx_app微信支付 
	 */
	public var payList:Array<String> = [];

	/**
	 * 支付回调
	 */
	public var onPayEvent:String->Void;

	override function onBuilded() {
		super.onBuilded();
		this.close.clickEvent = this.releaseScene;
		this.lianxin.clickEvent = function() {
			onPayEvent("shengpay_app");
		}
		this.weixin.clickEvent = function() {
			onPayEvent("wx_app");
		}
		this.zfb.clickEvent = function() {
			onPayEvent("alipay_app");
		}

		this.lianxin.visible = payList.indexOf("shengpay_app") != -1;
		this.weixin.visible = payList.indexOf("wx_app") != -1;
		this.zfb.visible = payList.indexOf("alipay_app") != -1;

		var array = [];
		if (this.lianxin.visible) {
			array.push(this.lianxin);
		}
		if (this.weixin.visible) {
			array.push(this.weixin);
		}
		if (this.zfb.visible) {
			array.push(this.zfb);
		}

		if (array.length == 2) {
			array[0].x = (getStageWidth() - array[0].width) / 2 - array[0].width * 1.1;
			array[1].x = (getStageWidth() - array[1].width) / 2 + array[1].width * 1.1;
		} else if (array.length == 1) {
			array[0].x = (getStageWidth() - array[0].width) / 2;
		}
	}
}
