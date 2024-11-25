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
            result(true)
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
            print("\(call.method)===\(call.arguments)")
            setAuthUI(call)
            result(true)
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
                authHelper.debugLoginUI(with: controller, model: authUiModel) { dict in
                    result(dict)
                }
            } else {
                authHelper.getLoginToken(withTimeout: TimeInterval(args["timeout"] as! Int), controller: controller, model: authUiModel) { dict in
                    result(dict)
                }
            }
        } else {
            result(nil)
        }
    }

    func onViewFrameBlock(_ args: [String: Any], _ key: String) -> PNSBuildFrameBlock {
        let blockKey = "\(key)Block"
        let map = args[blockKey] as! [String: Any]
        return { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
            if map["frameBlock"] != nil {
                self.channel.invokeMethod("onViewFrameBlock", arguments: [
                    "key": blockKey,
                    "screenSize": screenSize.toMap(),
                    "superViewSize": superViewSize.toMap(),
                    "frame": frame.toMap(),
                ])
            }

            // frame
            if let value = map["frame"] as? [String: Any] {
                return value.toCGRect()
            }
            // size
            if let value = map["size"] as? [String: Any] {
                if let frame = value.toCGSize()?.resizeRect(originalRect: frame) {
                    return frame
                }
            }
            return frame
        }
    }

    func enableFrameBlock(_ args: [String: Any], _ key: String) -> Bool {
        if let block = args["\(key)Block"] as? [String: Any] {
            return block["frameBlock"] != nil || (args["frame"] as? [String: Any]) != nil || (args["size"] as? [String: Any]) != nil
        }
        return false
    }

    func setAuthUI(_ call: FlutterMethodCall) {
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
            if let value = (navUi["navColor"] as? String)?.toColor() {
                authUiModel.navColor = value
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

            if enableFrameBlock(navUi, "navBackButtonFrame") {
                authUiModel.navBackButtonFrameBlock = onViewFrameBlock(navUi, "navBackButtonFrame")
            }
            if enableFrameBlock(navUi, "navTitleFrame") {
                authUiModel.navTitleFrameBlock = onViewFrameBlock(navUi, "navBackButtonFrame")
            }
            if enableFrameBlock(navUi, "navMoreViewFrame") {
                authUiModel.navMoreViewFrameBlock = onViewFrameBlock(navUi, "navMoreViewFrame")
            }

            if let value = (navUi["privacyNavColor"] as? String)?.toColor() {
                authUiModel.privacyNavColor = value
            }
            if let value = navUi["privacyNavTitleFont"] as? [String: Any] {
                authUiModel.privacyNavTitleFont = value.toUIFont()
            }
            if let value = (navUi["privacyNavTitleColor"] as? String)?.toColor() {
                authUiModel.privacyNavTitleColor = value
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

            if enableFrameBlock(logoUi, "logoFrame") {
                authUiModel.logoFrameBlock = onViewFrameBlock(logoUi, "logoFrame")
            }
        }
        if let sloganUi = args["sloganUi"] as? [String: Any] {
            if let value = sloganUi["sloganText"] as? [String: Any] {
                if let text = value.toNSAttributedString() { authUiModel.sloganText = text }
            }
            if let value = sloganUi["sloganIsHidden"] as? Bool {
                authUiModel.sloganIsHidden = value
            }

            if enableFrameBlock(sloganUi, "sloganFrame") {
                authUiModel.sloganFrameBlock = onViewFrameBlock(sloganUi, "sloganFrame")
            }
        }
        if let numberUi = args["numberUi"] as? [String: Any] {
            if let value = (numberUi["numberColor"] as? String)?.toColor() {
                authUiModel.numberColor = value
            }
            if let value = numberUi["numberFont"] as? [String: Any] {
                authUiModel.numberFont = value.toUIFont()
            }
            if enableFrameBlock(numberUi, "numberFrame") {
                authUiModel.numberFrameBlock = onViewFrameBlock(numberUi, "numberFrame")
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

            if enableFrameBlock(loginBtnUi, "loginBtnFrame") {
                authUiModel.loginBtnFrameBlock = onViewFrameBlock(loginBtnUi, "loginBtnFrame")
            }
        }
        if let switchUi = args["switchUi"] as? [String: Any] {
            if let value = switchUi["changeBtnTitle"] as? [String: Any] {
                if let text = value.toNSAttributedString() { authUiModel.changeBtnTitle = text }
            }
            if let value = switchUi["changeBtnIsHidden"] as? Bool {
                authUiModel.changeBtnIsHidden = value
            }

            if enableFrameBlock(switchUi, "changeBtnFrame") {
                authUiModel.changeBtnFrameBlock = onViewFrameBlock(switchUi, "changeBtnFrame")
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
            if let value = privacyUi["privacyColors"] as? [String] {
                let colors = value.map { str in
                    str.toColor()
                }
                authUiModel.privacyColors = colors.filter { $0 != nil }.map { $0! }
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
            if enableFrameBlock(privacyUi, "privacyFrame") {
                authUiModel.privacyFrameBlock = onViewFrameBlock(privacyUi, "privacyFrame")
            }
            if let value = (privacyUi["privacyOperatorColor"] as? String)?.toColor() {
                authUiModel.privacyOperatorColor = value
            }
            if let value = (privacyUi["privacyOneColor"] as? String)?.toColor() {
                authUiModel.privacyOneColor = value
            }
            if let value = (privacyUi["privacyTwoColor"] as? String)?.toColor() {
                authUiModel.privacyTwoColor = value
            }
            if let value = (privacyUi["privacyThreeColor"] as? String)?.toColor() {
                authUiModel.privacyThreeColor = value
            }
        }
        if let pageUi = args["pageUi"] as? [String: Any] {
            if let value = pageUi["contentViewFrameBlock"] as? Bool, value {
                if enableFrameBlock(pageUi, "contentViewFrame") {
                    authUiModel.contentViewFrameBlock = onViewFrameBlock(pageUi, "contentViewFrame")
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
            if let value = (privacyAlertUi["alertTitleBarColor"] as? String)?.toColor() {
                authUiModel.alertTitleBarColor = value
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
            if enableFrameBlock(privacyAlertUi, "alertTitleBarFrame") {
                authUiModel.alertTitleBarFrameBlock = onViewFrameBlock(privacyAlertUi, "alertTitleBarFrame")
            }
            if enableFrameBlock(privacyAlertUi, "alertTitleFrame") {
                authUiModel.alertTitleFrameBlock = onViewFrameBlock(privacyAlertUi, "alertTitleFrame")
            }
            if enableFrameBlock(privacyAlertUi, "alertCloseItemFrame") {
                authUiModel.alertCloseItemFrameBlock = onViewFrameBlock(privacyAlertUi, "alertCloseItemFrame")
            }

            if let value = (privacyAlertUi["alertBlurViewColor"] as? String)?.toColor() {
                authUiModel.alertBlurViewColor = value
            }
            if let value = privacyAlertUi["alertBlurViewAlpha"] as? Double {
                authUiModel.alertBlurViewAlpha = value
            }
            if let value = privacyAlertUi["alertCornerRadiusArray"] as? [Int] {
                authUiModel.alertCornerRadiusArray = value.map { i in
                    NSNumber(value: i.toLogicalUnit())
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
                    NSNumber(value: i.toLogicalUnit())
                }
            }

            if let value = (privacyAlertUi["privacyAlertBackgroundColor"] as? String)?.toColor() {
                authUiModel.privacyAlertBackgroundColor = value
            }
            if let value = privacyAlertUi["privacyAlertAlpha"] as? Double {
                authUiModel.privacyAlertAlpha = value
            }
            if let value = privacyAlertUi["privacyAlertTitleFont"] as? [String: Any] {
                authUiModel.privacyAlertTitleFont = value.toUIFont()
            }
            if let value = (privacyAlertUi["privacyAlertTitleColor"] as? String)?.toColor() {
                authUiModel.privacyAlertTitleColor = value
            }
            if let value = (privacyAlertUi["privacyAlertTitleBackgroundColor"] as? String)?.toColor() {
                authUiModel.privacyAlertTitleBackgroundColor = value
            }
            if let value = privacyAlertUi["privacyAlertTitleAlignment"] as? Int {
                if let alignment = NSTextAlignment(rawValue: value) {
                    authUiModel.privacyAlertTitleAlignment = alignment
                }
            }
            if let value = privacyAlertUi["privacyAlertContentFont"] as? [String: Any] {
                authUiModel.privacyAlertContentFont = value.toUIFont()
            }
            if let value = (privacyAlertUi["privacyAlertContentBackgroundColor"] as? String)?.toColor() {
                authUiModel.privacyAlertContentBackgroundColor = value
            }

            if let value = privacyAlertUi["privacyAlertContentColors"] as? [String] {
                let colors = value.map { str in
                    str.toColor()
                }
                authUiModel.privacyAlertContentColors = colors.filter { $0 != nil }.map { $0! }
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

            if let value = privacyAlertUi["privacyAlertButtonTextColors"] as? [String] {
                let colors = value.map { str in
                    str.toColor()
                }
                authUiModel.privacyAlertButtonTextColors = colors.filter { $0 != nil }.map { $0! }
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

            if let value = (privacyAlertUi["privacyAlertMaskColor"] as? String)?.toColor() {
                authUiModel.privacyAlertMaskColor = value
            }
            if let value = privacyAlertUi["privacyAlertMaskAlpha"] as? Double {
                authUiModel.privacyAlertMaskAlpha = value.toCGFloat()
            }

            if let value = (privacyAlertUi["privacyAlertOperatorColor"] as? String)?.toColor() {
                authUiModel.privacyAlertOperatorColor = value
            }

            if let value = (privacyAlertUi["privacyAlertOneColor"] as? String)?.toColor() {
                authUiModel.privacyAlertOneColor = value
            }

            if let value = (privacyAlertUi["privacyAlertTwoColor"] as? String)?.toColor() {
                authUiModel.privacyAlertTwoColor = value
            }

            if let value = (privacyAlertUi["privacyAlertThreeColor"] as? String)?.toColor() {
                authUiModel.privacyAlertThreeColor = value
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
            if enableFrameBlock(privacyAlertUi, "privacyAlertFrame") {
                authUiModel.privacyAlertFrameBlock = onViewFrameBlock(privacyAlertUi, "privacyAlertFrame")
            }
            if enableFrameBlock(privacyAlertUi, "privacyAlertTitleFrame") {
                authUiModel.privacyAlertTitleFrameBlock = onViewFrameBlock(privacyAlertUi, "privacyAlertTitleFrame")
            }

            if enableFrameBlock(privacyAlertUi, "privacyAlertPrivacyContentFrame") {
                authUiModel.privacyAlertPrivacyContentFrameBlock = onViewFrameBlock(privacyAlertUi, "privacyAlertPrivacyContentFrame")
            }

            if enableFrameBlock(privacyAlertUi, "privacyAlertButtonFrame") {
                authUiModel.privacyAlertButtonFrameBlock = onViewFrameBlock(privacyAlertUi, "privacyAlertButtonFrame")
            }
            if enableFrameBlock(privacyAlertUi, "privacyAlertCloseFrame") {
                authUiModel.privacyAlertCloseFrameBlock = onViewFrameBlock(privacyAlertUi, "privacyAlertCloseFrame")
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
    func toCGSize() -> CGSize? {
        if let w = (self["width"] as? Double)?.toLogicalUnit(), let h = (self["height"] as? Double)?.toLogicalUnit() {
            return CGSize(width: w, height: h)
        }
        return nil
    }

    func toNSAttributedString() -> NSAttributedString? {
        if let text = self["text"] as? String {
            var attributes: [NSAttributedString.Key: Any] = [:]
            if let value = self["font"] as? [String: Any] {
                attributes[NSAttributedString.Key.font] = value.toUIFont()
            }

            if let value = (self["color"] as? String)?.toColor() {
                attributes[NSAttributedString.Key.foregroundColor] = value
            }
            if let value = (self["backgroundColor"] as? String)?.toColor() {
                attributes[NSAttributedString.Key.backgroundColor] = value
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
            let label = UILabel()
            label.text = text
            if let value = (self["color"] as? String)?.toColor() {
                label.textColor = value
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
            let imageView = UIImageView(image: image)
            if let width = (self["width"] as? Double)?.toLogicalUnit(), let height = (self["height"] as? Double)?.toLogicalUnit() {
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
        let fontSize = (self["size"] as? Int)?.toLogicalUnit() ?? UIFont.systemFontSize
        let isSystemBold = self["isSystemBold"] as? Bool ?? false
        if isSystemBold {
            return UIFont.boldSystemFont(ofSize: fontSize)
        } else if let fontWeight = self["weight"] as? Double {
            return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(rawValue: CGFloat(fontWeight)))
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }

    func toCGRect() -> CGRect {
        CGRect(x: (self["x"] as! Double).toLogicalUnit(), y: (self["y"] as! Double).toLogicalUnit(), width: (self["width"] as! Double).toLogicalUnit(), height: (self["height"] as! Double).toLogicalUnit())
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

extension String {
    // 从整数转换为UIColor（支持透明度）
    func toColor() -> UIColor? {
        // 去掉字符串中的 '#' 符号
        let hexString = replacingOccurrences(of: "#", with: "")

        // 确保字符串长度为 8，即 #RRGGBBAA 格式
        guard hexString.count == 8 else {
            return nil
        }

        // 使用 Scanner 来扫描十六进制字符串并转换为数字
        let scanner = Scanner(string: hexString)
        var hexNumber: UInt64 = 0

        // 扫描十六进制字符串
        if scanner.scanHexInt64(&hexNumber) {
            // 提取 ARGB 分量
            let alpha = Double((hexNumber & 0xFF000000) >> 24) / 255.0
            let red = Double((hexNumber & 0x00FF0000) >> 16) / 255.0
            let green = Double((hexNumber & 0x0000FF00) >> 8) / 255.0
            let blue = Double(hexNumber & 0x000000FF) / 255.0

            // 返回创建的 Color
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }

        // 如果解析失败，返回 nil
        return nil
    }
}

extension CGFloat {
    func toPX() -> CGFloat {
        return self * UIScreen.main.scale
    }
}

extension Double {
    func toCGFloat() -> CGFloat {
        CGFloat(self)
    }

    func toLogicalUnit() -> Double {
        return CGFloat(self) / UIScreen.main.scale
    }

    func toPX() -> CGFloat {
        return self * UIScreen.main.scale
    }
}

extension Int {
    func toCGFloat() -> CGFloat {
        CGFloat(self)
    }

    func toLogicalUnit() -> Double {
        return CGFloat(self) / UIScreen.main.scale
    }
}

extension CGSize {
    func toMap() -> [String: CGFloat] {
        ["width": width.toPX(), "height": height.toPX()]
    }

    func resizeRect(originalRect: CGRect) -> CGRect {
        // 计算原矩形的中心点
        let centerX = originalRect.origin.x + originalRect.size.width / 2
        let centerY = originalRect.origin.y + originalRect.size.height / 2

        // 计算新的矩形的原点
        let newOriginX = centerX - width / 2
        let newOriginY = centerY - height / 2

        // 返回新的 CGRect
        return CGRect(x: newOriginX, y: newOriginY, width: width, height: height)
    }
}

extension CGRect {
    func toMap() -> [String: Any] {
        ["x": origin.x.toPX(), "y": origin.y.toPX(), "width": size.width.toPX(), "height": size.height.toPX()]
    }
}
