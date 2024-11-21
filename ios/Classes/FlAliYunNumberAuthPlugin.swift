import ATAuthSDK
import Flutter
import UIKit

public class FlAliYunNumberAuthPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "fl_aliyun_number_auth", binaryMessenger: registrar.messenger())
        let instance = FlAliYunNumberAuthPlugin(registrar, channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    private let channel: FlutterMethodChannel
    private let registrar: FlutterPluginRegistrar

    init(_ registrar: FlutterPluginRegistrar, _ channel: FlutterMethodChannel) {
        self.registrar = registrar
        self.channel = channel
    }

    private var authHelper = TXCommonHandler.sharedInstance()
    private var authUiModel = TXCustomModel()

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setAuthSDKInfo":
            let args = call.arguments as! [String: Any]
            authHelper.setAuthSDKInfo(args["secret"] as! String) { dict in
                result(dict)
            }
        case "setLoggerInfo":
            let args = call.arguments as! [String: Any]
            let reporter = authHelper.getReporter()
            reporter.setConsolePrintLoggerEnable(args["enable"] as! Bool)
            reporter.setUploadEnable(args["enableUpload"] as! Bool)
            if args["enableHandler"] as! Bool {}
        case "getLoginToken":
            getLoginToken(call, result)
        case "quitLoginPage":
            let args = call.arguments as! [String: Any]
            authHelper.cancelLoginVC(animated: args["animated"] as! Bool) {
                result(true)
            }
        case "accelerateLoginPage":
            let args = call.arguments as! [String: Any]
            authHelper.accelerateLoginPage(withTimeout: TimeInterval(args["timeout"] as! Int)) { dict in
                result(dict)
            }
        case "getVersion":
            result(authHelper.getVersion())
        case "checkEnvAvailable":
            let args = call.arguments as! [String: Any]
            authHelper.checkEnvAvailable(with: PNSAuthType(rawValue: args["authType"] as! Int)!) { dict in
                result(dict)
            }
        case "setCheckboxIsChecked":
            let args = call.arguments as! [String: Any]
            authHelper.setCheckboxIsChecked(args["isChecked"] as! Bool)
        case "queryCheckBoxIsChecked":
            result(authHelper.queryCheckBoxIsChecked())
        case "hideLoginLoading":
            result(authHelper.hideLoginLoading())
        case "getCurrentCarrierName":
            result(TXCommonUtils.getCurrentCarrierName())
        case "setAuthUI":
            setAuthUI(call, result)
        case "quitPrivacyAlert":
            authHelper.closePrivactAlertView()
            result(true)

        /// 以下为ios特有
        case "privacyAnimationStart":
            authHelper.privacyAnimationStart()
            result(true)
        case "checkboxAnimationStart":
            authHelper.checkboxAnimationStart()
            result(true)
        case "checkDeviceCellularDataEnable":
            result(TXCommonUtils.checkDeviceCellularDataEnable())
        case "isChinaUnicom":
            result(TXCommonUtils.isChinaUnicom())
        case "isChinaMobile":
            result(TXCommonUtils.isChinaMobile())
        case "isChinaTelecom":
            result(TXCommonUtils.isChinaTelecom())
        case "getNetworkType":
            result(TXCommonUtils.getNetworktype())
        case "isWWANOpen":
            result(TXCommonUtils.isWWANOpen())
        case "reachableViaWWAN":
            result(TXCommonUtils.reachableViaWWAN())
        case "getMobilePrivateIPAddress":
            let args = call.arguments as! [String: Any]
            result(TXCommonUtils.getMobilePrivateIPAddress(args["preferIPv4"] as! Bool))
        case "getUniqueID":
            result(TXCommonUtils.getUniqueID())
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func getLoginToken(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        if let controller = getCurrentViewController() {
            let args = call.arguments as! [String: Any]
            let isDebug = args["isDebug"] as! Bool
            if isDebug {
                authHelper.getLoginToken(withTimeout: TimeInterval(args["timeout"] as! Int), controller: controller, model: authUiModel) { dict in
                    result(dict)
                }
            } else {
                authHelper.debugLoginUI(with: controller, model: authUiModel) { dict in
                    result(dict)
                }
            }

        } else {
            result(nil)
        }
    }

    func invokeFrame(_ name: String, _ screenSize: CGSize, _ superViewSize: CGSize, _ frame: CGRect) {
        channel.invokeMethod("onViewFrameBlock", arguments: [
            "name": name,
            "screenSize": screenSize.toMap(),
            "superViewSize": superViewSize.toMap(),
            "frame": frame.toMap(),
        ])
    }

    func setAuthUI(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        if let statusBar = args["statusBarUi"] as? [String: Any] {
            if let value = statusBar["prefersStatusBarHidden"] as? Bool {
                authUiModel.prefersStatusBarHidden = value
            }
            if let value = statusBar["preferredStatusBarStyle"] as? Int {
                authUiModel.preferredStatusBarStyle = UIStatusBarStyle(rawValue: value)!
            }
        }
        if let navUi = args["navUi"] as? [String: Any] {
            if let value = navUi["navIsHidden"] as? Bool {
                authUiModel.navIsHidden = value
            }
            if let value = navUi["navColor"] as? Int {
                authUiModel.navColor = value.toColor()
            }
            if let value = navUi["navTitle"] as? [String: Any] {
                if let text = value.toNSAttributedString() { authUiModel.navTitle = text }
            }
            if let value = navUi["navBackImage"] as? String {
                if let image = value.toUIImage(registrar) {
                    authUiModel.navBackImage = image
                }
            }
            if let value = navUi["hideNavBackItem"] as? Bool {
                authUiModel.hideNavBackItem = value
            }
            if let value = navUi["navMoreView"] as? [String: Any] {
                if let view = value.toUIView() {
                    authUiModel.navMoreView = view
                }
            }
            if let value = navUi["navBackButtonFrameBlock"] as? Bool, value {
                authUiModel.navMoreViewFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("navBackButtonFrameBlock", screenSize, superViewSize, frame)
                    if let value = navUi["navBackButtonFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = navUi["navTitleFrameBlock"] as? Bool, value {
                authUiModel.navTitleFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("navTitleFrameBlock", screenSize, superViewSize, frame)
                    if let value = navUi["navTitleFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = navUi["navMoreViewFrameBlock"] as? Bool, value {
                authUiModel.navMoreViewFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("navMoreViewFrameBlock", screenSize, superViewSize, frame)
                    if let value = navUi["navMoreViewFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = navUi["privacyNavColor"] as? Int {
                authUiModel.privacyNavColor = value.toColor()
            }
            if let value = navUi["privacyNavTitleFont"] as? [String: Any] {
                authUiModel.privacyNavTitleFont = value.toUIFont()
            }
            if let value = navUi["privacyNavTitleColor"] as? Int {
                authUiModel.privacyNavTitleColor = value.toColor()
            }
//            if let value = navUi["privacyNavBackImage"] as? String {
//                if let image = value.toUIImage(registrar) {
//                    authUiModel.privacyNavBackImage = image
//                }
//            }
        }
        if let logoUi = args["logoUi"] as? [String: Any] {
            if let value = logoUi["logoImage"] as? String {
                if let image = value.toUIImage(registrar) {
                    authUiModel.logoImage = image
                }
            }
            if let value = logoUi["logoIsHidden"] as? Bool {
                authUiModel.logoIsHidden = value
            }
            if let value = logoUi["logoFrameBlock"] as? Bool, value {
                authUiModel.logoFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("logoFrameBlock", screenSize, superViewSize, frame)
                    if let value = logoUi["logoFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
        }
        if let sloganUi = args["sloganUi"] as? [String: Any] {
            if let value = sloganUi["sloganText"] as? [String: Any] {
                if let text = value.toNSAttributedString() { authUiModel.sloganText = text }
            }
            if let value = sloganUi["sloganIsHidden"] as? Bool {
                authUiModel.sloganIsHidden = value
            }

            if let value = sloganUi["sloganFrameBlock"] as? Bool, value {
                authUiModel.logoFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("sloganFrameBlock", screenSize, superViewSize, frame)
                    if let value = sloganUi["sloganFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
        }
        if let numberUi = args["numberUi"] as? [String: Any] {
            if let value = numberUi["numberColor"] as? Int {
                authUiModel.numberColor = value.toColor()
            }
            if let value = numberUi["numberFont"] as? [String: Any] {
                authUiModel.numberFont = value.toUIFont()
            }
            if let value = numberUi["numberFrameBlock"] as? Bool, value {
                authUiModel.logoFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("numberFrameBlock", screenSize, superViewSize, frame)
                    if let value = numberUi["numberFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
        }

        if let loginBtnUi = args["loginBtnUi"] as? [String: Any] {
            if let value = loginBtnUi["loginBtnText"] as? [String: Any] {
                if let text = value.toNSAttributedString() { authUiModel.loginBtnText = text }
            }
            if let value = loginBtnUi["loginBtnBgImgs"] as? [String] {
                let imgs = value.map { image in
                    image.toUIImage(registrar)
                }
                authUiModel.loginBtnBgImgs = imgs.filter { $0 != nil }.map { $0! }
            }
            if let value = loginBtnUi["autoHideLoginLoading"] as? Bool {
                authUiModel.autoHideLoginLoading = value
            }
            if let value = loginBtnUi["logoFrameBlock"] as? Bool, value {
                authUiModel.logoFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("logoFrameBlock", screenSize, superViewSize, frame)
                    if let value = loginBtnUi["logoFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
        }
        if let switchUi = args["switchUi"] as? [String: Any] {
            if let value = switchUi["changeBtnTitle"] as? [String: Any] {
                if let text = value.toNSAttributedString() { authUiModel.changeBtnTitle = text }
            }
            if let value = switchUi["changeBtnIsHidden"] as? Bool {
                authUiModel.changeBtnIsHidden = value
            }
            if let value = switchUi["changeBtnFrameBlock"] as? Bool, value {
                authUiModel.changeBtnFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("changeBtnFrameBlock", screenSize, superViewSize, frame)
                    if let value = switchUi["changeBtnFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
        }
        if let privacyUi = args["privacyUi"] as? [String: Any] {
            if let value = privacyUi["checkBoxImages"] as? [String] {
                let imgs = value.map { image in
                    image.toUIImage(registrar)
                }
                authUiModel.checkBoxImages = imgs.filter { $0 != nil }.map { $0! }
            }
            if let value = privacyUi["checkBoxIsChecked"] as? Bool {
                authUiModel.checkBoxIsChecked = value
            }
            if let value = privacyUi["checkBoxIsHidden"] as? Bool {
                authUiModel.checkBoxIsHidden = value
            }
            if let value = privacyUi["checkBoxWH"] as? Double {
                authUiModel.checkBoxWH = value.toCGFloat()
            }
            if let privacy = privacyUi["privacyOne"] as? [String: String] {
                authUiModel.privacyOne = [privacy["text"]!, privacy["url"]!]
            }
            if let privacy = privacyUi["privacyTwo"] as? [String: String] {
                authUiModel.privacyTwo = [privacy["text"]!, privacy["url"]!]
            }
            if let privacy = privacyUi["privacyThree"] as? [String: String] {
                authUiModel.privacyThree = [privacy["text"]!, privacy["url"]!]
            }
            if let value = privacyUi["privacyColors"] as? [Int] {
                authUiModel.privacyColors = value.map { color in
                    color.toColor()
                }
            }
            if let value = privacyUi["privacyAlignment"] as? Int {
                if let alignment = NSTextAlignment(rawValue: value) {
                    authUiModel.privacyAlignment = alignment
                }
            }
            if let value = privacyUi["privacyPreText"] as? String {
                authUiModel.privacyPreText = value
            }
            if let value = privacyUi["privacySufText"] as? String {
                authUiModel.privacySufText = value
            }
            if let value = privacyUi["privacyOperatorPreText"] as? String {
                authUiModel.privacyOperatorPreText = value
            }
            if let value = privacyUi["privacyOperatorSufText"] as? String {
                authUiModel.privacyOperatorSufText = value
            }
            if let value = privacyUi["privacyFont"] as? [String: Any] {
                authUiModel.privacyFont = value.toUIFont()
            }
            if let value = privacyUi["privacyFrameBlock"] as? Bool, value {
                authUiModel.privacyFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("privacyFrameBlock", screenSize, superViewSize, frame)
                    if let value = privacyUi["privacyFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }

            if let value = privacyUi["privacyOperatorColor"] as? Int {
                authUiModel.privacyOperatorColor = value.toColor()
            }
            if let value = privacyUi["privacyOneColor"] as? Int {
                authUiModel.privacyOneColor = value.toColor()
            }
            if let value = privacyUi["privacyTwoColor"] as? Int {
                authUiModel.privacyTwoColor = value.toColor()
            }
            if let value = privacyUi["privacyThreeColor"] as? Int {
                authUiModel.privacyThreeColor = value.toColor()
            }
        }
        if let pageUi = args["pageUi"] as? [String: Any] {
            if let value = pageUi["contentViewFrameBlock"] as? Bool, value {
                authUiModel.contentViewFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("contentViewFrameBlock", screenSize, superViewSize, frame)
                    if let value = pageUi["contentViewFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = pageUi["supportedInterfaceOrientations"] as? Int {
                authUiModel.supportedInterfaceOrientations = [
                    UIInterfaceOrientationMask.portrait,
                    UIInterfaceOrientationMask.landscapeLeft,
                    UIInterfaceOrientationMask.landscapeRight,
                    UIInterfaceOrientationMask.portraitUpsideDown,
                    UIInterfaceOrientationMask.landscape,
                    UIInterfaceOrientationMask.all,
                    UIInterfaceOrientationMask.allButUpsideDown,
                ][value]
            }
            if let value = pageUi["presentDirection"] as? Int {
                if let dir = PNSPresentationDirection(rawValue: UInt(value)) {
                    authUiModel.presentDirection = dir
                }
            }
//                        if let value = pageUi["customViewBlock"] as? Any {
//                            authUiModel.customViewBlock = value
//                        }
//                        if let value = pageUi["customViewLayoutBlock"] as? Any {
//                            authUiModel.customViewLayoutBlock = value
//                        }
        }
        if let privacyAlertUi = args["privacyAlertUi"] as? [String: Any] {
            if let value = privacyAlertUi["alertTitleBarColor"] as? Int {
                authUiModel.alertTitleBarColor = value.toColor()
            }
            if let value = privacyAlertUi["alertBarIsHidden"] as? Bool {
                authUiModel.alertBarIsHidden = value
            }
            if let value = privacyAlertUi["alertTitle"] as? [String: Any] {
                if let text = value.toNSAttributedString() { authUiModel.alertTitle = text }
            }
            if let value = privacyAlertUi["alertCloseImage"] as? String {
                if let image = value.toUIImage(registrar) {
                    authUiModel.alertCloseImage = image
                }
            }
            if let value = privacyAlertUi["alertCloseItemIsHidden"] as? Bool {
                authUiModel.alertCloseItemIsHidden = value
            }
            if let value = privacyAlertUi["alertTitleBarFrameBlock"] as? Bool, value {
                authUiModel.alertTitleBarFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("alertTitleBarFrameBlock", screenSize, superViewSize, frame)
                    if let value = privacyAlertUi["alertTitleBarFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = privacyAlertUi["alertTitleFrameBlock"] as? Bool, value {
                authUiModel.alertTitleFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("alertTitleFrameBlock", screenSize, superViewSize, frame)
                    if let value = privacyAlertUi["alertTitleFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = privacyAlertUi["alertCloseItemFrameBlock"] as? Bool, value {
                authUiModel.alertCloseItemFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("alertCloseItemFrameBlock", screenSize, superViewSize, frame)
                    if let value = privacyAlertUi["alertCloseItemFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = privacyAlertUi["alertBlurViewColor"] as? Int {
                authUiModel.alertBlurViewColor = value.toColor()
            }
            if let value = privacyAlertUi["alertBlurViewAlpha"] as? Double {
                authUiModel.alertBlurViewAlpha = value
            }
            if let value = privacyAlertUi["alertCornerRadiusArray"] as? [Int] {
                authUiModel.alertCornerRadiusArray = value.map { i in
                    NSNumber(value: i)
                }
            }

//            if let value = privacyAlertUi["setTapAuthPageMaskClosePage"] as? Bool {
//                authHelper.setTapAuthPageMaskClosePage = value
//            }
            if let value = privacyAlertUi["privacyAlertIsNeedShow"] as? Bool {
                authUiModel.privacyAlertIsNeedShow = value
            }
            if let value = privacyAlertUi["privacyAlertIsNeedAutoLogin"] as? Bool {
                authUiModel.privacyAlertIsNeedAutoLogin = value
            }

//            if let value = privacyAlertUi["privacyAlertEntryAnimation"] as? String {
//                authUiModel.privacyAlertEntryAnimation = value
//            }
//            if let value = privacyAlertUi["privacyAlertExitAnimation"] as? String {
//                authUiModel.privacyAlertIsNeedAutoLogin = value
//            }
            if let value = privacyAlertUi["privacyAlertCornerRadiusArray"] as? [Int] {
                authUiModel.privacyAlertCornerRadiusArray = value.map { i in
                    NSNumber(value: i)
                }
            }
            if let value = privacyAlertUi["privacyAlertBackgroundColor"] as? Int {
                authUiModel.privacyAlertBackgroundColor = value.toColor()
            }
            if let value = privacyAlertUi["privacyAlertAlpha"] as? Double {
                authUiModel.privacyAlertAlpha = value
            }
            if let value = privacyAlertUi["privacyAlertTitleFont"] as? [String: Any] {
                authUiModel.privacyAlertTitleFont = value.toUIFont()
            }
            if let value = privacyAlertUi["privacyAlertTitleColor"] as? Int {
                authUiModel.privacyAlertTitleColor = value.toColor()
            }
            if let value = privacyAlertUi["privacyAlertTitleBackgroundColor"] as? Int {
                authUiModel.privacyAlertTitleBackgroundColor = value.toColor()
            }
            if let value = privacyAlertUi["privacyAlertTitleAlignment"] as? Int {
                if let alignment = NSTextAlignment(rawValue: value) {
                    authUiModel.privacyAlertTitleAlignment = alignment
                }
            }
            if let value = privacyAlertUi["privacyAlertContentFont"] as? [String: Any] {
                authUiModel.privacyAlertContentFont = value.toUIFont()
            }
            if let value = privacyAlertUi["privacyAlertContentBackgroundColor"] as? Int {
                authUiModel.privacyAlertContentBackgroundColor = value.toColor()
            }
            if let value = privacyAlertUi["privacyAlertContentColors"] as? [Int] {
                authUiModel.privacyAlertContentColors = value.map { color in
                    color.toColor()
                }
            }
            if let value = privacyAlertUi["privacyAlertTitleAlignment"] as? Int {
                if let alignment = NSTextAlignment(rawValue: value) {
                    authUiModel.privacyAlertTitleAlignment = alignment
                }
            }
            if let value = privacyAlertUi["privacyAlertBtnBackgroundImages"] as? [String] {
                let imgs = value.map { image in
                    image.toUIImage(registrar)
                }
                authUiModel.privacyAlertBtnBackgroundImages = imgs.filter { $0 != nil }.map { $0! }
            }
            if let value = privacyAlertUi["privacyAlertButtonTextColors"] as? [Int] {
                authUiModel.privacyAlertButtonTextColors = value.map { color in
                    color.toColor()
                }
            }
            if let value = privacyAlertUi["privacyAlertButtonFont"] as? [String: Any] {
                authUiModel.privacyAlertButtonFont = value.toUIFont()
            }
            if let value = privacyAlertUi["privacyAlertCloseButtonIsNeedShow"] as? Bool {
                authUiModel.privacyAlertCloseButtonIsNeedShow = value
            }
            if let value = privacyAlertUi["privacyAlertCloseButtonImage"] as? String {
                if let image = value.toUIImage(registrar) {
                    authUiModel.privacyAlertCloseButtonImage = image
                }
            }
            if let value = privacyAlertUi["privacyAlertMaskIsNeedShow"] as? Bool {
                authUiModel.privacyAlertMaskIsNeedShow = value
            }
            if let value = privacyAlertUi["tapPrivacyAlertMaskCloseAlert"] as? Bool {
                authUiModel.tapPrivacyAlertMaskCloseAlert = value
            }
            if let value = privacyAlertUi["privacyAlertMaskColor"] as? Int {
                authUiModel.privacyAlertMaskColor = value.toColor()
            }
            if let value = privacyAlertUi["privacyAlertMaskAlpha"] as? Double {
                authUiModel.privacyAlertMaskAlpha = value.toCGFloat()
            }

            if let value = privacyAlertUi["privacyAlertOperatorColor"] as? Int {
                authUiModel.privacyAlertOperatorColor = value.toColor()
            }
            if let value = privacyAlertUi["privacyAlertOneColor"] as? Int {
                authUiModel.privacyAlertOneColor = value.toColor()
            }
            if let value = privacyAlertUi["privacyAlertTwoColor"] as? Int {
                authUiModel.privacyAlertTwoColor = value.toColor()
            }
            if let value = privacyAlertUi["privacyAlertThreeColor"] as? Int {
                authUiModel.privacyAlertThreeColor = value.toColor()
            }
            if let value = privacyAlertUi["privacyAlertPreText"] as? String {
                authUiModel.privacyAlertPreText = value
            }
            if let value = privacyAlertUi["privacyAlertSufText"] as? String {
                authUiModel.privacyAlertSufText = value
            }

//            if let value = privacyAlertUi["privacyAlertMaskEntryAnimation"] as? String {
//                authUiModel.privacyAlertMaskEntryAnimation = value
//            }
//            if let value = privacyAlertUi["privacyAlertMaskExitAnimation"] as? String {
//                authUiModel.privacyAlertMaskExitAnimation = value
//            }
            if let value = privacyAlertUi["privacyAlertFrameBlock"] as? Bool, value {
                authUiModel.privacyAlertFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("privacyAlertFrameBlock", screenSize, superViewSize, frame)
                    if let value = privacyAlertUi["privacyAlertFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = privacyAlertUi["privacyAlertTitleFrameBlock"] as? Bool, value {
                authUiModel.privacyAlertTitleFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("privacyAlertTitleFrameBlock", screenSize, superViewSize, frame)
                    if let value = privacyAlertUi["privacyAlertTitleFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = privacyAlertUi["privacyAlertPrivacyContentFrameBlock"] as? Bool, value {
                authUiModel.privacyAlertPrivacyContentFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("privacyAlertPrivacyContentFrameBlock", screenSize, superViewSize, frame)
                    if let value = privacyAlertUi["privacyAlertPrivacyContentFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = privacyAlertUi["privacyAlertButtonFrameBlock"] as? Bool, value {
                authUiModel.privacyAlertButtonFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("privacyAlertButtonFrameBlock", screenSize, superViewSize, frame)
                    if let value = privacyAlertUi["privacyAlertButtonFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = privacyAlertUi["privacyAlertCloseFrameBlock"] as? Bool, value {
                authUiModel.privacyAlertCloseFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
                    self.invokeFrame("privacyAlertCloseFrameBlock", screenSize, superViewSize, frame)
                    if let value = privacyAlertUi["privacyAlertCloseFrame"] as? [String: Any] {
                        return value.toCGRect()
                    }
                    return frame
                }
            }
            if let value = privacyAlertUi["privacyAlertBtnContent"] as? String {
                authUiModel.privacyAlertBtnContent = value
            }
            if let value = privacyAlertUi["privacyAlertTitleContent"] as? String {
                authUiModel.privacyAlertTitleContent = value
            }
//            if let value = privacyAlertUi["privacyAlertCustomViewBlock"] as? Any {
//                authUiModel.privacyAlertCustomViewBlock = value
//            }
//            if let value = privacyAlertUi["privacyAlertCustomViewLayoutBlock"] as? Any {
//                authUiModel.privacyAlertCustomViewLayoutBlock = value
//            }
        }
    }

    // 获取当前的 UIViewController
    private func getCurrentViewController() -> UIViewController? {
        if let appDelegate = UIApplication.shared.delegate,
           let window = appDelegate.window,
           let rootViewController = window?.rootViewController
        {
            return rootViewController
        }
        return nil
    }
}

extension [String: Any] {
    func toNSAttributedString() -> NSAttributedString? {
        if let text = self["text"] as? String {
            var attributes: [NSAttributedString.Key: Any] = [:]
            if let value = self["font"] as? [String: Any] {
                attributes[NSAttributedString.Key.font] = value.toUIFont()
            }
            if let value = self["color"] as? Int {
                attributes[NSAttributedString.Key.foregroundColor] = value.toColor()
            }
            if let value = self["backgroundColor"] as? Int {
                attributes[NSAttributedString.Key.backgroundColor] = value.toColor()
            }
            if let value = self["wordSpacing"] as? Double {
                attributes[NSAttributedString.Key.kern] = value.toCGFloat()
            }
            return NSAttributedString(string: text, attributes: attributes)
        }
        return nil
    }

    func toUILabel() -> UILabel? {
        if let text = self["text"] as? String {
            var label = UILabel()
            label.text = text
            if let value = self["color"] as? Int {
                label.textColor = value.toColor()
            }
            if let value = self["font"] as? [String: Any] {
                label.font = value.toUIFont()
            }
            return label
        }
        return nil
    }

    func toUIImageView() -> UIImageView? {
        if let image = (self["path"] as? String)?.toUIImage() {
            var imageView = UIImageView(image: image)
            if let width = self["width"] as? Double, let height = self["height"] as? Double {
                imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            }
            if let value = self["contentMode"] as? Int, let contentMode = UIView.ContentMode(rawValue: value) {
                imageView.contentMode = contentMode
            }
            imageView.contentMode = .center
            return imageView
        }
        return nil
    }

    func toUIView() -> UIView? {
        let type = self["type"] as? Int
        if type == 0 {
            return toUILabel()
        } else if type == 1 {
            return toUIImageView()
        }
        return nil
    }

    func toUIFont() -> UIFont {
        let fontSize = (self["size"] as? Int)?.toCGFloat() ?? UIFont.systemFontSize
        let isSystemBold = self["isSystemBold"] as? Bool ?? false
        if isSystemBold {
            return UIFont.boldSystemFont(ofSize: fontSize)
        } else if let fontWeight = self["weight"] as? Int {
            return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(rawValue: CGFloat(fontWeight)))
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }

    func toCGRect() -> CGRect {
        CGRect(x: self["x"] as! Double, y: self["y"] as! Double, width: self["width"] as! Double, height: self["height"] as! Double)
    }
}

extension String {
    // 资源路径转 Bundle
    func toBundle(_ registrar: FlutterPluginRegistrar) -> String? {
        Bundle.main.path(forResource: registrar.lookupKey(forAsset: self), ofType: nil)
    }

    // to ui image
    func toUIImage() -> UIImage? {
        UIImage(contentsOfFile: self)
    }

    // to ui image
    func toUIImage(_ registrar: FlutterPluginRegistrar) -> UIImage? {
        toBundle(registrar)?.toUIImage()
    }
}

extension Int {
    // 从整数转换为UIColor（支持透明度）
    func toColor() -> UIColor {
        let alpha = CGFloat((self >> 24) & 0xFF) / 255.0 // 获取透明度部分
        let red = CGFloat((self >> 16) & 0xFF) / 255.0 // 获取红色部分
        let green = CGFloat((self >> 8) & 0xFF) / 255.0 // 获取绿色部分
        let blue = CGFloat(self & 0xFF) / 255.0 // 获取蓝色部分
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Double {
    //
    func toCGFloat() -> CGFloat {
        CGFloat(self)
    }
}

extension Int {
    //
    func toCGFloat() -> CGFloat {
        CGFloat(self)
    }
}

extension CGSize {
    func toMap() -> [String: Double] {
        ["width": width, "height": height]
    }
}

extension CGRect {
    func toMap() -> [String: Any] {
        ["x": origin.x, "y": origin.y, "width": size.width, "height": size.height]
    }
}
