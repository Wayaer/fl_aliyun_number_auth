class AuthResultCode {
  /// 获取Token成功。
  /// -
  static const String code600000 = "600000";

  /// 唤起授权页成功。
  /// -
  static const String code600001 = "600001";

  /// 唤起授权页失败。
  /// 建议重置网络，您可以开启飞行模式后再关闭，或者建议切换到短信登录或微信登录等其他登录方式。
  static const String code600002 = "600002";

  /// 获取运营商配置信息失败。
  /// 建议升级SDK版本。您可在号码认证服务控制台下载最新版SDK。
  static const String code600004 = "600004";

  /// 手机终端不安全。
  /// 建议切换到短信登录或微信登录等其他登录方式。
  static const String code600005 = "600005";

  /// 未检测到SIM卡。
  /// 建议您检查SIM卡后重试。
  static const String code600007 = "600007";

  /// 移动数据网络未开启。
  /// 建议开启移动数据网络后重试。
  static const String code600008 = "600008";

  /// 无法判断运营商。
  /// 请检查下是否是三大运营商，即中国移动、中国联通、中国电信，暂不支持这三大运营商外的其它运营商。
  static const String code600009 = "600009";

  /// 未知异常。
  /// 建议检查下SIM卡的状态是否正常，如是否欠费等，或者重启蜂窝网络后再尝试。
  static const String code600010 = "600010";

  /// 获取Token失败。
  /// 建议检查下SIM卡的状态是否正常，如是否欠费等，或者重启蜂窝网络后再尝试，重启手机或切换到其他登录方式的操作尝试。
  static const String code600011 = "600011";

  /// 预取号失败。
  /// 建议您检查数据网络环境后重试，或切换飞行模式、重启手机或切换到其他登录方式的操作尝试。
  static const String code600012 = "600012";

  /// 运营商维护升级，该功能不可用。
  /// 建议切换到其他登录方式的操作尝试。
  static const String code600013 = "600013";

  /// 运营商维护升级，该功能调用次数已达上限。
  /// 建议切换到其他登录方式的操作尝试。
  static const String code600014 = "600014";

  /// 接口超时。
  /// 建议您尝试纯数据登录测试或切换飞行模式（打开飞行模式，然后关闭）重新唤起授权页测试是否正常。
  static const String code600015 = "600015";

  /// AppID、AppKey解析失败。
  /// 建议检查下控制台创建方案号时相关信息是否正确。
  static const String code600017 = "600017";

  /// 点击登录时检测到运营商已切换。
  /// 建议切换到短信登录或微信登录等其他登录方式。
  static const String code600021 = "600021";

  /// 加载自定义控件异常。
  /// 建议您检查自定义控件添加是否正确。
  static const String code600023 = "600023";

  /// 终端环境检查支持认证。
  /// -
  static const String code600024 = "600024";

  /// 终端检测参数错误。
  /// 建议您检查传入参数类型与范围是否正确。
  static const String code600025 = "600025";

  /// 授权页已加载时不允许调用加速或预取号接口。
  /// 建议您检查是否有授权页拉起后，调用preLogin或者accelerateAuthPage接口的行为不被允许。
  static const String code600026 = "600026";

  /// ************ 运营商SDK错误码 ************
  /// ********* 中国移动 *********
  /// 成功。
  /// -
  static const String code103000 = "103000";

  /// 网络异常。
  /// 建议检查网络设置。
  static const String code500 = "500";

  /// 获取Token结束。
  /// 建议重新获取Token。
  static const String code503 = "503";

  /// 参数为空。
  /// 检查参数是否已填写。
  static const String code130010 = "130010";

  /// 移动网关取号失败。
  /// 请检查是否网络可用，切换飞行模式、重启手机。
  static const String code105002 = "105002";

  /// 时间戳非法。
  /// 建议检查时间戳是否正确。
  static const String code105112 = "105112";

  /// App ID非法或为空。
  /// 建议检查App ID是否正确。
  static const String code105113 = "105113";

  /// 能力余量不足。
  /// 新创建的方案号移动侧需等待15-30分钟能力同步，能力没同步的情况下会报错。
  /// 手机号是否欠费，如果欠费情况下会报错。
  static const String code105312 = "105312";

  /// 错误的请求签名。
  /// 请检查控制台配置方案信息是否正确。
  static const String code103101 = "103101";

  /// WAP取号为空。
  /// -
  static const String code103134 = "103134";

  /// BusinessType配置错误。
  /// 建议检查BusinessType配置。
  static const String code110024 = "110024";

  /// 应用没有权益。
  /// -
  static const String code110023 = "110023";

  /// 权益已失效。
  /// -
  static const String code110025 = "110025";

  /// Origin校验失败。
  /// 在开放平台报备的请求来源与实际不符，origin结尾多了“/”。
  static const String code110026 = "110026";

  /// WAP网关IP错误。
  /// -
  static const String code103111 = "103111";

  /// 黑名单号码用户。
  /// -
  static const String code111002 = "111002";

  /// 物联网IP不允许取号。
  /// -
  static const String code103609 = "103609";

  /// Referer校验失败。
  /// HTTPS请求跨域导致Referer为空，生产上有HTTPS访问的，请在head中添加代码。
  static const String code170001 = "170001";

  /// 其他错误。
  /// -
  static const String code103211 = "103211";

  /// ********* 中国联通 *********
  /// 成功。
  static const String code100 = "100";

  /// 公网IP无效。非有效数据流量访问，建议检查公网IP。
  static const String code1101 = "1101";

  /// 私网IP无效。无法通过私网IP获取相关信息，重启手机后重试。
  static const String code1102 = "1102";

  /// 参数信息错误。SDK请求参数异常。
  static const String code1105 = "1105";

  /// 应用密钥信息不匹配。APP参数配置异常。
  static const String code1106 = "1106";

  /// 余额不足。请联系联通侧反馈处理。
  static const String code1107 = "1107";

  /// 取号失败。SDK接口请求失败，请重试。
  static const String code1201 = "1201";

  /// 获取凭证码失败。业务内部查询失败，请重试。
  static const String code1203 = "1203";

  /// 鉴权失败。SDK身份校验失败。
  static const String code2101 = "2101";

  /// APP ID无效。APP ID未激活或者错误。
  static const String code2201 = "2201";

  /// 应用信息错误。应用信息与已报备的信息不匹配。
  static const String code2202 = "2202";

  /// SDK信息错误。SDK信息校验失败。
  static const String code2203 = "2203";

  /// 接入信息解析错误。用户信息解析失败。
  static const String code2205 = "2205";

  /// 流控值超限。访问量超过流控限制。
  static const String code2206 = "2206";

  /// 系统繁忙。业务内部异常。
  static const String code3201 = "3201";

  /// 内部网关错误。
  static const String code3202 = "3202";

  /// 内部路由错误。
  static const String code3203 = "3203";

  /// 无支付权限。
  static const String code3204 = "3204";

  /// 当前省份不支持取号。
  static const String code3205 = "3205";

  /// 取号功能暂时不可用。
  static const String code3206 = "3206";

  /// 不支持此功能。
  static const String code3207 = "3207";

  /// 无网络连接。设备没有网络，或当前网络差且不稳定。
  static const String code10100 = "10100";

  /// 无数据网络连接。设备没有开启蜂窝网络。
  static const String code10101 = "10101";

  /// ApiKey不能为空。初始化方法传参为空。
  static const String code10102 = "10102";

  /// 超时。SDK接口访问超时。
  static const String code10103 = "10103";

  /// 数据解密异常。SDK解密数据失败。
  static const String code10106 = "10106";

  /// 通用错误。用错误/未知错误。
  static const String code10109 = "10109";

  /// 10分钟之内最多只能获取50个授权码。SDK本地实时请求流控。
  static const String code20101 = "20101";

  /// 服务端数据格式出错。SDK无法解析接口响应内。
  static const String code30200 = "30200";

  /// 服务端数据格式出错。非有效数据流量访问。
  static const String codeNeg2 = "-2";

  /// 请求超时。移动网络复杂，超时时间设置过短时，容易发生超时错误。建议超时时间设置3秒以上。
  static const String code410000 = "410000";

  /// 获取token失败。请先调用预取号接口。
  static const String code410001 = "410001";

  /// 服务响应解析异常。取号服务端返回的数据无法正常解析。
  static const String code410002 = "410002";

  /// 无法切换至数据网络。WIFI和蜂窝数据网络都开启的情况下，无法强制取号请求从蜂窝数据网络发出。
  static const String code410003 = "410003";

  /// 数据网络未开启。检测到蜂窝数据网络没有开启。
  static const String code410004 = "410004";

  /// 网络判断异常。在进行网络开通情况判断和切换过程中捕获的异常。
  static const String code410005 = "410005";

  /// 预取号过期。
  static const String code410007 = "410007";

  /// HTTP状态码是 200，302 之外的值。
  static const String code410010 = "410010";

  /// HTTPS通讯抛出异常。
  static const String code410011 = "410011";

  /// 200但body为空。
  static const String code410012 = "410012";

  /// 跳转地址错误。
  static const String code410013 = "410013";

  /// 初始化失败或者操作频繁。
  static const String code410021 = "410021";

  /// Http通讯抛出异常。
  static const String code410024 = "410024";

  /// ********* 中国电信 *********
  /// 请求成功。
  /// -
  static const String code0 = "0";

  /// 无权限访问。
  /// 请检查控制台配置方案信息是否正确。
  static const String code_64 = "-64";

  /// 调用接口超限。
  /// 请检查是否网络可用，您可以通过切换飞行模式、重启手机或切换到其他登录方式的操作尝试。
  static const String code_65 = "-65";

  /// 请求超时。
  /// 请检查是否网络可用或稍后重试。
  static const String code100003 = "100003";

  /// 网络不可用。
  /// 请检查是否网络可用。
  static const String code100004 = "100004";

  /// 用户点击导航栏按钮返回，未完成登录。
  /// -
  static const String code100005 = "100005";

  /// 未知错误。
  /// -
  static const String code100009 = "100009";

  /// 应用鉴权错误（Client ID或Client Secret错误）。
  /// 建议检查Client ID或Client Secret是否正确。
  static const String code200001 = "200001";
}

class AuthClickCode {
  /// 点击返回，用户取消免密登录。
  static const String code700000 = "700000";

  /// 点击切换按钮，用户取消免密登录。
  static const String code700001 = "700001";

  /// 点击登录按钮事件。
  static const String code700002 = "700002";

  /// 点击check box事件。
  static const String code700003 = "700003";

  /// 点击协议富文本文字事件。
  static const String code700004 = "700004";

  /// 点击一键登录拉起授权页二次弹窗。
  static const String code700006 = "700006";

  /// 隐私协议二次弹窗关闭。
  static const String code700007 = "700007";

  /// 点击隐私协议二次弹窗上同意并继续。
  static const String code700008 = "700008";

  /// 点击隐私协议二次弹窗上的协议富文本文字。
  static const String code700009 = "700009";

  /// 中断页面消失时（suspendDisMissVC设置为YES时），点击左上角返回按钮透出的状态码。
  static const String code700010 = "700010";
}
