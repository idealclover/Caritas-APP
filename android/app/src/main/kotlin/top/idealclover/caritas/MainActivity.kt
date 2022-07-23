package top.idealclover.caritas

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.umeng.commonsdk.UMConfigure
import com.umeng.analytics.MobclickAgent

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        //设置LOG开关，默认为false
        UMConfigure.setLogEnabled(true)

        //友盟预初始化
        UMConfigure.preInit(getApplicationContext(), "5f8ef217fac90f1c19a7b0f3", "Umeng")
    }
}
