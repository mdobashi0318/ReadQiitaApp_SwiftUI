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



extension Article {
    static var mock1: Article {
        Article(created_at: "", likes_count: 1, title: "Title1",
                user: User(description: nil,
                           facebook_id: nil,
                           followees_count: 0,
                           followers_count: 0,
                           github_login_name: nil,
                           id: "",
                           items_count: 1,
                           linkedin_id: nil,
                           location: nil,
                           name: "TestName1",
                           organization: nil,
                           permanent_id: 0,
                           profile_image_url: nil,
                           team_only: false,
                           twitter_screen_name: nil,
                           website_url: nil),
                tags: [
                    Tags(name: "Swift", versions: []),
                    Tags(name: "iOS", versions: [])
                ],
                url: "",
                id: "")
    }
    
    static var mock2: Article {
        Article(created_at: "", likes_count: 0, title: "Title2",
                user: User(description: nil,
                           facebook_id: nil,
                           followees_count: 0,
                           followers_count: 0,
                           github_login_name: nil,
                           id: "",
                           items_count: 1,
                           linkedin_id: nil,
                           location: nil,
                           name: "TestName2",
                           organization: "organization",
                           permanent_id: 0,
                           profile_image_url: nil,
                           team_only: false,
                           twitter_screen_name: nil,
                           website_url: nil),
                tags: [
                    Tags(name: "Swift", versions: [])
                ],
                url: "",
                id: "")
    }
    
}

