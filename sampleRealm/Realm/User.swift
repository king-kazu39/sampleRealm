//
//  User.swift
//  sampleRealm
//
//  Created by kazuya on 2020/12/10.
//

/**
 データを保存するためのモデルを定義します
 */

import Foundation
import RealmSwift

class User: Object, Identifiable {
    @objc dynamic var id = ""
    @objc dynamic var firstname = ""
    @objc dynamic var lastname = ""
    @objc dynamic var age = 0
    @objc dynamic var createdAt = Date() // 特に指定しなければ現在時刻が代入される
    
    override class func primaryKey() -> String? { "id" }
    
    static var realm = try! Realm()
    
    static func all() -> Results<User> {
        return realm.objects(User.self).sorted(byKeyPath: "createdAt", ascending: true)
    }
    
}
