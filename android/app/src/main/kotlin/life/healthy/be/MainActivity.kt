package life.healthy.be
import io.flutter.embedding.android.FlutterActivity
//import androidx.annotation.NonNull
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "life.healthy.be/android"
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//
//        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
//        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//
//            when {
//                call.method.equals("getAppUrl") -> {
//                    try {
//
//                        val url: String = call.argument("url")!!
//                        startActivity(Intent(Intent.ACTION_VIEW, uri))
//
//                        result.success(url)
//
//                    } catch (e: Exception) {
//                        result.notImplemented()
//                    }
//                }
//            }
//        }
//
//    }

//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//
//        GeneratedPluginRegister.registerGeneratedPlugins(FlutterEngine(this));
//        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
//            {
//
//                if (call.method.equals("shareReport")) {
//                    val url: String = call.argument("url")
//                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
//                    startActivity(intent)
//                    result.success("success")
//                }
//                result.notImplemented()
//            }
//            // Note: this method is invoked on the main thread.
//            // TODO
//        }
//    }
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//            // Note: this method is invoked on the main thread.
//            call, result ->
//            if (call.method.equals("shareReport")) {
//                    val url: String = call.argument("url")
//                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
//                    startActivity(intent)
//                    result.success("success")
//            }else {
//                result.notImplemented()
//            }
//        }
//    }
}

