//
//  ArticleListViewModel.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/16.
//

import Foundation

@Observable
class ArticleListViewModel {
    
    private(set) var model: [Article] = []
    
    private(set) var isLoading = false
    
    private(set) var alertMessage = ""
    
    var isShowAlert = false
    
    var searchText = ""
    
    var mode: SearchMode = .keyword
    
    
    func fetchArticleList() {
        Task {
            do {
                isLoading = true
                
                if mode == .keyword {
                    if searchText.isEmpty {
                        model = try await APIManager.request(request: "items")
                    } else {
                        model = try await APIManager.request(request: "items", param: ["query": searchText])
                    }
                } else {
                    if searchText.isEmpty {
                        model = try await APIManager.request(request: "items")
                    } else {
                        model = try await APIManager.request(request: "tags/\(searchText)/items")
                    }
                }
                isLoading = false
            } catch {
                isLoading = false
                if let error = error as? APIError {
                    isShowAlert.toggle()
                    alertMessage = error.message
                } else {
                    isShowAlert.toggle()
                    alertMessage = error.localizedDescription
                }
            }
        }
    }
    
    enum SearchMode {
        case keyword
        case tag
    }

}
