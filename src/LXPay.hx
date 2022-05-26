import zygame.core.Start;
import views.LXPayView;
import zygame.components.ZModel;
import js.pay.base.BasePay;

/**
 * 连信支付
 */
class LXPay extends BasePay {
	override function pay(code:Int) {
		LX.getPaySupportPlatform(function(data:Array<String>) {
			trace("连信支付列表：", data);
			if (data == null || data.length == 0) {
				ZModel.showTextModel("暂不支持支付购买");
				return;
			}
			var view = new LXPayView();
			view.payList = data;
			view.onPayEvent = function(payTag) {
				var data = sdk.getPayCodeObject("Base", code);
				LXApi.createOrderId(payTag, data.price, data.name + "(" + data.desc + ")", function(data) {
					trace("连信订单数据：", data.data);
					if (data.code == 0) {
						// 开始支付
						var reqData = data.obj.data;
						LX.pay("pay", payTag, reqData, function(data) {
							trace("连信支付结果：", data);
							this.sdk.onPayPost(data.code == 0, code);
							if (data.code == 0) {
								view.releaseScene();
							} else {
								ZModel.showTextModel("支付失败：" + data.msg);
							}
						});
					} else {
						ZModel.showTextModel("创建订单失败，请稍后再试");
					}
				});
			}
			Start.current.getTopView().addChild(view);
		});
	}
}
