//
//  Bookmark.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import Foundation
import RealmSwift

class Bookmark: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: String = ""
     
    @Persisted var title: String = ""
     
    @Persisted var url: String = ""
    
    
    static func allFetch() throws -> [Bookmark] {
        do {
            var model: [Bookmark] = []
            let realm = try Realm()
            realm.objects(Bookmark.self).freeze().forEach {
                model.append($0)
            }
            return model
        } catch {
            throw APIError(message: "")
        }
    }
     
}
