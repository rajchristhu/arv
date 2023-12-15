import UIKit
import Flutter
import FirebaseCore
import GoogleMaps
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  FirebaseApp.configure()

      GMSServices.provideAPIKey("AIzaSyCRW-f7wM1mFtMvsrX8oNZ7_yhUv5Apkh8")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
