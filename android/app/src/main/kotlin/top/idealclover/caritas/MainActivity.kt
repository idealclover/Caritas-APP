package top.idealclover.caritas

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.umeng.commonsdk.utils.UMUtils
import com.umeng.commonsdk.UMConfigure
import com.umeng.message.PushAgent
import com.umeng.message.api.UPushRegisterCallback
import com.umeng.analytics.MobclickAgent

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //设置LOG开关，默认为false
        UMConfigure.setLogEnabled(true)

        //友盟预初始化
        PushAgent.setup(context, "62cebc7788ccdf4b7ecc81f4", "ae0d0b4130ba1e0c2337730db6c75131")
        PushAgent.getInstance(context).setResourcePackageName("top.idealclover.caritas")
        UMConfigure.preInit(getApplicationContext(), "62cebc7788ccdf4b7ecc81f4", "Umeng")
        if (UMUtils.isMainProgress(this)) {
            Thread(Runnable {
                UMConfigure.init(context, UMConfigure.DEVICE_TYPE_PHONE, "ae0d0b4130ba1e0c2337730db6c75131")
                PushAgent.getInstance(context).register(object : UPushRegisterCallback {
                    override fun onSuccess(deviceToken: String) {
                    }

                    override fun onFailure(p0: String?, p1: String?) {
                    }
                })
            }).start()
        } else {
            UMConfigure.init(context, UMConfigure.DEVICE_TYPE_PHONE, "ae0d0b4130ba1e0c2337730db6c75131")
            PushAgent.getInstance(context).register(object : UPushRegisterCallback {
                override fun onSuccess(deviceToken: String) {
                }

                override fun onFailure(p0: String?, p1: String?) {
                }
            })
        }
    }
}
