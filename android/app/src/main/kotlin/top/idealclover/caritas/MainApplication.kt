package top.idealclover.caritas

import io.flutter.app.FlutterApplication
import com.umeng.commonsdk.UMConfigure
import com.umeng.analytics.MobclickAgent

class MainApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()

        //设置LOG开关，默认为false
        UMConfigure.setLogEnabled(true)

        //友盟预初始化
        UMConfigure.preInit(getApplicationContext(), "5f8ef217fac90f1c19a7b0f3", "Umeng")
    }
}