//
//  BookmarkListViewModel.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/20.
//

import Foundation


class BookmarkListViewModel: ObservableObject {
    
    @Published var model: [Bookmark] = []
    
    @Published var alertMessage = ""
    
    @Published var isAlertFlag = false
    
    init() {
        allFetch()
    }
    
    func allFetch() {
        do {
            model = try Bookmark.allFetch()
        } catch {
            alertMessage = ""
            isAlertFlag.toggle()
        }
        
    }
    
}
