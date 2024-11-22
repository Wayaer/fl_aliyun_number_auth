## etas 对外提供的类不被混淆
#-keep public class com.esandinfo.etas.ETASManager** { *; }
#-keep public class com.esandinfo.etas.EtasResult** { *; }
#-keep public class com.esandinfo.etas.IfaaBaseInfo {*;}
#-keep public class com.esandinfo.etas.IfaaBaseInfo$* {*;}
#-keep public class com.esandinfo.etas.IfaaCommon {*;}
#-keep public class com.esandinfo.etas.IfaaCommon$* {*;}
#-keep public class com.esandinfo.etas.model.json.** {*;}
#-keep public class com.esandinfo.etas.biz.** {*;}
#-keep public class com.esandinfo.etas.IfaaRequestBaseInfo {*;}
#-keep public class com.esandinfo.etas.callback.** {*;}
#-keep public class com.esandinfo.etas.utils.IfaaClient {*;}
## ifaa 原始接⼝不被混淆
#-keep class org.ifaa.** {*;}
## 保留所有的本地native⽅法不被混淆
#-keepclasseswithmembernames class * {
#native <methods>;
#}
##号码认证配置
#-keep public class  R.drawable.authsdk*
#-keep public class  R.layout.authsdk*
#-keep public class  R.anim.authsdk*
#-keep public class  R.id.authsdk*
#-keep public class  R.string.authsdk*
#-keep public class  R.style.authsdk*
##SDK不被混淆
#-keep class com.idsmanager.doraemonlibrary.** {*;}
