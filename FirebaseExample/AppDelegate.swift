//
//  AppDelegate.swift
//  FirebaseExample
//
//  Created by 신승아 on 2022/10/05.
//

import UIKit

import FirebaseCore
import FirebaseMessaging
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(schemaVersion: 3) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 { // DetailToDo, List 추가
                
            }
            
            if oldSchemaVersion < 2 { //EmbededObject 추가
                
            }
            
            if oldSchemaVersion < 3 { //DetailTodo에 deadline 추가
                
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        
        
        
        
//        aboutRealmMigration()
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        // 알림 시스템에 앱을 등록
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self
        
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        // 메시지 대리자 설정
        Messaging.messaging().delegate = self

        return true
    }
    
    // 포그라운드 알림 수신: 로컬 / 푸시 동일
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .banner, .list])
        print(#function)
    }
    
    // 토큰 갱신 모니터링
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.body)
        print(response.notification.request.content.userInfo)
        
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        print(viewController)
        if viewController is ViewController { // is as 타입캐스팅
            viewController.navigationController?.pushViewController(SettingViewController(), animated: true)
        }
        
        if viewController is ProfileViewController {
            viewController.dismiss(animated: true)
        }
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    func aboutRealmMigration() {

        // deleteRealmIfMigrationNeeded: 마이그레이션이 필요한 경우 기존 Realm 삭제
        // 단, 개발할 때만 사용해야.. (Realm 브라우저 닫고 다시 열어야 해)
//        let config = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
//        Realm.Configuration.defaultConfiguration = config
        
        let config = Realm.Configuration(schemaVersion: 1) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                
            }
            
            if oldSchemaVersion < 2 {
                
            }
            
            if oldSchemaVersion < 3 {
                migration.renameProperty(onType: Todo.className(), from: "importance", to: "favorite")
            }
        }


    }
}
