import UIKit
import WebKit
import Capacitor

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Handle transitions
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Handle background
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Handle foreground
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Handle active state
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Handle termination
    }

    // Handle incoming messages from JavaScript
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return ApplicationDelegateProxy.shared.application(app, open: url, options: options)
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return ApplicationDelegateProxy.shared.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
    // Setup message handler when WebView is ready
    func setupMessageHandler() {
        if let bridgeViewController = window?.rootViewController as? CAPBridgeViewController {
            // Ensure the WebView is ready before adding the message handler
            if let webView = bridgeViewController.webView {
                webView.configuration.userContentController.add(self, name: "sendHtmlContent")
                print("Message handler added.")
            } else {
                print("WebView is not yet available.")
            }
        }
    }

}

// Conform to WKScriptMessageHandler to receive messages
extension AppDelegate: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "sendHtmlContent", let htmlContent = message.body as? String {
            print("Received HTML content: \(htmlContent)")
            // Now you can process the HTML content as needed in Swift
        }
    }
}
