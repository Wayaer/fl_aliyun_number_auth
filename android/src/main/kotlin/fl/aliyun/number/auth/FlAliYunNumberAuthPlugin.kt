package fl.aliyun.number.auth

import android.content.Context
import android.content.pm.ActivityInfo
import android.graphics.Color
import android.graphics.Typeface
import android.view.Gravity
import android.view.View
import android.widget.ImageView
import androidx.core.graphics.toColorInt
import com.mobile.auth.gatewayauth.AuthUIConfig
import com.mobile.auth.gatewayauth.PhoneNumberAuthHelper
import com.mobile.auth.gatewayauth.PnsLoggerHandler
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterAssets
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result


/** FlAliYunNumberAuthPlugin */
class FlAliYunNumberAuthPlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var authHelper: PhoneNumberAuthHelper

    private lateinit var authListener: AuthListener
    private lateinit var flutterAssets: FlutterAssets

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        flutterAssets = flutterPluginBinding.flutterAssets
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fl_aliyun_number_auth")
        channel.setMethodCallHandler(this)
        authListener = AuthListener(channel)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        authHelper = PhoneNumberAuthHelper.getInstance(binding.activity, authListener)
        authHelper.setAuthListener(authListener)
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

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "setAuthSDKInfo" -> {
                val args = call.arguments as Map<*, *>
                if (args["enableActivityResultListener"] as Boolean) {
                    authHelper.setActivityResultListener(authListener)
                }
                if (args["enableAuthUIControlClickListener"] as Boolean) {
                    authHelper.setUIClickListener(authListener)
                }
                authHelper.setAuthSDKInfo(args["secret"] as String)
                result.success(mapOf("resultCode" to "600000"))
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
                val args = call.arguments as Map<*, *>
                authHelper.getLoginToken(context, args["timeout"] as Int)
                result.success(true)
            }

            "accelerateLoginPage" -> {
                authHelper.accelerateLoginPage(call.arguments as Int, authListener)
                result.success(true)
            }

            "accelerateVerify" -> {
                authHelper.accelerateVerify(call.arguments as Int, authListener)
                result.success(true)
            }

            "getVerifyToken" -> {
                authHelper.getVerifyToken(call.arguments as Int)
                result.success(true)
            }

            "checkEnvAvailable" -> {
                authHelper.checkEnvAvailable(call.arguments as Int)
                result.success(true)
            }

            "quitLoginPage" -> {
                authHelper.quitLoginPage()
                result.success(true)
            }

            "getVersion" -> result.success(PhoneNumberAuthHelper.getVersion())

            "setCheckboxIsChecked" -> {
                authHelper.setProtocolChecked(call.arguments as Boolean)
                result.success(true)
            }

            "queryCheckBoxIsChecked" -> result.success(authHelper.queryCheckBoxIsChecked())
            "hideLoginLoading" -> {
                authHelper.hideLoginLoading()
                result.success(true)
            }

            "getCurrentCarrierName" -> result.success(authHelper.currentCarrierName)

            "setAuthUI" -> setAuthUI(call, result)
            "quitPrivacyAlert" -> {
                authHelper.quitPrivacyPage()
                result.success(true)
            }

            "checkBoxAnimationStart" -> {
                authHelper.checkBoxAnimationStart()
                result.success(true)
            }

            "privacyAnimationStart" -> {
                authHelper.privacyAnimationStart()
                result.success(true)
            }


            /// 以下为android 特有
            "setAuthPageUseDayLight" -> {
                authHelper.setAuthPageUseDayLight(call.arguments as Boolean)
                result.success(true)
            }

            "keepAllPageHideNavigationBar" -> {
                authHelper.keepAllPageHideNavigationBar()
                result.success(true)
            }

            "closeAuthPageReturnBack" -> {
                authHelper.closeAuthPageReturnBack(call.arguments as Boolean)
                result.success(true)
            }

            "keepAuthPageLandscapeFullScreen" -> {
                authHelper.keepAuthPageLandscapeFullSreen(call.arguments as Boolean)
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
                authHelper.expandAuthPageCheckedScope(call.arguments as Boolean)
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
        try {
            val statusBarUi = args["statusBarUi"] as Map<*, *>?
            if (statusBarUi != null) {
                (statusBarUi["statusBarColor"] as String?)?.let {
                    authUIConfigBuilder.setStatusBarColor(it.toColorInt())
                }
                (statusBarUi["lightColor"] as Boolean?)?.let { authUIConfigBuilder.setLightColor(it) }
                (statusBarUi["statusBarHidden"] as Boolean?)?.let {
                    authUIConfigBuilder.setStatusBarHidden(it)
                }
                (statusBarUi["statusBarUIFlag"] as Int?)?.let {
                    authUIConfigBuilder.setStatusBarUIFlag(systemUiFlag[it])
                }
                (statusBarUi["webViewStatusBarColor"] as String?)?.let {
                    authUIConfigBuilder.setWebViewStatusBarColor(it.toColorInt())
                }
            }
            val navUi = args["navUi"] as Map<*, *>?
            if (navUi != null) {
                (navUi["navColor"] as String?)?.let { authUIConfigBuilder.setNavColor(it.toColorInt()) }
                (navUi["navText"] as String?)?.let { authUIConfigBuilder.setNavText(it) }
                (navUi["navTextColor"] as String?)?.let { authUIConfigBuilder.setNavTextColor(it.toColorInt()) }
                (navUi["navTextSize"] as Int?)?.let { authUIConfigBuilder.setNavTextSizeDp(it.toDp()) }
                (navUi["navTypeface"] as Int?)?.let { authUIConfigBuilder.setNavTypeface(typefaces[it]) }
                (navUi["navReturnImgPath"] as String?)?.let {
                    authUIConfigBuilder.setNavReturnImgPath(it.toImagePath())
                }
                (navUi["navReturnImgWidth"] as Int?)?.let {
                    authUIConfigBuilder.setNavReturnImgWidth(it.toDp())
                }
                (navUi["navReturnImgHeight"] as Int?)?.let {
                    authUIConfigBuilder.setNavReturnImgHeight(it.toDp())
                }
                (navUi["navReturnImgScaleType"] as Int?)?.let {
                    authUIConfigBuilder.setNavReturnScaleType(ImageView.ScaleType.entries[it])
                }
                (navUi["navReturnHidden"] as Boolean?)?.let {
                    authUIConfigBuilder.setNavReturnHidden(it)
                }
                (navUi["navHidden"] as Boolean?)?.let { authUIConfigBuilder.setNavHidden(it) }
                (navUi["webNavColor"] as String?)?.let { authUIConfigBuilder.setWebNavColor(it.toColorInt()) }
                (navUi["webNavTextColor"] as String?)?.let {
                    authUIConfigBuilder.setWebNavTextColor(it.toColorInt())
                }
                (navUi["webNavTextSize"] as Int?)?.let { authUIConfigBuilder.setWebNavTextSizeDp(it.toDp()) }
                (navUi["webNavReturnImgPath"] as String?)?.let {
                    authUIConfigBuilder.setWebNavReturnImgPath(it.toImagePath())
                }

                (navUi["webHiddeProgress"] as Boolean?)?.let {
                    authUIConfigBuilder.setWebHiddeProgress(it)
                }
                (navUi["webViewStatusBarColor"] as String?)?.let {
                    authUIConfigBuilder.setWebViewStatusBarColor(it.toColorInt())
                }
                (navUi["webSupportedJavascript"] as Boolean?)?.let {
                    authUIConfigBuilder.setWebSupportedJavascript(it)
                }

                (navUi["bottomNavColor"] as String?)?.let { authUIConfigBuilder.setBottomNavColor(it.toColorInt()) }

            }
            val logoUi = args["logoUi"] as Map<*, *>?
            if (logoUi != null) {
                (logoUi["logoHidden"] as Boolean?)?.let { authUIConfigBuilder.setLogoHidden(it) }
                (logoUi["logoImgPath"] as String?)?.let { authUIConfigBuilder.setLogoImgPath(it.toImagePath()) }
                (logoUi["logoWidth"] as Int?)?.let { authUIConfigBuilder.setLogoWidth(it.toDp()) }
                (logoUi["logoHeight"] as Int?)?.let { authUIConfigBuilder.setLogoHeight(it.toDp()) }
                (logoUi["logoOffsetY"] as Int?)?.let { authUIConfigBuilder.setLogoOffsetY(it.toDp()) }
                (logoUi["logoOffsetYB"] as Int?)?.let { authUIConfigBuilder.setLogoOffsetY_B(it.toDp()) }
                (logoUi["logoScaleType"] as Int?)?.let {
                    authUIConfigBuilder.setLogoScaleType(ImageView.ScaleType.entries[it])
                }
            }
            val sloganUi = args["sloganUi"] as Map<*, *>?
            if (sloganUi != null) {
                (sloganUi["sloganText"] as String?)?.let { authUIConfigBuilder.setSloganText(it) }
                (sloganUi["sloganTextColor"] as String?)?.let {
                    authUIConfigBuilder.setSloganTextColor(Color.parseColor(it))
                }
                (sloganUi["sloganTextSize"] as Int?)?.let {
                    authUIConfigBuilder.setSloganTextSizeDp(it.toDp())
                }
                (sloganUi["sloganOffsetY"] as Int?)?.let { authUIConfigBuilder.setSloganOffsetY(it.toDp()) }
                (sloganUi["sloganOffsetYB"] as Int?)?.let {
                    authUIConfigBuilder.setSloganOffsetY_B(it.toDp())
                }
                (sloganUi["sloganTypeface"] as Int?)?.let {
                    authUIConfigBuilder.setSloganTypeface(typefaces[it])
                }
            }
            val numberUi = args["numberUi"] as Map<*, *>?
            if (numberUi != null) {
                (numberUi["numberColor"] as String?)?.let { authUIConfigBuilder.setNumberColor(it.toColorInt()) }
                (numberUi["numberTextSize"] as Int?)?.let { authUIConfigBuilder.setNumberSizeDp(it.toDp()) }
                (numberUi["numFieldOffsetY"] as Int?)?.let {
                    authUIConfigBuilder.setNumFieldOffsetY(it.toDp())
                }
                (numberUi["numFieldOffsetYB"] as Int?)?.let {
                    authUIConfigBuilder.setNumFieldOffsetY_B(it.toDp())
                }
                (numberUi["numberFieldOffsetX"] as Int?)?.let {
                    authUIConfigBuilder.setNumberFieldOffsetX(it.toDp())
                }
                (numberUi["numberLayoutGravity"] as Int?)?.let {
                    authUIConfigBuilder.setNumberLayoutGravity(gravity[it])
                }
                (numberUi["numberTypeface"] as Int?)?.let {
                    authUIConfigBuilder.setNumberTypeface(typefaces[it])
                }
                (numberUi["numberTextSpace"] as Double?)?.let {
                    authUIConfigBuilder.setNumberTextSpace(it.toDp().toFloat())
                }
            }
            val loginBtnUi = args["loginBtnUi"] as Map<*, *>?
            if (loginBtnUi != null) {
                (loginBtnUi["logBtnText"] as String?)?.let { authUIConfigBuilder.setLogBtnText(it) }
                (loginBtnUi["logBtnTextColor"] as String?)?.let {
                    authUIConfigBuilder.setLogBtnTextColor(it.toColorInt())
                }
                (loginBtnUi["logBtnTextSize"] as Int?)?.let {
                    authUIConfigBuilder.setLogBtnTextSizeDp(it.toDp())
                }
                (loginBtnUi["logBtnWidth"] as Int?)?.let { authUIConfigBuilder.setLogBtnWidth(it.toDp()) }
                (loginBtnUi["logBtnHeight"] as Int?)?.let { authUIConfigBuilder.setLogBtnHeight(it.toDp()) }
                (loginBtnUi["logBtnMarginLeftAndRight"] as Int?)?.let {
                    authUIConfigBuilder.setLogBtnMarginLeftAndRight(it.toDp())
                }
                (loginBtnUi["logBtnBackgroundPath"] as String?)?.let {
                    authUIConfigBuilder.setLogBtnBackgroundPath(it)
                }
                (loginBtnUi["logBtnOffsetY"] as Int?)?.let { authUIConfigBuilder.setLogBtnOffsetY(it.toDp()) }
                (loginBtnUi["logBtnOffsetYB"] as Int?)?.let {
                    authUIConfigBuilder.setLogBtnOffsetY_B(it.toDp())
                }
                (loginBtnUi["loadingImgPath"] as String?)?.let {
                    authUIConfigBuilder.setLoadingImgPath(it.toImagePath())
                }
                (loginBtnUi["logBtnOffsetX"] as Int?)?.let { authUIConfigBuilder.setLogBtnOffsetX(it.toDp()) }
                (loginBtnUi["logBtnLayoutGravity"] as Int?)?.let {
                    authUIConfigBuilder.setLogBtnLayoutGravity(gravity[it])
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
                (privacyUi["privacyColor"] as String?)?.let { color ->
                    (privacyUi["privacyUrlColor"] as String?)?.let { urlColor ->
                        authUIConfigBuilder.setAppPrivacyColor(color.toColorInt(), urlColor.toColorInt())
                    }
                }
                (privacyUi["privacyOffsetY"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyOffsetY(it.toDp())
                }
                (privacyUi["privacyOffsetYB"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyOffsetY_B(it.toDp())
                }
                (privacyUi["privacyState"] as Boolean?)?.let {
                    authUIConfigBuilder.setPrivacyState(it)
                }
                (privacyUi["protocolGravity"] as Int?)?.let {
                    authUIConfigBuilder.setProtocolGravity(gravity[it])
                }
                (privacyUi["privacyTextSize"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyTextSizeDp(it.toDp())
                }
                (privacyUi["privacyMargin"] as Int?)?.let { authUIConfigBuilder.setPrivacyMargin(it.toDp()) }
                (privacyUi["privacyBefore"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyBefore(it)
                }
                (privacyUi["privacyEnd"] as String?)?.let { authUIConfigBuilder.setPrivacyEnd(it) }
                (privacyUi["checkboxHidden"] as Boolean?)?.let {
                    authUIConfigBuilder.setCheckboxHidden(it)
                }
                (privacyUi["uncheckedImgPath"] as String?)?.let {
                    authUIConfigBuilder.setUncheckedImgPath(it.toImagePath())
                }
                (privacyUi["checkedImgPath"] as String?)?.let {
                    authUIConfigBuilder.setCheckedImgPath(it.toImagePath())
                }
                (privacyUi["checkBoxMarginTop"] as Int?)?.let {
                    authUIConfigBuilder.setCheckBoxMarginTop(it.toDp())
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
                (privacyUi["privacyOffsetX"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyOffsetX(it.toDp())
                }
                (privacyUi["logBtnToastHidden"] as Boolean?)?.let {
                    authUIConfigBuilder.setLogBtnToastHidden(it)
                }
                (privacyUi["protocolTypeface"] as Int?)?.let {
                    authUIConfigBuilder.setProtocolTypeface(typefaces[it])
                }
                (privacyUi["privacyOneColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyOneColor(it.toColorInt())
                }
                (privacyUi["privacyTwoColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyTwoColor(it.toColorInt())
                }
                (privacyUi["privacyThreeColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyThreeColor(it.toColorInt())
                }
                (privacyUi["privacyOperatorColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyOperatorColor(it.toColorInt())
                }
                (privacyUi["checkBoxWidth"] as Int?)?.let { authUIConfigBuilder.setCheckBoxWidth(it.toDp()) }
                (privacyUi["checkBoxHeight"] as Int?)?.let {
                    authUIConfigBuilder.setCheckBoxHeight(it.toDp())
                }
            }
            val switchUi = args["switchUi"] as Map<*, *>?
            if (switchUi != null) {
                (switchUi["switchAccHidden"] as Boolean?)?.let {
                    authUIConfigBuilder.setSwitchAccHidden(it)
                }
                (switchUi["switchAccText"] as String?)?.let {
                    authUIConfigBuilder.setSwitchAccText(it)
                }
                (switchUi["switchAccTextColor"] as String?)?.let {
                    authUIConfigBuilder.setSwitchAccTextColor(it.toColorInt())
                }
                (switchUi["switchAccTextSize"] as Int?)?.let {
                    authUIConfigBuilder.setSwitchAccTextSizeDp(it.toDp())
                }
                (switchUi["switchOffsetY"] as Int?)?.let { authUIConfigBuilder.setSwitchOffsetY(it.toDp()) }
                (switchUi["switchOffsetYB"] as Int?)?.let {
                    authUIConfigBuilder.setSwitchOffsetY_B(it.toDp())
                }
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
                    authUIConfigBuilder.setPageBackgroundPath(it.toImagePath())
                }
                (pageUi["dialogWidth"] as Int?)?.let { authUIConfigBuilder.setDialogWidth(it.toDp()) }
                (pageUi["dialogHeight"] as Int?)?.let { authUIConfigBuilder.setDialogHeight(it.toDp()) }
                (pageUi["dialogAlpha"] as Double?)?.let { authUIConfigBuilder.setDialogAlpha(it.toFloat()) }
                (pageUi["dialogOffsetX"] as Int?)?.let { authUIConfigBuilder.setDialogOffsetX(it.toDp()) }
                (pageUi["dialogOffsetY"] as Int?)?.let { authUIConfigBuilder.setDialogOffsetY(it.toDp()) }
                (pageUi["tapAuthPageMaskClosePage"] as Boolean?)?.let {
                    authUIConfigBuilder.setTapAuthPageMaskClosePage(it)
                }
                (pageUi["dialogBottom"] as Boolean?)?.let { authUIConfigBuilder.setDialogBottom(it) }
                (pageUi["dialogCenter"] as Boolean?)?.let { authUIConfigBuilder.setDialogCenterm(it) }
                (pageUi["protocolAction"] as String?)?.let {
                    authUIConfigBuilder.setProtocolAction(it)
                }
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
                (privacyAlertUi["privacyAlertMaskAlpha"] as Double?)?.let {
                    authUIConfigBuilder.setPrivacyAlertMaskAlpha(it.toFloat())
                }
                (privacyAlertUi["privacyAlertAlpha"] as Double?)?.let {
                    authUIConfigBuilder.setPrivacyAlertAlpha(it.toFloat())
                }
                (privacyAlertUi["privacyAlertBackgroundColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBackgroundColor(it.toColorInt())
                }
                (privacyAlertUi["privacyAlertEntryAnimation"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertEntryAnimation(it)
                }
                (privacyAlertUi["privacyAlertExitAnimation"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertExitAnimation(it)
                }
                (privacyAlertUi["privacyAlertCornerRadiusArray"] as ArrayList<*>?)?.let { list ->
                    authUIConfigBuilder.setPrivacyAlertCornerRadiusArray(list.map { it as Int }.toIntArray())
                }
                (privacyAlertUi["privacyAlertAlignment"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertAlignment(gravity[it])
                }
                (privacyAlertUi["privacyAlertWidth"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertWidth(it.toDp())
                }
                (privacyAlertUi["privacyAlertHeight"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertHeight(it.toDp())
                }
                (privacyAlertUi["privacyAlertOffsetX"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertOffsetX(it.toDp())
                }
                (privacyAlertUi["privacyAlertOffsetY"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertOffsetY(it.toDp())
                }
                (privacyAlertUi["privacyAlertTitleBackgroundColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertTitleBackgroundColor(it.toColorInt())
                }
                (privacyAlertUi["privacyAlertTitleAlignment"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertTitleAlignment(gravity[it])
                }
                (privacyAlertUi["privacyAlertTitleOffsetX"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertTitleOffsetX(it.toDp())
                }
                (privacyAlertUi["privacyAlertTitleOffsetY"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertTitleOffsetY(it.toDp())
                }
                (privacyAlertUi["privacyAlertTitleContent"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertTitleContent(it)
                }
                (privacyAlertUi["privacyAlertTitleTextSize"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertTitleTextSize(it.toDp())
                }
                (privacyAlertUi["privacyAlertTitleColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertTitleColor(it.toColorInt())
                }
                (privacyAlertUi["privacyAlertContentBackgroundColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertContentBackgroundColor(it.toColorInt())
                }
                (privacyAlertUi["privacyAlertContentTextSize"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertContentTextSize(it.toDp())
                }
                (privacyAlertUi["privacyAlertContentAlignment"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertContentAlignment(gravity[it])
                }
                (privacyAlertUi["privacyAlertContentColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertContentColor(it.toColorInt())
                }
                (privacyAlertUi["privacyAlertContentBaseColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertContentBaseColor(it.toColorInt())
                }
                (privacyAlertUi["privacyAlertContentHorizontalMargin"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertContentHorizontalMargin(it.toDp())
                }
                (privacyAlertUi["privacyAlertContentVerticalMargin"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertContentVerticalMargin(it.toDp())
                }
                (privacyAlertUi["privacyAlertBtnBackgroundImgPath"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBtnBackgroundImgPath(it.toImagePath())
                }
                (privacyAlertUi["privacyAlertBtnTextColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBtnTextColor(it.toColorInt())
                }
                (privacyAlertUi["privacyAlertBtnTextSize"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBtnTextSize(it.toDp())
                }
                (privacyAlertUi["privacyAlertBtnWidth"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBtnWidth(it.toDp())
                }
                (privacyAlertUi["privacyAlertBtnHeight"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBtnHeigth(it.toDp())
                }
                (privacyAlertUi["privacyAlertCloseBtnShow"] as Boolean?)?.let {
                    authUIConfigBuilder.setPrivacyAlertCloseBtnShow(it)
                }
                (privacyAlertUi["privacyAlertCloseImgPath"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertCloseImagPath(it.toImagePath())
                }
                (privacyAlertUi["privacyAlertCloseScaleType"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertCloseScaleType(ImageView.ScaleType.entries[it])
                }
                (privacyAlertUi["privacyAlertCloseImgWidth"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertCloseImgWidth(it.toDp())
                }
                (privacyAlertUi["privacyAlertCloseImgHeight"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertCloseImgHeight(it.toDp())
                }
                (privacyAlertUi["privacyAlertBtnGravity"] as ArrayList<*>?)?.let { list ->
                    authUIConfigBuilder.setPrivacyAlertBtnGrivaty(list.map { it as Int }.toIntArray())
                }
                (privacyAlertUi["privacyAlertBtnContent"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBtnContent(it)
                }
                (privacyAlertUi["privacyAlertBtnOffsetX"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBtnOffsetX(it.toDp())
                }
                (privacyAlertUi["privacyAlertBtnOffsetY"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBtnOffsetY(it.toDp())
                }
                (privacyAlertUi["privacyAlertBtnHorizontalMargin"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBtnHorizontalMargin(it.toDp())
                }
                (privacyAlertUi["privacyAlertBtnVerticalMargin"] as Int?)?.let {
                    authUIConfigBuilder.setPrivacyAlertBtnVerticalMargin(it.toDp())
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
                (privacyAlertUi["privacyAlertOneColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertOneColor(it.toColorInt())
                }
                (privacyAlertUi["privacyAlertTwoColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertTwoColor(it.toColorInt())
                }
                (privacyAlertUi["privacyAlertThreeColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertThreeColor(it.toColorInt())
                }
                (privacyAlertUi["privacyAlertOperatorColor"] as String?)?.let {
                    authUIConfigBuilder.setPrivacyAlertOperatorColor(it.toColorInt())
                }
            }
            authHelper.setAuthUIConfig(authUIConfigBuilder.create())
        } catch (e: Exception) {
            println("setAuthUIConfig: $e")
        }
        result.success(true)
    }

    private val systemUiFlag = arrayListOf(View.SYSTEM_UI_FLAG_LOW_PROFILE,           // 非全屏显示状态，状态栏的部分图标会被隐藏
        View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN,    // 全屏显示，状态栏区域被隐藏
        View.SYSTEM_UI_FLAG_HIDE_NAVIGATION,      // 隐藏导航栏
        View.SYSTEM_UI_FLAG_IMMERSIVE,            // 启用沉浸式模式，状态栏和导航栏可通过手势出现
        View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY,     // 启用沉浸式粘性模式，状态栏和导航栏不可通过手势恢复
        View.SYSTEM_UI_FLAG_FULLSCREEN,           // 状态栏区域完全隐藏
        View.SYSTEM_UI_FLAG_LAYOUT_STABLE,        // 布局扩展到状态栏区域
        View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR,     // 使用浅色状态栏图标（白色）
        View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR,// 使用浅色导航栏图标（白色）
        View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION // 布局扩展到导航栏区域
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

    private fun String.toImagePath(): String {
        return flutterAssets.getAssetFilePathByName(this)
    }


    // px to dp
    private fun Int.toDp(): Int {
        val density = context.resources.displayMetrics.density
        return (this / density).toInt()
    }

    // px to dp
    private fun Double.toDp(): Double {
        val density = context.resources.displayMetrics.density
        return this / density
    }
}
