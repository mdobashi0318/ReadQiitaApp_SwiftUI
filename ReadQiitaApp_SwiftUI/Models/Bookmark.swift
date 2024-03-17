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
     
}
