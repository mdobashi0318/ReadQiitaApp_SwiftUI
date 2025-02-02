//
//  Bookmark.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import Foundation
import RealmSwift

struct DBError: Error {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
}



class Bookmark: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: String = ""
     
    @Persisted var title: String = ""
     
    @Persisted var url: String = ""
    
    
    static func allFetch() throws(DBError) -> [Bookmark] {
        do {
            var model: [Bookmark] = []
            let realm = try Realm()
            realm.objects(Bookmark.self).freeze().forEach {
                model.append($0)
            }
            return model
        } catch {
            throw DBError(message: R.string.message.errorMessage())
        }
    }
     
}
