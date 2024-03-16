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
    
    @MainActor
    func fetchArticleList() {
        Task {
            do {
                isLoading = true
                model = try await APIManager.request(request: "items")
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
}
