//
//  SearchMode.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2026/03/09.
//

import Foundation

enum SearchMode: String {
    case keyword
    case tag
    
    var title: String {
        return switch self {
        case .keyword:
            R.string.label.keywordSearch()
        case .tag:
            R.string.label.tagSearch()
        }
    }
}
