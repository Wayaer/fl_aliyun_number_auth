import 'package:example/main.dart';
import 'package:example/src/const.dart';
import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:flutter/material.dart';

AuthUIModelForIOS buildIOSUi(BuildContext context) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  final width = mediaQuery.size.width.toInt();
  final height = mediaQuery.size.height.toInt();
  // final top = mediaQuery.viewPadding.top.toInt();
  // final logBtnHeight = 44;
  final primaryColor = Theme.of(context).primaryColor;
  final bodyColor =
      Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black87;

  // final dialogWidth = width - 30;
  // final dialogHeight = 400.0;
  // final margin = 15.0;
  // final padding = 12.0;
  // final dialogX = margin;
  // final dialogY = height - dialogHeight - margin;

  return AuthUIModelForIOS(
      statusBarUi: StatusBarUIModelForIOS(
        prefersStatusBarHidden: false,
        preferredStatusBarStyle: UIStatusBarStyle.defaultStyle,
      ),
      navUi: NavUIModelForIOS(
        navColor: Colors.white,
        navTitle: NSAttributedString(
            text: '一键登录',
            color: bodyColor,
            backgroundColor: bodyColor,
            font: UIFont(size: 20.toPx(context), weight: UIFontWeight.bold)),
        navBackImage: AS.back,
        navBackButtonFrameBlock: ViewFrameBlockForIOS(
          size: Size(22.0.toPx(context), 22.0.toPx(context)),
        ),
        privacyNavColor: Colors.white,
        privacyNavTitleFont:
            UIFont(size: 20.toPx(context), weight: UIFontWeight.bold),
        privacyNavTitleColor: bodyColor,
        privacyNavBackImage: AS.back,
      ),
      logoUi: LogoUIModelForIOS(
          logoImage: AS.logo,
          logoIsHidden: false,
          logoFrameBlock: ViewFrameBlockForIOS(
            // size: Size(50.0.toPx(context), 50.0.toPx(context)),
            offset: Offset(0, -30.0.toPx(context)),
          )),
      sloganUi: SloganUIModelForIOS(
          sloganText: NSAttributedString(text: '欢迎来到芯赛虎智能生活', color: bodyColor),
          sloganIsHidden: false,
          sloganFrameBlock: ViewFrameBlockForIOS(
            offset: Offset(0, -80.0.toPx(context)),
          )),
      numberUi: NumberUIModelForIOS(
          numberColor: bodyColor,
          numberFont: UIFont(size: 24, weight: UIFontWeight.bold),
          numberFrameBlock: ViewFrameBlockForIOS(
            offset: Offset(0, -120.0.toPx(context)),
          )),
      loginBtnUi: LoginBtnUIModelForIOS(
          loginBtnText: NSAttributedString(text: '一键登录', color: Colors.white),
          loginBtnBgImgs: [
            AS.loginBtnNormal,
            AS.loginBtnUnable,
            AS.loginBtnPress,
          ],
          autoHideLoginLoading: true,
          loginBtnFrameBlock: ViewFrameBlockForIOS(
            size: Size(200.0.toPx(context), 40.0.toPx(context)),
            offset: Offset(0, -140.0.toPx(context)),
          )),
      switchUi: SwitchUIModelForIOS(
          changeBtnTitle: NSAttributedString(text: '其他的', color: bodyColor),
          changeBtnIsHidden: true,
          changeBtnFrameBlock: ViewFrameBlockForIOS()),
      privacyUi: PrivacyUIModelForIOS(
        checkBoxImages: [AS.uncheckIcon, AS.checkIcon],
        checkBoxIsChecked: false,
        checkBoxIsHidden: false,
        checkBoxWH: 22.toPx(context).toDouble(),
        privacyOne: PrivacyTextUrl(text: '《用户协议》', url: 'www.baidu.com'),
        privacyTwo: PrivacyTextUrl(text: '《隐私政策》', url: 'www.baidu.com'),
        privacyColors: [bodyColor, primaryColor],
        privacyAlignment: NSTextAlignment.left,
        privacyPreText: '我已阅读并同意',
        privacyOperatorPreText: '《',
        privacyOperatorSufText: '》',
        privacyFont:
            UIFont(size: 13.toPx(context), weight: UIFontWeight.regular),
        privacyFrameBlock: ViewFrameBlockForIOS(),
        privacyOperatorColor: primaryColor,
        privacyOneColor: primaryColor,
        privacyTwoColor: primaryColor,
        privacyThreeColor: primaryColor,
      ),
      pageUi: PageUIModelForIOS(
        contentViewFrameBlock: ViewFrameBlockForIOS(
          frame: Rect.fromLTWH(
              15.0.toPx(context),
              ((height - 400 - 15)).toDouble().toPx(context),
              (width - 30).toDouble().toPx(context),
              400.0.toPx(context)),
        ),
        supportedInterfaceOrientations: UIInterfaceOrientationMask.portrait,
        presentDirection: PNSPresentationDirection.bottom,
        alertBarIsHidden: false,
        alertTitleBarColor: Colors.transparent,
        alertTitle: NSAttributedString(
            text: '一键登录',
            color: bodyColor,
            font: UIFont(size: 20.toPx(context), weight: UIFontWeight.bold)),
        alertCloseImage: AS.close,
        alertCloseItemIsHidden: false,
        tapAuthPageMaskClosePage: true,
        alertCloseItemFrameBlock: ViewFrameBlockForIOS(
          offset: Offset(10.0.toPx(context), 0),
          size: Size(18.0.toPx(context), 18.0.toPx(context)),
        ),
        alertCornerRadiusArray: [
          4.toPx(context),
          4.toPx(context),
          4.toPx(context),
          4.toPx(context),
        ],
      ),
      privacyAlertUi: PrivacyAlertUIModelForIOS(
        privacyAlertIsNeedShow: true,
        privacyAlertIsNeedAutoLogin: true,
        privacyAlertCornerRadiusArray: [
          4.toPx(context),
          4.toPx(context),
          4.toPx(context),
          4.toPx(context),
        ],

        privacyAlertBtnBackgroundImages: [
          AS.loginBtnNormal,
          AS.loginBtnUnable,
          AS.loginBtnPress,
        ],
        privacyAlertButtonTextColors: [
          Colors.white,
          Colors.white,
          Colors.white,
        ],

        privacyAlertCloseButtonIsNeedShow: true,
        privacyAlertCloseButtonImage: AS.close,
        privacyAlertMaskIsNeedShow: true,
        tapPrivacyAlertMaskCloseAlert: false,
        // privacyAlertMaskColor: primaryColor,
        // privacyAlertMaskAlpha: 0.5,
        privacyAlertOperatorColor: bodyColor,
        // privacyAlertOneColor: primaryColor,
        // privacyAlertTwoColor: primaryColor,
        // privacyAlertThreeColor: primaryColor,
        privacyAlertPreText: "我已阅读并同意",
        // privacyAlertSufText: "后缀",
        // privacyAlertFrameBlock: ViewFrameBlockForIOS(),
        privacyAlertTitleContent: '温馨提示',
        privacyAlertTitleFont:
            UIFont(size: 20.toPx(context), weight: UIFontWeight.regular),
        privacyAlertTitleColor: bodyColor,
        // privacyAlertTitleBackgroundColor: primaryColor,
        privacyAlertTitleAlignment: NSTextAlignment.center,
        privacyAlertTitleFrameBlock: ViewFrameBlockForIOS(
          offset: Offset(0, 16.0.toPx(context)),
        ),
        privacyAlertContentFont:
            UIFont(size: 14.toPx(context), weight: UIFontWeight.regular),
        privacyAlertContentColors: [
          bodyColor,
          bodyColor,
          bodyColor,
        ],
        privacyAlertContentAlignment: NSTextAlignment.center,
        privacyAlertContentBackgroundColor: Colors.white,
        privacyAlertPrivacyContentFrameBlock: ViewFrameBlockForIOS(
          size: Size((width * 0.8).toPx(context), 0),
          offset: Offset(0, 30.0.toPx(context)),
        ),
        privacyAlertCloseFrameBlock: ViewFrameBlockForIOS(
          offset: Offset(10.0.toPx(context), 0),
          size: Size(18.0.toPx(context), 18.0.toPx(context)),
          // size: Size(18.0.toPx(context), 18.0.toPx(context)),
        ),
        privacyAlertBtnContent: '同意并继续',
        privacyAlertButtonFont: UIFont(
          size: 18.toPx(context),
          weight: UIFontWeight.regular,
        ),
        privacyAlertButtonFrameBlock: ViewFrameBlockForIOS(
          size: Size(200.0.toPx(context), 44.0.toPx(context)),
          offset: Offset(0, 30.0.toPx(context)),
        ),
        // privacyAlertCustomViewBlock:   ,
        // privacyAlertCustomViewLayoutBlock:   ,
      ));
}
