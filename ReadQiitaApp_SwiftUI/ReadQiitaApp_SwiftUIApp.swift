//
//  ReadQiitaApp_SwiftUIApp.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/14.
//

import SwiftUI

@main
struct ReadQiitaApp_SwiftUIApp: App {
    
    init() {
        RealmManager.initConfig()
    }
    
    var body: some Scene {
        WindowGroup {
            ArticleListScreen()
        }
    }
}
