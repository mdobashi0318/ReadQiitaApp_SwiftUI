//
//  Bookmark.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import Foundation
import SwiftData

struct DBError: Error {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
}


@Model
class Bookmark {
    
    @Relationship(.unique) var id: String = ""
    
    var title: String = ""
    
    var url: String = ""
    
    init() { }
    
}
