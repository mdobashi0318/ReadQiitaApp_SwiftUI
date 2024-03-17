//
//  ArticleListScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/16.
//

import SwiftUI

struct ArticleListScreen: View {
    
    @StateObject private var viewModel = ArticleListViewModel()
    
    var body: some View {
        NavigationStack {
            list
                .navigationTitle("ReadQiitaApp")
        }
        .onAppear {
            viewModel.fetchArticleList()
        }
        .alert(isPresented: $viewModel.isAlertFlag) {
            alert
        }
    }
    
    
    @ViewBuilder
    private var list: some View {
        if viewModel.isLoading {
            ProgressView()
        } else {
            List {
                ForEach(viewModel.model) { model in
                    ArticleRow(article: model)
                }
            }
            .listStyle(.inset)
        }
    }
    
    private var alert: Alert {
        Alert(title: Text(viewModel.alertMessage),
              primaryButton: .default(Text(R.string.button.retry()),
                                      action: viewModel.fetchArticleList
                                     ),
              secondaryButton: .cancel(Text(R.string.button.close()))
        )
    }
}

#Preview {
    ArticleListScreen()
}
