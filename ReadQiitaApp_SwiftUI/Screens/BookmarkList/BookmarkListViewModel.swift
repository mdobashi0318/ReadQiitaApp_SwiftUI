//
//  BookmarkListViewModel.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/20.
//

import Foundation

@Observable
class BookmarkListViewModel {
    
    var model: [Bookmark] = []
    
    var isShowAlert = false
    
    private(set) var alertMessage = ""
    
    init() {
        allFetch()
    }
    
    func allFetch() {
        do {
            model = try Bookmark.allFetch()
        } catch {
            alertMessage = R.string.message.errorMessage()
            isShowAlert.toggle()
        }
        
    }
    
}
