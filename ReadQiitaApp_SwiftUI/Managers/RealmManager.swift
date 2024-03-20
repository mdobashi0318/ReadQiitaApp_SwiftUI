//
//  RealmManager.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/20.
//

import Foundation
import RealmSwift


struct RealmManager {
    
        static func initConfig() {
            var configuration = Realm.Configuration(schemaVersion: 1)
            guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.masaharu.dobashi.ReadQiitaApp_SwiftUI") else { return }
            configuration.fileURL = url.appendingPathComponent("db.realm")
            Realm.Configuration.defaultConfiguration = configuration
        }
        
}

