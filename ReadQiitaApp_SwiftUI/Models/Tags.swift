//
//  Tags.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/15.
//

import Foundation

struct Tags: Codable {
    let name: String
    let versions: [String]
    
    
    static func names(_ tags: [Tags]) -> String {
        var names: [String] = []
        tags.forEach {
            names.append($0.name)
        }
        return names.joined(separator: ",")
    }
}
