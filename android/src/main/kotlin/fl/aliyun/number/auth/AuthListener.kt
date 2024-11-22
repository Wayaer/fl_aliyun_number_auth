package fl.aliyun.number.auth

import android.content.Context
import android.content.Intent
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.mobile.auth.gatewayauth.ActivityResultListener
import com.mobile.auth.gatewayauth.AuthUIControlClickListener
import com.mobile.auth.gatewayauth.PreLoginResultListener
import com.mobile.auth.gatewayauth.TokenResultListener
import io.flutter.plugin.common.MethodChannel

class AuthListener(
    val channel: MethodChannel
) : TokenResultListener, PreLoginResultListener, ActivityResultListener, AuthUIControlClickListener {
    var result: MethodChannel.Result? = null
    val gson = Gson();

    override fun onTokenSuccess(s: String?) {
        println("onTokenSuccess: $s")
        resultSuccess(mapOf("code" to s, "isFailed" to false))
    }

    override fun onTokenFailed(s: String?, s1: String?) {
        println("onTokenFailed=2: $s =$s1")
        resultSuccess(mapOf("code" to s, "isFailed" to true, "msg" to s1))
    }

    override fun onTokenFailed(str: String?) {
        println("onTokenFailed=1: $str")
        val mapType = object : TypeToken<Map<String, Any>>() {}.type
        val map: Map<String, Any> = gson.fromJson(str, mapType)
        resultSuccess(mapOf("isFailed" to true) + map)
    }

    override fun onActivityResult(requestCode: Int, code: Int, data: Intent?) {
        channel.invokeMethod(
            "onActivityResult", mapOf("requestCode" to requestCode, "code" to code, "data" to data?.data)
        )
    }

    override fun onClick(code: String?, context: Context?, jsonString: String?) {
        channel.invokeMethod("onAuthUIClick", mapOf("code" to code, "json" to jsonString))
    }

    private fun resultSuccess(any: Any?) {
        result?.success(any)
        this.result = null
    }
}
