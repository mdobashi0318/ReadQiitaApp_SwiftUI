//
//  ReadQiitaApp_SwiftUIApp.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/14.
//

import SwiftUI
import SwiftData

@main
struct ReadQiitaApp_SwiftUIApp: App {
    
    var body: some Scene {
        WindowGroup {
            ArticleListScreen()
                .modelContainer(for: [Bookmark.self, History.self], isAutosaveEnabled: true)
        }
    }
}
