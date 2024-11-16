package fl.aliyun.number.auth

import android.content.Context
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
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** FlAliYunNumberAuthPlugin */
class FlAliYunNumberAuthPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    private var authHelper: PhoneNumberAuthHelper? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fl_aliyun_number_auth")
        channel.setMethodCallHandler(this)
    }


    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "setAuthSDKInfo" -> {
                val args = call.arguments as Map<*, *>
                if (authHelper == null) {
                    authHelper = PhoneNumberAuthHelper.getInstance(context, mTokenResultListener)
                }
                if (args["enableActivityResultListener"] as Boolean) {
                    authHelper?.setActivityResultListener(mActivityResultListener)
                }
                if (args["enableAuthUIControlClickListener"] as Boolean) {
                    authHelper?.setUIClickListener(mAuthUIControlClickListener)
                }
                val reporter = authHelper?.reporter
                reporter?.setLoggerEnable(args["enableLogger"] as Boolean)
                reporter?.setUploadEnable(args["enableUploadLogger"] as Boolean)
                if (args["enableLoggerHandler"] as Boolean) {
                    reporter?.setLoggerHandler(mPnsLoggerHandler)
                }
                authHelper?.setAuthSDKInfo(args["androidSecret"] as String)
                result.success(authHelper != null)
            }

            "checkEnvAvailable" -> {
                val args = call.arguments as Map<*, *>
                val serviceType = (args["serviceType"] as Int) + 1
                authHelper?.checkEnvAvailable(serviceType)
                result.success(authHelper != null)
            }

            "setAuthUIConfig" -> setAuthUIConfig(call, result)
            "setProtocolChecked" -> {
                val args = call.arguments as Map<*, *>
                authHelper?.setProtocolChecked(args["isCheck"] as Boolean)
                result.success(authHelper != null)
            }

            "queryCheckBoxIsChecked" -> {
                result.success(authHelper?.queryCheckBoxIsChecked())
            }

            "setAuthPageUseDayLight" -> {
                val args = call.arguments as Map<*, *>
                authHelper?.setAuthPageUseDayLight(args["authPageUseDayLight"] as Boolean)
                result.success(authHelper != null)
            }

            "closeAuthPageReturnBack" -> {
                val args = call.arguments as Map<*, *>
                authHelper?.closeAuthPageReturnBack(args["close"] as Boolean)
                result.success(authHelper != null)
            }

            "keepAuthPageLandscapeFullScreen" -> {
                val args = call.arguments as Map<*, *>
                authHelper?.keepAuthPageLandscapeFullSreen(args["fullScreen"] as Boolean)
                result.success(authHelper != null)
            }

            "clearPreInfo" -> {
                authHelper?.clearPreInfo()
                result.success(authHelper != null)
            }

            "getCurrentCarrierName" -> {
                result.success(authHelper?.currentCarrierName)
            }

            "userControlAuthPageCancel" -> {
                authHelper?.userControlAuthPageCancel()
                result.success(authHelper != null)
            }

            "prohibitUseUtdid" -> {
                authHelper?.prohibitUseUtdid()
                result.success(authHelper != null)
            }

            "expandAuthPageCheckedScope" -> {
                val args = call.arguments as Map<*, *>
                authHelper?.expandAuthPageCheckedScope(args["expand"] as Boolean)
                result.success(authHelper != null)
            }

            "getLoginToken" -> {
                val args = call.arguments as Map<*, *>
                authHelper?.setAuthListener(mTokenResultListener)
                authHelper?.getLoginToken(context, args["timeout"] as Int)
                result.success(authHelper != null)
            }

            "hideLoginLoading" -> {
                authHelper?.hideLoginLoading()
                result.success(authHelper != null)
            }


            "quitLoginPage" -> {
                authHelper?.quitLoginPage()
                result.success(authHelper != null)
            }

            "accelerateLoginPage" -> {
                val args = call.arguments as Map<*, *>
                authHelper?.accelerateLoginPage(
                    args["timeout"] as Int, mPreLoginResultListener
                )
                result.success(authHelper != null)
            }

            "getVersion" -> {
                result.success(PhoneNumberAuthHelper.getVersion())
            }

            "addAuthRegisterViewConfig" -> addAuthRegisterViewConfig(call, result)
            "removeAuthRegisterViewConfig" -> {
                authHelper?.removeAuthRegisterViewConfig()
                result.success(authHelper != null)
            }

            "addAuthRegisterXmlConfig" -> addAuthRegisterXmlConfig(call, result)

            "removeAuthRegisterXmlConfig" -> {
                authHelper?.removeAuthRegisterXmlConfig()
                result.success(authHelper != null)
            }

            "addPrivacyRegisterXmlConfig" -> addPrivacyRegisterXmlConfig(call, result)
            "quitPrivacyPage" -> {
                authHelper?.quitPrivacyPage()
                result.success(authHelper != null)
            }

            "removePrivacyRegisterXmlConfig" -> {
                authHelper?.removePrivacyRegisterXmlConfig()
                result.success(authHelper != null)
            }

            "addPrivacyAuthRegisterViewConfig" -> addPrivacyAuthRegisterViewConfig(call, result)
            "removePrivacyAuthRegisterViewConfig" -> {
                authHelper?.removePrivacyAuthRegisterViewConfig()
                result.success(authHelper != null)
            }

            else -> result.notImplemented()
        }
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
    private var mPreLoginResultListener: PreLoginResultListener = object : PreLoginResultListener {
        override fun onTokenSuccess(s: String) {
            //加速成功业务逻辑处理
            channel.invokeMethod("onPreLoginResult", mapOf("code" to s, "status" to 0))
        }

        override fun onTokenFailed(s: String, s1: String) {
            //加速失败业务逻辑处理
            channel.invokeMethod("onPreLoginResult", mapOf("code" to s, "status" to 1))
        }
    }
    private var mTokenResultListener: TokenResultListener = object : TokenResultListener {
        override fun onTokenSuccess(s: String) {
            //此处可进行token获取成功及授权页唤起成功的业务处理
            channel.invokeMethod("onTokenResult", mapOf("code" to s, "status" to 0))
        }

        override fun onTokenFailed(s: String) {
            //此处可进行token获取失败及退出授权页的业务处理
            channel.invokeMethod("onTokenResult", mapOf("code" to s, "status" to 1))
        }
    }
    private var mActivityResultListener: ActivityResultListener =
        ActivityResultListener { requestCode, resultCode, data ->
            channel.invokeMethod(
                "onActivityResult",
                mapOf("requestCode" to requestCode, "resultCode" to resultCode, "data" to data.data)
            )
        }

    private var mAuthUIControlClickListener: AuthUIControlClickListener =
        AuthUIControlClickListener { code, _, jsonString ->
            channel.invokeMethod(
                "onAuthUIClick", mapOf(
                    "code" to code, "json" to jsonString
                )
            )
        }

    private fun addAuthRegisterViewConfig(call: MethodCall, result: Result) {
        result.success(authHelper != null)
    }

    private fun addAuthRegisterXmlConfig(call: MethodCall, result: Result) {
        result.success(authHelper != null)
    }

    private fun addPrivacyRegisterXmlConfig(call: MethodCall, result: Result) {
        result.success(authHelper != null)
    }

    private fun addPrivacyAuthRegisterViewConfig(call: MethodCall, result: Result) {
        result.success(authHelper != null)
    }

    private fun setAuthUIConfig(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val authUIConfigBuilder = AuthUIConfig.Builder()
        val nav = args["nav"] as Map<*, *>?
        if (nav != null) {
            (nav["statusBarColor"] as Int?)?.let { authUIConfigBuilder.setStatusBarColor(it) }
            (nav["lightColor"] as Boolean?)?.let { authUIConfigBuilder.setLightColor(it) }
            (nav["navColor"] as Int?)?.let { authUIConfigBuilder.setNavColor(it) }
            (nav["navText"] as String?)?.let { authUIConfigBuilder.setNavText(it) }
            (nav["navTextColor"] as Int?)?.let { authUIConfigBuilder.setNavTextColor(it) }
            (nav["navTextSize"] as Int?)?.let { authUIConfigBuilder.setNavTextSizeDp(it) }
            (nav["navTypeface"] as Int?)?.let { authUIConfigBuilder.setNavTypeface(typefaces[it]) }
            (nav["navReturnImgPath"] as String?)?.let { authUIConfigBuilder.setNavReturnImgPath(it) }
            (nav["navReturnHidden"] as Boolean?)?.let { authUIConfigBuilder.setNavReturnHidden(it) }
            (nav["navHidden"] as Boolean?)?.let { authUIConfigBuilder.setNavHidden(it) }
            (nav["statusBarHidden"] as Boolean?)?.let { authUIConfigBuilder.setStatusBarHidden(it) }
            (nav["statusBarUIFlag"] as Int?)?.let {
                authUIConfigBuilder.setStatusBarUIFlag(systemUiFlag[it])
            }
            (nav["webViewStatusBarColor"] as Int?)?.let {
                authUIConfigBuilder.setWebViewStatusBarColor(it)
            }
            (nav["webNavColor"] as Int?)?.let { authUIConfigBuilder.setWebNavColor(it) }
            (nav["webNavTextColor"] as Int?)?.let { authUIConfigBuilder.setWebNavTextColor(it) }
            (nav["webNavTextSize"] as Int?)?.let { authUIConfigBuilder.setWebNavTextSizeDp(it) }
            (nav["webNavReturnImgPath"] as String?)?.let {
                authUIConfigBuilder.setWebNavReturnImgPath(it)
            }
            (nav["bottomNavColor"] as Int?)?.let { authUIConfigBuilder.setBottomNavColor(it) }
            (nav["navReturnImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setNavReturnImgDrawable(it)
            }
        }
        val logo = args["logo"] as Map<*, *>?
        if (logo != null) {
            (logo["logoHidden"] as Boolean?)?.let { authUIConfigBuilder.setLogoHidden(it) }
            (logo["logoImgPath"] as String?)?.let { authUIConfigBuilder.setLogoImgPath(it) }
            (logo["logoWidth"] as Int?)?.let { authUIConfigBuilder.setLogoWidth(it) }
            (logo["logoHeight"] as Int?)?.let { authUIConfigBuilder.setLogoHeight(it) }
            (logo["logoOffsetY"] as Int?)?.let { authUIConfigBuilder.setLogoOffsetY(it) }
            (logo["logoOffsetYB"] as Int?)?.let { authUIConfigBuilder.setLogoOffsetY_B(it) }
            (logo["logoScaleType"] as Int?)?.let { authUIConfigBuilder.setLogoScaleType(ImageView.ScaleType.entries[it]) }
        }
        val slogan = args["slogan"] as Map<*, *>?
        if (slogan != null) {
            (slogan["sloganText"] as String?)?.let { authUIConfigBuilder.setSloganText(it) }
            (slogan["sloganTextColor"] as Int?)?.let { authUIConfigBuilder.setSloganTextColor(it) }
            (slogan["sloganTextSize"] as Int?)?.let { authUIConfigBuilder.setSloganTextSizeDp(it) }
            (slogan["sloganOffsetY"] as Int?)?.let { authUIConfigBuilder.setSloganOffsetY(it) }
            (slogan["sloganOffsetYB"] as Int?)?.let { authUIConfigBuilder.setSloganOffsetY_B(it) }
            (slogan["sloganTypeface"] as Int?)?.let {
                authUIConfigBuilder.setSloganTypeface(typefaces[it])
            }
        }
        val number = args["number"] as Map<*, *>?
        if (number != null) {
            (number["numberColor"] as Int?)?.let { authUIConfigBuilder.setNumberColor(it) }
            (number["numberTextSize"] as Int?)?.let { authUIConfigBuilder.setNumberSizeDp(it) }
            (number["numFieldOffsetY"] as Int?)?.let { authUIConfigBuilder.setNumFieldOffsetY(it) }
            (number["numFieldOffsetYB"] as Int?)?.let { authUIConfigBuilder.setNumFieldOffsetY_B(it) }
            (number["numberFieldOffsetX"] as Int?)?.let {
                authUIConfigBuilder.setNumberFieldOffsetX(it)
            }
            (number["numberLayoutGravity"] as Int?)?.let {
                authUIConfigBuilder.setNumberLayoutGravity(gravity[it])
            }
            (number["numberTypeface"] as Int?)?.let {
                authUIConfigBuilder.setNumberTypeface(typefaces[it])
            }
            (number["numberTextSpace"] as Float?)?.let { authUIConfigBuilder.setNumberTextSpace(it) }
        }
        val loginBtn = args["LoginBtn"] as Map<*, *>?
        if (loginBtn != null) {
            (loginBtn["logBtnText"] as String?)?.let { authUIConfigBuilder.setLogBtnText(it) }
            (loginBtn["logBtnTextColor"] as Int?)?.let { authUIConfigBuilder.setLogBtnTextColor(it) }
            (loginBtn["logBtnTextSize"] as Int?)?.let { authUIConfigBuilder.setLogBtnTextSizeDp(it) }
            (loginBtn["logBtnWidth"] as Int?)?.let { authUIConfigBuilder.setLogBtnWidth(it) }
            (loginBtn["logBtnHeight"] as Int?)?.let { authUIConfigBuilder.setLogBtnHeight(it) }
            (loginBtn["logBtnMarginLeftAndRight"] as Int?)?.let {
                authUIConfigBuilder.setLogBtnMarginLeftAndRight(it)
            }
            (loginBtn["logBtnBackgroundPath"] as String?)?.let {
                authUIConfigBuilder.setLogBtnBackgroundPath(it)
            }
            (loginBtn["logBtnOffsetY"] as Int?)?.let { authUIConfigBuilder.setLogBtnOffsetY(it) }
            (loginBtn["logBtnOffsetYB"] as Int?)?.let { authUIConfigBuilder.setLogBtnOffsetY_B(it) }
            (loginBtn["loadingImgPath"] as String?)?.let { authUIConfigBuilder.setLoadingImgPath(it) }
            (loginBtn["logBtnOffsetX"] as Int?)?.let { authUIConfigBuilder.setLogBtnOffsetX(it) }
            (loginBtn["logBtnLayoutGravity"] as Int?)?.let {
                authUIConfigBuilder.setLogBtnLayoutGravity(gravity[it])
            }
            (loginBtn["logBtnBackgroundDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setLogBtnBackgroundDrawable(it)
            }
            (loginBtn["loadingImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setLoadingImgDrawable(it)
            }
            (loginBtn["logBtnTypeface"] as Int?)?.let {
                authUIConfigBuilder.setLogBtnTypeface(typefaces[it])
            }
        }
        val privacy = args["privacy"] as Map<*, *>?
        if (privacy != null) {
            (privacy["privacyOne"] as String?)?.let { text ->
                (privacy["privacyOneUrl"] as String?)?.let { url ->
                    authUIConfigBuilder.setAppPrivacyOne(text, url)
                }
            }

            (privacy["privacyTwo"] as String?)?.let { text ->
                (privacy["privacyTwoUrl"] as String?)?.let { url ->
                    authUIConfigBuilder.setAppPrivacyTwo(text, url)
                }
            }
            (privacy["privacyThree"] as String?)?.let { text ->
                (privacy["privacyThreeUrl"] as String?)?.let { url ->
                    authUIConfigBuilder.setAppPrivacyThree(text, url)
                }
            }

            (privacy["privacyColor"] as Int?)?.let { color ->
                (privacy["privacyUrlColor"] as Int?)?.let { urlColor ->
                    authUIConfigBuilder.setAppPrivacyColor(color, urlColor)
                }
            }
            (privacy["privacyOffsetY"] as Int?)?.let { authUIConfigBuilder.setPrivacyOffsetY(it) }
            (privacy["privacyOffsetYB"] as Int?)?.let { authUIConfigBuilder.setPrivacyOffsetY_B(it) }
            (privacy["privacyState"] as Boolean?)?.let { authUIConfigBuilder.setPrivacyState(it) }
            (privacy["protocolGravity"] as Int?)?.let {
                authUIConfigBuilder.setProtocolGravity(gravity[it])
            }
            (privacy["privacyTextSize"] as Int?)?.let { authUIConfigBuilder.setPrivacyTextSizeDp(it) }
            (privacy["privacyMargin"] as Int?)?.let { authUIConfigBuilder.setPrivacyMargin(it) }
            (privacy["privacyBefore"] as String?)?.let { authUIConfigBuilder.setPrivacyBefore(it) }
            (privacy["privacyEnd"] as String?)?.let { authUIConfigBuilder.setPrivacyEnd(it) }
            (privacy["checkboxHidden"] as Boolean?)?.let { authUIConfigBuilder.setCheckboxHidden(it) }
            (privacy["uncheckedImgPath"] as String?)?.let {
                authUIConfigBuilder.setUncheckedImgPath(it)
            }
            (privacy["checkedImgPath"] as String?)?.let { authUIConfigBuilder.setCheckedImgPath(it) }
            (privacy["checkBoxMarginTop"] as Int?)?.let {
                authUIConfigBuilder.setCheckBoxMarginTop(it)
            }
            (privacy["vendorPrivacyPrefix"] as String?)?.let {
                authUIConfigBuilder.setVendorPrivacyPrefix(it)
            }
            (privacy["vendorPrivacySuffix"] as String?)?.let {
                authUIConfigBuilder.setVendorPrivacySuffix(it)
            }
            (privacy["protocolLayoutGravity"] as Int?)?.let {
                authUIConfigBuilder.setProtocolLayoutGravity(gravity[it])
            }
            (privacy["privacyOffsetX"] as Int?)?.let { authUIConfigBuilder.setPrivacyOffsetX(it) }
            (privacy["logBtnToastHidden"] as Boolean?)?.let {
                authUIConfigBuilder.setLogBtnToastHidden(it)
            }
            (privacy["uncheckedImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setUncheckedImgDrawable(it)
            }
            (privacy["checkedImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setCheckedImgDrawable(it)
            }
            (privacy["protocolTypeface"] as Int?)?.let {
                authUIConfigBuilder.setProtocolTypeface(typefaces[it])
            }
            (privacy["privacyOneColor"] as Int?)?.let { authUIConfigBuilder.setPrivacyOneColor(it) }
            (privacy["privacyTwoColor"] as Int?)?.let { authUIConfigBuilder.setPrivacyTwoColor(it) }
            (privacy["privacyThreeColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyThreeColor(it)
            }
            (privacy["privacyOperatorColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyOperatorColor(it)
            }
            (privacy["checkBoxWidth"] as Int?)?.let { authUIConfigBuilder.setCheckBoxWidth(it) }
            (privacy["checkBoxHeight"] as Int?)?.let { authUIConfigBuilder.setCheckBoxHeight(it) }
        }
        val switch = args["switch"] as Map<*, *>?
        if (switch != null) {
            (switch["switchAccHidden"] as Boolean?)?.let { authUIConfigBuilder.setSwitchAccHidden(it) }
            (switch["switchAccText"] as String?)?.let { authUIConfigBuilder.setSwitchAccText(it) }
            (switch["switchAccTextColor"] as Int?)?.let {
                authUIConfigBuilder.setSwitchAccTextColor(it)
            }
            (switch["switchAccTextSize"] as Int?)?.let {
                authUIConfigBuilder.setSwitchAccTextSizeDp(it)
            }
            (switch["switchOffsetY"] as Int?)?.let { authUIConfigBuilder.setSwitchOffsetY(it) }
            (switch["switchOffsetYB"] as Int?)?.let { authUIConfigBuilder.setSwitchOffsetY_B(it) }
            (switch["switchTypeface"] as Int?)?.let {
                authUIConfigBuilder.setSwitchTypeface(typefaces[it])
            }
        }
        val page = args["page"] as Map<*, *>?
        if (page != null) {
            (page["authPageActIn"] as String?)?.let { actIn ->
                (page["authPageActOut"] as String?)?.let { actOut ->
                    authUIConfigBuilder.setAuthPageActIn(actIn, actOut)
                    authUIConfigBuilder.setAuthPageActOut(actOut, actIn)
                }
            }

            (page["screenOrientation"] as Int?)?.let {
                authUIConfigBuilder.setScreenOrientation(screenOrientation[it])
            }
            (page["pageBackgroundPath"] as String?)?.let {
                authUIConfigBuilder.setPageBackgroundPath(it)
            }
            (page["dialogWidth"] as Int?)?.let { authUIConfigBuilder.setDialogWidth(it) }
            (page["dialogHeight"] as Int?)?.let { authUIConfigBuilder.setDialogHeight(it) }
            (page["dialogAlpha"] as Float?)?.let { authUIConfigBuilder.setDialogAlpha(it) }
            (page["dialogOffsetX"] as Int?)?.let { authUIConfigBuilder.setDialogOffsetX(it) }
            (page["dialogOffsetY"] as Int?)?.let { authUIConfigBuilder.setDialogOffsetY(it) }
            (page["tapAuthPageMaskClosePage"] as Boolean?)?.let {
                authUIConfigBuilder.setTapAuthPageMaskClosePage(it)
            }
            (page["dialogBottom"] as Boolean?)?.let { authUIConfigBuilder.setDialogBottom(it) }
            (page["pageBackgroundDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setPageBackgroundDrawable(it)
            }
            (page["protocolAction"] as String?)?.let { authUIConfigBuilder.setProtocolAction(it) }
            (page["packageName"] as String?)?.let { authUIConfigBuilder.setPackageName(it) }
            (page["webCacheMode"] as Int?)?.let { authUIConfigBuilder.setWebCacheMode(it) }
        }
        val privacyAlert = args["privacyAlert"] as Map<*, *>?
        if (privacyAlert != null) {
            (privacyAlert["privacyAlertIsNeedShow"] as Boolean?)?.let {
                authUIConfigBuilder.setPrivacyAlertIsNeedShow(it)
            }
            (privacyAlert["privacyAlertIsNeedAutoLogin"] as Boolean?)?.let {
                authUIConfigBuilder.setPrivacyAlertIsNeedAutoLogin(it)
            }
            (privacyAlert["privacyAlertMaskIsNeedShow"] as Boolean?)?.let {
                authUIConfigBuilder.setPrivacyAlertMaskIsNeedShow(it)
            }
            (privacyAlert["privacyAlertMaskAlpha"] as Float?)?.let {
                authUIConfigBuilder.setPrivacyAlertMaskAlpha(it)
            }
            (privacyAlert["privacyAlertAlpha"] as Float?)?.let {
                authUIConfigBuilder.setPrivacyAlertAlpha(it)
            }
            (privacyAlert["privacyAlertBackgroundColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBackgroundColor(it)
            }
            (privacyAlert["privacyAlertEntryAnimation"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertEntryAnimation(it)
            }
            (privacyAlert["privacyAlertExitAnimation"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertExitAnimation(it)
            }
            (privacyAlert["privacyAlertCornerRadiusArray"] as IntArray?)?.let {
                authUIConfigBuilder.setPrivacyAlertCornerRadiusArray(it)
            }
            (privacyAlert["privacyAlertAlignment"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertAlignment(gravity[it])
            }
            (privacyAlert["privacyAlertWidth"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertWidth(it)
            }
            (privacyAlert["privacyAlertHeight"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertHeight(it)
            }
            (privacyAlert["privacyAlertOffsetX"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertOffsetX(it)
            }
            (privacyAlert["privacyAlertOffsetY"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertOffsetY(it)
            }
            (privacyAlert["privacyAlertTitleBackgroundColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleBackgroundColor(it)
            }
            (privacyAlert["privacyAlertTitleAlignment"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleAlignment(gravity[it])
            }
            (privacyAlert["privacyAlertTitleOffsetX"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleOffsetX(it)
            }
            (privacyAlert["privacyAlertTitleOffsetY"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleOffsetY(it)
            }
            (privacyAlert["privacyAlertTitleContent"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleContent(it)
            }
            (privacyAlert["privacyAlertTitleTextSize"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleTextSize(it)
            }
            (privacyAlert["privacyAlertTitleColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleColor(it)
            }
            (privacyAlert["privacyAlertContentBackgroundColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentBackgroundColor(it)
            }
            (privacyAlert["privacyAlertContentTextSize"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentTextSize(it)
            }
            (privacyAlert["privacyAlertContentAlignment"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentAlignment(gravity[it])
            }
            (privacyAlert["privacyAlertContentColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentColor(it)
            }
            (privacyAlert["privacyAlertContentBaseColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentBaseColor(it)
            }
            (privacyAlert["privacyAlertContentHorizontalMargin"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentHorizontalMargin(it)
            }
            (privacyAlert["privacyAlertContentVerticalMargin"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentVerticalMargin(it)
            }
            (privacyAlert["privacyAlertBtnBackgroundImgPath"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnBackgroundImgPath(it)
            }
            (privacyAlert["privacyAlertBtnBackgroundImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnBackgroundImgDrawable(it)
            }
            (privacyAlert["privacyAlertBtnTextColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnTextColor(it)
            }
            (privacyAlert["privacyAlertBtnTextColorPath"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnTextColorPath(it)
            }
            (privacyAlert["privacyAlertBtnTextSize"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnTextSize(it)
            }
            (privacyAlert["privacyAlertBtnWidth"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnWidth(it)
            }
            (privacyAlert["privacyAlertBtnHeight"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnHeigth(it)
            }
            (privacyAlert["privacyAlertCloseBtnShow"] as Boolean?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseBtnShow(it)
            }
            (privacyAlert["privacyAlertCloseImgPath"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseImagPath(it)
            }
            (privacyAlert["privacyAlertCloseScaleType"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseScaleType(ImageView.ScaleType.entries[it])
            }
            (privacyAlert["privacyAlertCloseImgDrawable"] as Drawable?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseImagDrawable(it)
            }
            (privacyAlert["privacyAlertCloseImgWidth"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseImgWidth(it)
            }
            (privacyAlert["privacyAlertCloseImgHeight"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertCloseImgHeight(it)
            }
            (privacyAlert["privacyAlertBtnGravity"] as IntArray?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnGrivaty(it)
            }
            (privacyAlert["privacyAlertBtnContent"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnContent(it)
            }
            (privacyAlert["privacyAlertBtnOffsetX"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnOffsetX(it)
            }
            (privacyAlert["privacyAlertBtnOffsetY"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnOffsetY(it)
            }
            (privacyAlert["privacyAlertBtnHorizontalMargin"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnHorizontalMargin(it)
            }
            (privacyAlert["privacyAlertBtnVerticalMargin"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnVerticalMargin(it)
            }
            (privacyAlert["tapPrivacyAlertMaskCloseAlert"] as Boolean?)?.let {
                authUIConfigBuilder.setTapPrivacyAlertMaskCloseAlert(it)
            }
            (privacyAlert["privacyAlertTitleTypeface"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTitleTypeface(typefaces[it])
            }
            (privacyAlert["privacyAlertContentTypeface"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertContentTypeface(typefaces[it])
            }
            (privacyAlert["privacyAlertBtnTypeface"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertBtnTypeface(typefaces[it])
            }
            (privacyAlert["privacyAlertBefore"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertBefore(it)
            }
            (privacyAlert["privacyAlertEnd"] as String?)?.let {
                authUIConfigBuilder.setPrivacyAlertEnd(it)
            }
            (privacyAlert["privacyAlertOneColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertOneColor(it)
            }
            (privacyAlert["privacyAlertTwoColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertTwoColor(it)
            }
            (privacyAlert["privacyAlertThreeColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertThreeColor(it)
            }
            (privacyAlert["privacyAlertOperatorColor"] as Int?)?.let {
                authUIConfigBuilder.setPrivacyAlertOperatorColor(it)
            }
        }
        authHelper?.setAuthUIConfig(authUIConfigBuilder.create())
        result.success(authHelper != null)
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


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
