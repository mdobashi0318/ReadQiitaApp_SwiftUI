//
//  History.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2025/06/03.
//

import SwiftData

@Model
class History {
    
    @Attribute(.unique) var id: String = ""
    
    var title: String = ""
    
    var url: String = ""
    
    var created_at: String = ""
    
    var update_at: String = ""
    
    init() { }
    
}
