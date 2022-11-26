package life.healthy.be
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.annotation.SuppressLint;

import android.content.Intent;


class MainActivity: FlutterActivity() {
    private val CHANNEL = "life.healthy.be/android"
//    private var methodChannel: MethodChannel? = null
//
//    @SuppressLint("NewApi")
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL);
//        methodChannel?.setMethodCallHandler { call, result ->
//            if (call.method == "shareReport") {
//                var url = call.argument<String>("url");
//                val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME);
//                // 실행 가능한 앱이 있으면 앱 실행
//                if (intent.resolveActivity(packageManager) != null) {
//                    val existPackage = packageManager.getLaunchIntentForPackage("" + intent.getPackage());
//                    startActivity(intent)
//                    result.success(null);
//                } else {
//                    // Fallback URL이 있으면 현재 웹뷰에 로딩
//                    val fallbackUrl = intent.getStringExtra("browser_fallback_url")
//                    if (fallbackUrl != null) {
//                        result.success(fallbackUrl);
//                    }
//                }
//            } else {
//                result.notImplemented()
//            }
//        }
//    }

}

