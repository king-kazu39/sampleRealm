//
//  EditViewModel.swift
//  sampleRealm
//
//  Created by kazuya on 2020/12/22.
//

import Foundation
import RealmSwift
import Combine

final class EditViewModel: ObservableObject {
    
    // 手動で値の変更があった時にViewに伝えるクラス
    var objectWillChange: ObservableObjectPublisher = .init()
    
    // private(set)を指定し、ViewModel内だけ値を更新するようにする
    private(set) var users: Results<User> = User.all()
    
    // 変更があった時に通知する
    private var notificationTokens: [NotificationToken] = []
    
    struct Alert {
        var title: String
        var message: String
        var flag: Bool = false
    }
    
    @Published var alert: Alert = Alert(title: "", message: "", flag: false)
    
    // イニシャライズでuserモデルを読込と更新
    init(){
        notificationTokens.append(users.observe{_ in
            // swiftUIに再レンダリングする
            self.objectWillChange.send()
        })
    }
    
    /// 登録メソッド
    /// - Parameter user: Userモデル
    func create(_ user: User) {
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(user)
            }
            self.alert.title = "登録完了"
            self.alert.message = "ユーザを登録しました"
            self.alert.flag = true
        } catch let error {
            print(error.localizedDescription)
            self.alert.title = "登録失敗"
            self.alert.message = "登録に失敗しました" + "\n" + "\(error.localizedDescription)"
            self.alert.flag = true
        }
    }
    
    
    /// 更新メソッド
    /// - Parameters:
    ///   - id: UserモデルのID（プライマリキー）
    ///   - user: 更新内容
    func update(id: String, _ user: User) {
        do {
            let realm = try! Realm()
            let object = realm.object(ofType: User.self, forPrimaryKey: id)
            try realm.write {
                object?.firstname = user.firstname
                object?.lastname = user.lastname
                object?.age = user.age
                realm.add(object!, update: .modified)
            }
            self.alert.title = "更新完了"
            self.alert.message = "ユーザ情報を変更しました"
            self.alert.flag = true
        } catch let error {
            print(error.localizedDescription)
            self.alert.title = "更新失敗"
            self.alert.message = "更新に失敗しました" + "\n" + "\(error.localizedDescription)"
            self.alert.flag = true
        }
    }
    
    
    /// プライマリキーで絞り込み検索をするメソッド
    /// - Parameter id: UserモデルのID
    /// - Returns: Userモデル, なければnil
    func find(id: String) -> User? {
        return try! Realm().object(ofType: User.self, forPrimaryKey: id)
    }
    
    
    /// 削除メソッド(1件)
    /// - Parameter id: UserモデルのID
    func delete(id: String) {
        do {
            let realm = try! Realm()
            let object = realm.object(ofType: User.self, forPrimaryKey: id)
            try realm.write {
                realm.delete(object!)
            }
            self.alert.title = "削除完了"
            self.alert.message = "ユーザ情報を削除しました"
            self.alert.flag = true
        } catch let error {
            print(error.localizedDescription)
            self.alert.title = "削除失敗"
            self.alert.message = "削除に失敗しました" + "\n" + "\(error.localizedDescription)"
            self.alert.flag = true
        }
    }
    
    
}
