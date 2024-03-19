//
//  ArticleListViewModel.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/16.
//

import Foundation

class ArticleListViewModel: ObservableObject {
    
    @Published var model: [Article] = []
    
    @Published var isLoading = false
    
    @Published var alertMessage = ""
    
    @Published var isAlertFlag = false
    
    @Published var searchText = ""
    
    var mode: SearchMode = .keyword
    
    @MainActor
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
                    isAlertFlag.toggle()
                    alertMessage = error.message
                } else {
                    isAlertFlag.toggle()
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
