package fl.aliyun.number.auth

import android.content.Context
import android.content.Intent
import android.content.pm.ActivityInfo
import android.graphics.Typeface
import android.graphics.drawable.Drawable
import android.view.Gravity
import android.view.View
import android.widget.ImageView
import com.mobile.auth.gatewayauth.ActivityResultListener
import com.mobile.auth.gatewayauth.AuthUIConfig
import com.mobile.auth.gatewayauth.AuthUIControlClickListener
import com.mobile.auth.gatewayauth.PhoneNumberAuthHelper
import com.mobile.auth.gatewayauth.PnsLoggerHandler
import com.mobile.auth.gatewayauth.PreLoginResultListener
import com.mobile.auth.gatewayauth.TokenResultListener
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result


/** FlAliYunNumberAuthPlugin */
class FlAliYunNumberAuthPlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler,
    TokenResultListener, PreLoginResultListener, ActivityResultListener,
    AuthUIControlClickListener {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var authHelper: PhoneNumberAuthHelper

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fl_aliyun_number_auth")
        channel.setMethodCallHandler(this)
    }


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        authHelper = PhoneNumberAuthHelper.getInstance(binding.activity, this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private var result: Result? = null

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "setAuthSDKInfo" -> {
                this.result = result
                val args = call.arguments as Map<*, *>
                if (args["enableActivityResultListener"] as Boolean) {
                    authHelper.setActivityResultListener(this)
                }
                if (args["enableAuthUIControlClickListener"] as Boolean) {
                    authHelper.setUIClickListener(this)
                }
                authHelper.setAuthSDKInfo(args["secret"] as String)
            }

            "setLoggerInfo" -> {
                val args = call.arguments as Map<*, *>
                val reporter = authHelper.reporter
                reporter.setLoggerEnable(args["enable"] as Boolean)
                reporter.setUploadEnable(args["enableUpload"] as Boolean)
                if (args["enableHandler"] as Boolean) {
                    reporter.setLoggerHandler(mPnsLoggerHandler)
                }
                result.success(true)
            }

            "getLoginToken" -> {
                this.result = result
                val args = call.arguments as Map<*, *>
                authHelper.setAuthListener(this)
                authHelper.getLoginToken(context, args["timeout"] as Int)
            }

            "quitLoginPage" -> {
                authHelper.quitLoginPage()
                result.success(true)
            }

            "accelerateLoginPage" -> {
                this.result = result
                val args = call.arguments as Map<*, *>
                authHelper.accelerateLoginPage(args["timeout"] as Int, this)
            }

            "getVersion" -> {
                result.success(PhoneNumberAuthHelper.getVersion())
            }

            "checkEnvAvailable" -> {
                this.result = result
                val args = call.arguments as Map<*, *>
                authHelper.checkEnvAvailable(args["authType"] as Int)
            }

            "setCheckboxIsChecked" -> {
                val args = call.arguments as Map<*, *>
                authHelper.setProtocolChecked(args["isChecked"] as Boolean)
                result.success(true)
            }

            "queryCheckBoxIsChecked" -> {
                result.success(authHelper.queryCheckBoxIsChecked())
            }

            "hideLoginLoading" -> {
                authHelper.hideLoginLoading()
                result.success(true)
            }

            "getCurrentCarrierName" -> {
                result.success(authHelper.currentCarrierName)
            }

            "setAuthUI" -> setAuthUI(call, result)
            "quitPrivacyAlert" -> {
                authHelper.quitPrivacyPage()
                result.success(true)
            }

            /// 以下为android 特有
            "setAuthPageUseDayLight" -> {
                val args = call.arguments as Map<*, *>
                authHelper.setAuthPageUseDayLight(args["authPageUseDayLight"] as Boolean)
                result.success(true)
            }

            "closeAuthPageReturnBack" -> {
                val args = call.arguments as Map<*, *>
                authHelper.closeAuthPageReturnBack(args["close"] as Boolean)
                result.success(true)
            }

            "keepAuthPageLandscapeFullScreen" -> {
                val args = call.arguments as Map<*, *>
                authHelper.keepAuthPageLandscapeFullSreen(args["fullScreen"] as Boolean)
                result.success(true)
            }

            "clearPreInfo" -> {
                authHelper.clearPreInfo()
                result.success(true)
            }

            "userControlAuthPageCancel" -> {
                authHelper.userControlAuthPageCancel()
                result.success(true)
            }

            "prohibitUseUtdid" -> {
                authHelper.prohibitUseUtdid()
                result.success(true)
            }

            "expandAuthPageCheckedScope" -> {
                val args = call.arguments as Map<*, *>
                authHelper.expandAuthPageCheckedScope(args["expand"] as Boolean)
                result.success(true)
            }


            "addAuthRegisterViewConfig" -> addAuthRegisterViewConfig(call, result)
            "removeAuthRegisterViewConfig" -> {
                authHelper.removeAuthRegisterViewConfig()
                result.success(true)
            }

            "addAuthRegisterXmlConfig" -> addAuthRegisterXmlConfig(call, result)

            "removeAuthRegisterXmlConfig" -> {
                authHelper.removeAuthRegisterXmlConfig()
                result.success(true)
            }

            "addPrivacyRegisterXmlConfig" -> addPrivacyRegisterXmlConfig(call, result)

            "removePrivacyRegisterXmlConfig" -> {
                authHelper.removePrivacyRegisterXmlConfig()
                result.success(true)
            }

            "addPrivacyAuthRegisterViewConfig" -> addPrivacyAuthRegisterViewConfig(call, result)
            "removePrivacyAuthRegisterViewConfig" -> {
                authHelper.removePrivacyAuthRegisterViewConfig()
                result.success(true)
            }

            else -> result.notImplemented()
        }
    }

    private fun resultSuccess(any: Any?) {
        result?.success(any)
        this.result = null
    }

    private var mPnsLoggerHandler: PnsLoggerHandler = object : PnsLoggerHandler {
        override fun monitor(msg: String?) {
            channel.invokeMethod("onLoggerHandler", mapOf("level" to "monitor", "msg" to msg))
        }

        override fun verbose(msg: String?) {
            channel.invokeMethod("onLoggerHandler", mapOf("level" to "verbose", "msg" to msg))
        }

        override fun info(msg: String?) {
            channel.invokeMethod("onLoggerHandler", mapOf("level" to "info", "msg" to msg))
        }

        override fun debug(msg: String?) {
            channel.invokeMethod("onLoggerHandler", mapOf("level" to "debug", "msg" to msg))
        }

        override fun warning(msg: String?) {
            channel.invokeMethod("onLoggerHandler", mapOf("level" to "warning", "msg" to msg))
        }

        override fun error(msg: String?) {
            channel.invokeMethod("onLoggerHandler", mapOf("level" to "error", "msg" to msg))
        }

    }

    override fun onTokenSuccess(s: String?) {
        resultSuccess(mapOf("resultCode" to s, "isFailed" to false))
    }

    override fun onTokenFailed(s: String?, s1: String?) {
        resultSuccess(mapOf("resultCode" to s, "isFailed" to true, "msg" to s1))
    }

    override fun onTokenFailed(s: String?) {
        resultSuccess(mapOf("resultCode" to s, "isFailed" to true))
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        channel.invokeMethod(
            "onActivityResult",
            mapOf("requestCode" to requestCode, "resultCode" to resultCode, "data" to data?.data)
        )
    }

    override fun onClick(code: String?, context: Context?, jsonString: String?) {
        channel.invokeMethod("onAuthUIClick", mapOf("code" to code, "json" to jsonString))
    }

    private fun addAuthRegisterViewConfig(call: MethodCall, result: Result) {
        result.success(true)
    }

    private fun addAuthRegisterXmlConfig(call: MethodCall, result: Result) {
        result.success(true)
    }

    private fun addPrivacyRegisterXmlConfig(call: MethodCall, result: Result) {
        result.success(true)
    }

    private fun addPrivacyAuthRegisterViewConfig(call: MethodCall, result: Result) {
        result.success(true)
    }

    private fun setAuthUI(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val authUIConfigBuilder = AuthUIConfig.Builder()
        val statusBarUi = args["statusBarUi"] as Map<*, *>?
        if (statusBarUi != null) {
            (statusBarUi["statusBarColor"] as Int?)?.let { authUIConfigBuilder.setStatusBarColor(it) }
            (statusBarUi["lightColor"] as Boolean?)?.let { authUIConfigBuilder.setLightColor(it) }
            (statusBarUi["statusBarHidden"] as Boolean?)?.let {
                authUIConfigBuilder.setStatusBarHidden(it)
            }
            (statusBarUi["statusBarUIFlag"] as Int?)?.let {
                authUIConfigBuilder.setStatusBarUIFlag(systemUiFlag[it])
            }
            (statusBarUi["webViewStatusBarColor"] as Int?)?.let {
                authUIConfigBuilder.setWebViewStatusBarColor(it)
            }
        }
        val navUi = args["navUi"] as Map<*, *>?
        if (navUi != null) {
            (navUi["navColor"] as Int?)?.let { authUIConfigBuilder.setNavColor(it) }
            (navUi["navText"] as String?)?.let { authUIConfigBuilder.setNavText(it) }
            (navUi["navTextColor"] as Int?)?.let { authUIConfigBuilder.setNavTextColor(it) }
            (navUi["navTextSize"] as Int?)?.let { authUIConfigBuilder.setNavTextSizeDp(it) }
            (navUi["navTypeface"] as Int?)?.let { authUIConfigBuilder.setNavTypeface(typefaces[it]) }
            (navUi["navReturnImgPath"] as String?)?.let { authUIConfigBuilder.setNavReturnImgPath(it) }
            (navUi["navReturnHidden"] as Boolean?)?.let { authUIConfigBuilder.setNavReturnHidden(it) }
            (navUi["navHidden"] as Boolean?)?.let { authUIConfigBuilder.setNavHidden(it) }
            (navUi["webNavColor"] as Int?)?.let { authUIConfigBuilder.setWebNavColor(it) }
            (navUi["webNavTextColor"] as Int?)?.let { authUIConfigBuilder.setWebNavTextColor(it) }
            (navUi["webNavTextSize"] as Int?)?.let { authUIConfigBuilder.setWebNavTextSizeDp(it) }
            (navUi["webNavReturnImgPath"] as String?)?.let {
                authUIConfigBuilder.setWebNavReturnImgPath(it)
            }
            (navUi["bottomNavColor"] as Int?)?.let { authUIConfigBuilder.setBottomNavColor(it) }
            (navUi["navReturnImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setNavReturnImgDrawable(it)
            }
        }
        val logoUi = args["logoUi"] as Map<*, *>?
        if (logoUi != null) {
            (logoUi["logoHidden"] as Boolean?)?.let { authUIConfigBuilder.setLogoHidden(it) }
            (logoUi["logoImgPath"] as String?)?.let { authUIConfigBuilder.setLogoImgPath(it) }
            (logoUi["logoWidth"] as Int?)?.let { authUIConfigBuilder.setLogoWidth(it) }
            (logoUi["logoHeight"] as Int?)?.let { authUIConfigBuilder.setLogoHeight(it) }
            (logoUi["logoOffsetY"] as Int?)?.let { authUIConfigBuilder.setLogoOffsetY(it) }
            (logoUi["logoOffsetYB"] as Int?)?.let { authUIConfigBuilder.setLogoOffsetY_B(it) }
            (logoUi["logoScaleType"] as Int?)?.let { authUIConfigBuilder.setLogoScaleType(ImageView.ScaleType.entries[it]) }
        }
        val sloganUi = args["sloganUi"] as Map<*, *>?
        if (sloganUi != null) {
            (sloganUi["sloganText"] as String?)?.let { authUIConfigBuilder.setSloganText(it) }
            (sloganUi["sloganTextColor"] as Int?)?.let { authUIConfigBuilder.setSloganTextColor(it) }
            (sloganUi["sloganTextSize"] as Int?)?.let { authUIConfigBuilder.setSloganTextSizeDp(it) }
            (sloganUi["sloganOffsetY"] as Int?)?.let { authUIConfigBuilder.setSloganOffsetY(it) }
            (sloganUi["sloganOffsetYB"] as Int?)?.let { authUIConfigBuilder.setSloganOffsetY_B(it) }
            (sloganUi["sloganTypeface"] as Int?)?.let {
                authUIConfigBuilder.setSloganTypeface(typefaces[it])
            }
        }
        val numberUi = args["numberUi"] as Map<*, *>?
        if (numberUi != null) {
            (numberUi["numberColor"] as Int?)?.let { authUIConfigBuilder.setNumberColor(it) }
            (numberUi["numberTextSize"] as Int?)?.let { authUIConfigBuilder.setNumberSizeDp(it) }
            (numberUi["numFieldOffsetY"] as Int?)?.let { authUIConfigBuilder.setNumFieldOffsetY(it) }
            (numberUi["numFieldOffsetYB"] as Int?)?.let {
                authUIConfigBuilder.setNumFieldOffsetY_B(it)
            }
            (numberUi["numberFieldOffsetX"] as Int?)?.let {
                authUIConfigBuilder.setNumberFieldOffsetX(it)
            }
            (numberUi["numberLayoutGravity"] as Int?)?.let {
                authUIConfigBuilder.setNumberLayoutGravity(gravity[it])
            }
            (numberUi["numberTypeface"] as Int?)?.let {
                authUIConfigBuilder.setNumberTypeface(typefaces[it])
            }
            (numberUi["numberTextSpace"] as Float?)?.let { authUIConfigBuilder.setNumberTextSpace(it) }
        }
        val loginBtnUi = args["loginBtnUi"] as Map<*, *>?
        if (loginBtnUi != null) {
            (loginBtnUi["logBtnText"] as String?)?.let { authUIConfigBuilder.setLogBtnText(it) }
            (loginBtnUi["logBtnTextColor"] as Int?)?.let { authUIConfigBuilder.setLogBtnTextColor(it) }
            (loginBtnUi["logBtnTextSize"] as Int?)?.let { authUIConfigBuilder.setLogBtnTextSizeDp(it) }
            (loginBtnUi["logBtnWidth"] as Int?)?.let { authUIConfigBuilder.setLogBtnWidth(it) }
            (loginBtnUi["logBtnHeight"] as Int?)?.let { authUIConfigBuilder.setLogBtnHeight(it) }
            (loginBtnUi["logBtnMarginLeftAndRight"] as Int?)?.let {
                authUIConfigBuilder.setLogBtnMarginLeftAndRight(it)
            }
            (loginBtnUi["logBtnBackgroundPath"] as String?)?.let {
                authUIConfigBuilder.setLogBtnBackgroundPath(it)
            }
            (loginBtnUi["logBtnOffsetY"] as Int?)?.let { authUIConfigBuilder.setLogBtnOffsetY(it) }
            (loginBtnUi["logBtnOffsetYB"] as Int?)?.let { authUIConfigBuilder.setLogBtnOffsetY_B(it) }
            (loginBtnUi["loadingImgPath"] as String?)?.let {
                authUIConfigBuilder.setLoadingImgPath(it)
            }
            (loginBtnUi["logBtnOffsetX"] as Int?)?.let { authUIConfigBuilder.setLogBtnOffsetX(it) }
            (loginBtnUi["logBtnLayoutGravity"] as Int?)?.let {
                authUIConfigBuilder.setLogBtnLayoutGravity(gravity[it])
            }
            (loginBtnUi["logBtnBackgroundDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setLogBtnBackgroundDrawable(it)
            }
            (loginBtnUi["loadingImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setLoadingImgDrawable(it)
            }
            (loginBtnUi["logBtnTypeface"] as Int?)?.let {
                authUIConfigBuilder.setLogBtnTypeface(typefaces[it])
            }
        }
        val privacyUi = args["privacyUi"] as Map<*, *>?
        if (privacyUi != null) {
            (privacyUi["privacyOne"] as Map<*, *>?)?.let { map ->
                val text = map["text"] as String;
                val url = map["url"] as String;
                authUIConfigBuilder.setAppPrivacyOne(text, url)
            }
            (privacyUi["privacyTwo"] as Map<*, *>?)?.let { map ->
                val text = map["text"] as String;
                val url = map["url"] as String;
                authUIConfigBuilder.setAppPrivacyTwo(text, url)
            }
            (privacyUi["privacyThree"] as Map<*, *>?)?.let { map ->
                val text = map["text"] as String;
                val url = map["url"] as String;
                authUIConfigBuilder.setAppPrivacyThree(text, url)
            }
            (privacyUi["privacyColor"] as Int?)?.let { color ->
                (privacyUi["privacyUrlColor"] as Int?)?.let { urlColor ->
                    authUIConfigBuilder.setAppPrivacyColor(color, urlColor)
                }
            }
            (privacyUi["privacyOffsetY"] as Int?)?.let { authUIConfigBuilder.setPrivacyOffsetY(it) }
            (privacyUi["privacyOffsetYB"] as Int?)?.let { authUIConfigBuilder.setPrivacyOffsetY_B(it) }
            (privacyUi["privacyState"] as Boolean?)?.let { authUIConfigBuilder.setPrivacyState(it) }
            (privacyUi["protocolGravity"] as Int?)?.let {
                authUIConfigBuilder.setProtocolGravity(gravity[it])
            }
            (privacyUi["privacyTextSize"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyTextSizeDp(it)
            }
            (privacyUi["privacyMargin"] as Int?)?.let { authUIConfigBuilder.setPrivacyMargin(it) }
            (privacyUi["privacyBefore"] as String?)?.let { authUIConfigBuilder.setPrivacyBefore(it) }
            (privacyUi["privacyEnd"] as String?)?.let { authUIConfigBuilder.setPrivacyEnd(it) }
            (privacyUi["checkboxHidden"] as Boolean?)?.let {
                authUIConfigBuilder.setCheckboxHidden(it)
            }
            (privacyUi["uncheckedImgPath"] as String?)?.let {
                authUIConfigBuilder.setUncheckedImgPath(it)
            }
            (privacyUi["checkedImgPath"] as String?)?.let { authUIConfigBuilder.setCheckedImgPath(it) }
            (privacyUi["checkBoxMarginTop"] as Int?)?.let {
                authUIConfigBuilder.setCheckBoxMarginTop(it)
            }
            (privacyUi["vendorPrivacyPrefix"] as String?)?.let {
                authUIConfigBuilder.setVendorPrivacyPrefix(it)
            }
            (privacyUi["vendorPrivacySuffix"] as String?)?.let {
                authUIConfigBuilder.setVendorPrivacySuffix(it)
            }
            (privacyUi["protocolLayoutGravity"] as Int?)?.let {
                authUIConfigBuilder.setProtocolLayoutGravity(gravity[it])
            }
            (privacyUi["privacyOffsetX"] as Int?)?.let { authUIConfigBuilder.setPrivacyOffsetX(it) }
            (privacyUi["logBtnToastHidden"] as Boolean?)?.let {
                authUIConfigBuilder.setLogBtnToastHidden(it)
            }
            (privacyUi["uncheckedImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setUncheckedImgDrawable(it)
            }
            (privacyUi["checkedImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setCheckedImgDrawable(it)
            }
            (privacyUi["protocolTypeface"] as Int?)?.let {
                authUIConfigBuilder.setProtocolTypeface(typefaces[it])
            }
            (privacyUi["privacyOneColor"] as Int?)?.let { authUIConfigBuilder.setPrivacyOneColor(it) }
            (privacyUi["privacyTwoColor"] as Int?)?.let { authUIConfigBuilder.setPrivacyTwoColor(it) }
            (privacyUi["privacyThreeColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyThreeColor(it)
            }
            (privacyUi["privacyOperatorColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyOperatorColor(it)
            }
            (privacyUi["checkBoxWidth"] as Int?)?.let { authUIConfigBuilder.setCheckBoxWidth(it) }
            (privacyUi["checkBoxHeight"] as Int?)?.let { authUIConfigBuilder.setCheckBoxHeight(it) }
        }
        val switchUi = args["switchUi"] as Map<*, *>?
        if (switchUi != null) {
            (switchUi["switchAccHidden"] as Boolean?)?.let {
                authUIConfigBuilder.setSwitchAccHidden(it)
            }
            (switchUi["switchAccText"] as String?)?.let { authUIConfigBuilder.setSwitchAccText(it) }
            (switchUi["switchAccTextColor"] as Int?)?.let {
                authUIConfigBuilder.setSwitchAccTextColor(it)
            }
            (switchUi["switchAccTextSize"] as Int?)?.let {
                authUIConfigBuilder.setSwitchAccTextSizeDp(it)
            }
            (switchUi["switchOffsetY"] as Int?)?.let { authUIConfigBuilder.setSwitchOffsetY(it) }
            (switchUi["switchOffsetYB"] as Int?)?.let { authUIConfigBuilder.setSwitchOffsetY_B(it) }
            (switchUi["switchTypeface"] as Int?)?.let {
                authUIConfigBuilder.setSwitchTypeface(typefaces[it])
            }
        }
        val pageUi = args["pageUi"] as Map<*, *>?
        if (pageUi != null) {
            (pageUi["authPageActIn"] as String?)?.let { actIn ->
                (pageUi["authPageActOut"] as String?)?.let { actOut ->
                    authUIConfigBuilder.setAuthPageActIn(actIn, actOut)
                    authUIConfigBuilder.setAuthPageActOut(actOut, actIn)
                }
            }

            (pageUi["screenOrientation"] as Int?)?.let {
                authUIConfigBuilder.setScreenOrientation(screenOrientation[it])
            }
            (pageUi["pageBackgroundPath"] as String?)?.let {
                authUIConfigBuilder.setPageBackgroundPath(it)
            }
            (pageUi["dialogWidth"] as Int?)?.let { authUIConfigBuilder.setDialogWidth(it) }
            (pageUi["dialogHeight"] as Int?)?.let { authUIConfigBuilder.setDialogHeight(it) }
            (pageUi["dialogAlpha"] as Float?)?.let { authUIConfigBuilder.setDialogAlpha(it) }
            (pageUi["dialogOffsetX"] as Int?)?.let { authUIConfigBuilder.setDialogOffsetX(it) }
            (pageUi["dialogOffsetY"] as Int?)?.let { authUIConfigBuilder.setDialogOffsetY(it) }
            (pageUi["tapAuthPageMaskClosePage"] as Boolean?)?.let {
                authUIConfigBuilder.setTapAuthPageMaskClosePage(it)
            }
            (pageUi["dialogBottom"] as Boolean?)?.let { authUIConfigBuilder.setDialogBottom(it) }
            (pageUi["pageBackgroundDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setPageBackgroundDrawable(it)
            }
            (pageUi["protocolAction"] as String?)?.let { authUIConfigBuilder.setProtocolAction(it) }
            (pageUi["packageName"] as String?)?.let { authUIConfigBuilder.setPackageName(it) }
            (pageUi["webCacheMode"] as Int?)?.let { authUIConfigBuilder.setWebCacheMode(it) }
        }
        val privacyAlertUi = args["privacyAlertUi"] as Map<*, *>?
        if (privacyAlertUi != null) {
            (privacyAlertUi["privacyAlertIsNeedShow"] as Boolean?)?.let {
                authUIConfigBuilder.setPrivacyAlertIsNeedShow(it)
            }
            (privacyAlertUi["privacyAlertIsNeedAutoLogin"] as Boolean?)?.let {
                authUIConfigBuilder.setPrivacyAlertIsNeedAutoLogin(it)
            }
            (privacyAlertUi["privacyAlertMaskIsNeedShow"] as Boolean?)?.let {
                authUIConfigBuilder.setPrivacyAlertMaskIsNeedShow(it)
            }
            (privacyAlertUi["privacyAlertMaskAlpha"] as Float?)?.let {
                authUIConfigBuilder.setPrivacyAlertMaskAlpha(it)
            }
            (privacyAlertUi["privacyAlertAlpha"] as Float?)?.let {
                authUIConfigBuilder.setPrivacyAlertAlpha(it)
            }
            (privacyAlertUi["privacyAlertBackgroundColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBackgroundColor(it)
            }
            (privacyAlertUi["privacyAlertEntryAnimation"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertEntryAnimation(it)
            }
            (privacyAlertUi["privacyAlertExitAnimation"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertExitAnimation(it)
            }
            (privacyAlertUi["privacyAlertCornerRadiusArray"] as IntArray?)?.let {
                authUIConfigBuilder.setPrivacyAlertCornerRadiusArray(it)
            }
            (privacyAlertUi["privacyAlertAlignment"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertAlignment(gravity[it])
            }
            (privacyAlertUi["privacyAlertWidth"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertWidth(it)
            }
            (privacyAlertUi["privacyAlertHeight"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertHeight(it)
            }
            (privacyAlertUi["privacyAlertOffsetX"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertOffsetX(it)
            }
            (privacyAlertUi["privacyAlertOffsetY"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertOffsetY(it)
            }
            (privacyAlertUi["privacyAlertTitleBackgroundColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleBackgroundColor(it)
            }
            (privacyAlertUi["privacyAlertTitleAlignment"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleAlignment(gravity[it])
            }
            (privacyAlertUi["privacyAlertTitleOffsetX"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleOffsetX(it)
            }
            (privacyAlertUi["privacyAlertTitleOffsetY"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleOffsetY(it)
            }
            (privacyAlertUi["privacyAlertTitleContent"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleContent(it)
            }
            (privacyAlertUi["privacyAlertTitleTextSize"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleTextSize(it)
            }
            (privacyAlertUi["privacyAlertTitleColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleColor(it)
            }
            (privacyAlertUi["privacyAlertContentBackgroundColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentBackgroundColor(it)
            }
            (privacyAlertUi["privacyAlertContentTextSize"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentTextSize(it)
            }
            (privacyAlertUi["privacyAlertContentAlignment"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentAlignment(gravity[it])
            }
            (privacyAlertUi["privacyAlertContentColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentColor(it)
            }
            (privacyAlertUi["privacyAlertContentBaseColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentBaseColor(it)
            }
            (privacyAlertUi["privacyAlertContentHorizontalMargin"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentHorizontalMargin(it)
            }
            (privacyAlertUi["privacyAlertContentVerticalMargin"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentVerticalMargin(it)
            }
            (privacyAlertUi["privacyAlertBtnBackgroundImgPath"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnBackgroundImgPath(it)
            }
            (privacyAlertUi["privacyAlertBtnBackgroundImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnBackgroundImgDrawable(it)
            }
            (privacyAlertUi["privacyAlertBtnTextColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnTextColor(it)
            }
            (privacyAlertUi["privacyAlertBtnTextColorPath"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnTextColorPath(it)
            }
            (privacyAlertUi["privacyAlertBtnTextSize"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnTextSize(it)
            }
            (privacyAlertUi["privacyAlertBtnWidth"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnWidth(it)
            }
            (privacyAlertUi["privacyAlertBtnHeight"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnHeigth(it)
            }
            (privacyAlertUi["privacyAlertCloseBtnShow"] as Boolean?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseBtnShow(it)
            }
            (privacyAlertUi["privacyAlertCloseImgPath"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseImagPath(it)
            }
            (privacyAlertUi["privacyAlertCloseScaleType"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseScaleType(ImageView.ScaleType.entries[it])
            }
            (privacyAlertUi["privacyAlertCloseImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseImagDrawable(it)
            }
            (privacyAlertUi["privacyAlertCloseImgWidth"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseImgWidth(it)
            }
            (privacyAlertUi["privacyAlertCloseImgHeight"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseImgHeight(it)
            }
            (privacyAlertUi["privacyAlertBtnGravity"] as IntArray?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnGrivaty(it)
            }
            (privacyAlertUi["privacyAlertBtnContent"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnContent(it)
            }
            (privacyAlertUi["privacyAlertBtnOffsetX"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnOffsetX(it)
            }
            (privacyAlertUi["privacyAlertBtnOffsetY"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnOffsetY(it)
            }
            (privacyAlertUi["privacyAlertBtnHorizontalMargin"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnHorizontalMargin(it)
            }
            (privacyAlertUi["privacyAlertBtnVerticalMargin"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnVerticalMargin(it)
            }
            (privacyAlertUi["tapPrivacyAlertMaskCloseAlert"] as Boolean?)?.let {
                authUIConfigBuilder.setTapPrivacyAlertMaskCloseAlert(it)
            }
            (privacyAlertUi["privacyAlertTitleTypeface"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleTypeface(typefaces[it])
            }
            (privacyAlertUi["privacyAlertContentTypeface"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentTypeface(typefaces[it])
            }
            (privacyAlertUi["privacyAlertBtnTypeface"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnTypeface(typefaces[it])
            }
            (privacyAlertUi["privacyAlertBefore"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertBefore(it)
            }
            (privacyAlertUi["privacyAlertEnd"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertEnd(it)
            }
            (privacyAlertUi["privacyAlertOneColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertOneColor(it)
            }
            (privacyAlertUi["privacyAlertTwoColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTwoColor(it)
            }
            (privacyAlertUi["privacyAlertThreeColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertThreeColor(it)
            }
            (privacyAlertUi["privacyAlertOperatorColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertOperatorColor(it)
            }
        }
        authHelper.setAuthUIConfig(authUIConfigBuilder.create())
        result.success(true)
    }

    private val systemUiFlag = arrayListOf(
        View.SYSTEM_UI_FLAG_LOW_PROFILE,
        View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN,
    )
    private val screenOrientation = arrayListOf(
        ActivityInfo.SCREEN_ORIENTATION_SENSOR,
        ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED,
        ActivityInfo.SCREEN_ORIENTATION_PORTRAIT,
        ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE,
    )
    private val gravity = arrayListOf(
        Gravity.START,
        Gravity.CENTER,
        Gravity.END,
        Gravity.TOP,
        Gravity.BOTTOM,
        Gravity.CENTER_HORIZONTAL,
        Gravity.CENTER_VERTICAL,
    )

    private val typefaces = arrayListOf(
        Typeface.SANS_SERIF,
        Typeface.SERIF,
        Typeface.MONOSPACE,
    )

}
