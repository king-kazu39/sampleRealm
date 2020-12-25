//
//  AppDelegate.swift
//  sampleRealm
//
//  Created by kazuya on 2020/12/10.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(
          // 新しいスキーマバージョンを設定します。以前のバージョンより大きくなければなりません。
          // （スキーマバージョンを設定したことがなければ、最初は0が設定されています）
          schemaVersion: 3,

          // マイグレーション処理を記述します。古いスキーマバージョンのRealmを開こうとすると
          // 自動的にマイグレーションが実行されます。
          migrationBlock: { migration, oldSchemaVersion in
            // 最初のマイグレーションの場合、`oldSchemaVersion`は0です
            if (oldSchemaVersion < 1) {
              // 何もする必要はありません！
              // Realmは自動的に新しく追加されたプロパティと、削除されたプロパティを認識します。
              // そしてディスク上のスキーマを自動的にアップデートします。
            }
          })

        // デフォルトRealmに新しい設定を適用します
        Realm.Configuration.defaultConfiguration = config
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        return true
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

