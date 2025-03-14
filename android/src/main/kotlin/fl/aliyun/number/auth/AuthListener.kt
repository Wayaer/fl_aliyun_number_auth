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

class AuthListener(private val channel: MethodChannel) : TokenResultListener, PreLoginResultListener, ActivityResultListener, AuthUIControlClickListener {
    private val gson = Gson()

    override fun onTokenSuccess(str: String?) {
        onAuthResult(toMap(str))
    }

    override fun onTokenFailed(s: String?, s1: String?) {
        onAuthResult(toMap(s) + mapOf("isFailed" to true, "msg" to s1))
    }

    override fun onTokenFailed(str: String?) {
        onAuthResult(toMap(str) + mapOf("isFailed" to true))
    }

    override fun onActivityResult(requestCode: Int, code: Int, data: Intent?) {
        channel.invokeMethod("onActivityResult", mapOf("requestCode" to requestCode, "code" to code, "data" to data?.data?.toString()))
    }

    override fun onClick(code: String?, context: Context?, jsonString: String?) {
        channel.invokeMethod("onAuthUIClick", mapOf("code" to code, "json" to jsonString))
    }

    private fun onAuthResult(any: Any?) {
        channel.invokeMethod("onAuthResult", any)
    }

    private fun toMap(str: String?): Map<String, Any?> {
        if (isJson(str)) {
            val mapType = object : TypeToken<Map<String, Any?>>() {}.type
            return gson.fromJson(str, mapType)
        } else {
            return mapOf<String, Any?>("code" to "600000", "msg" to str)
        }
    }

    private fun isJson(str: String?): Boolean {
        val jsonPattern = """^[{\[](.|\n)*[}\]]$""".toRegex()
        return str?.matches(jsonPattern) ?: false
    }

}
