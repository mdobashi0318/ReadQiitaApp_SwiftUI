//
//  ArticleListScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/16.
//

import SwiftUI

struct ArticleListScreen: View {
    
    @StateObject private var viewModel = ArticleListViewModel()
    
    @State var isSheet = false
    
    var body: some View {
        NavigationStack {
            list
                .navigationTitle("ReadQiitaApp")
                .navigationDestination(for: String.self) { id in
                    if let article = viewModel.model.first(where: { $0.id == id }) {
                        ArticleScreen(id: article.id, url: article.url, title: article.title)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button(action: {
                            isSheet.toggle()
                        }, label: {
                            Image(systemName: "bookmark")
                        })
                    })
                }
        }
        .onAppear {
            viewModel.fetchArticleList()
        }
        .alert(isPresented: $viewModel.isAlertFlag) {
            alert
        }
        .sheet(isPresented: $isSheet) {
            BookmarkListScreen()
        }
    }
    
    
    @ViewBuilder
    private var list: some View {
        if viewModel.isLoading {
            ProgressView()
        } else {
            List {
                ForEach(viewModel.model) { model in
                    NavigationLink(value: model.id, label: {
                        ArticleRow(article: model)
                    })
                }
            }
            .listStyle(.inset)
            .searchable(text: $viewModel.searchText)
            .onSubmit(of: .search) {
                viewModel.fetchArticleList()
            }
            .onChange(of: viewModel.searchText) { text in
                if text.isEmpty {
                    viewModel.fetchArticleList()
                }
            }
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
