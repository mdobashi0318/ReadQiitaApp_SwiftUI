//
//  Article.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/15.
//

import Foundation

struct Article : Codable, Identifiable {
    let created_at: String
    let likes_count: Int
    let title: String
    let user: User
    let tags: [Tags]
    let url: String
    let id: String
}

