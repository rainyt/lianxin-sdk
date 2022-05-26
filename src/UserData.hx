import zygame.cmnt.data.BaseUserData;
import zygame.cmnt.API;
import zygame.cmnt.callback.CmntCallBackData;

@:keep
class UserData implements BaseUserData {
	/**
	 * 通过用户数据方法创建获取
	 */
	public static var userInfo:Dynamic = {guest: false,sex: 0};

	private static var _resettime:Int = 0;

	public function new() {
		
	}

	/**
	 * 获取用户ID，唯一ID
	 * @return String
	 */
	public function getOpenID():String {
		return Std.string(userInfo.openid);
	}

	/**
	 * 获取用户名
	 * @return String
	 */
	public function getNickName():String {
		return "游客玩家";
	}

	/**
	 * 获取头像地址
	 * @return String
	 */
	public function getAvatar():String {
		return null;
	}

	/**
	 * 获取性别女=0，男=1，保密=2
	 * @return String
	 */
	public function getSex():String {
		if (userInfo.sex == 0)
			return "2";
		return userInfo.sex == 1 ? "1" : "0";
	}

	/**
	 * 是否为游客模式
	 * @return Bool
	 */
	public function isGuest():Bool {
		return false;
	}

}
