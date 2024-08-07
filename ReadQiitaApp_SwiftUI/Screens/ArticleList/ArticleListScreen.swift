//
//  ArticleListScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/16.
//

import SwiftUI

struct ArticleListScreen: View {
    
    @State private var viewModel = ArticleListViewModel()
    
    @State private var isBookmarkSheet = false

    
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
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        topBarTrailing
                    }
                }
                .searchable(text: $viewModel.searchText,
                            prompt: Text(viewModel.mode == .keyword ? R.string.message.keywordSearch() : R.string.message.tagSearch()))
                .onSubmit(of: .search) {
                    viewModel.fetchArticleList()
                }
                .onChange(of: viewModel.searchText) {
                    if viewModel.searchText.isEmpty {
                        viewModel.fetchArticleList()
                    }
                }
        }
        .onAppear {
            viewModel.fetchArticleList()
        }
        .alert(isPresented: $viewModel.isShowAlert) {
            alert
        }
        .fullScreenCover(isPresented: $isBookmarkSheet) {
            BookmarkListScreen()
        }
    }
    
    
    @ViewBuilder
    private var list: some View {
        if viewModel.isLoading {
            ProgressView()
        } else {
            if viewModel.model.isEmpty {
                Text(R.string.label.noArticle)
            } else {
                List {
                    ForEach(viewModel.model) { model in
                        NavigationLink(value: model.id, label: {
                            ArticleRow(article: model)
                        })
                    }
                }
                .listStyle(.inset)
                .refreshable {
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
    
    @ViewBuilder
    private var topBarTrailing: some View {
            Menu(content: {
                Button(action: {
                    viewModel.mode = .keyword
                }, label: {
                    if viewModel.mode == .keyword {
                        Label(R.string.label.keywordSearch(), systemImage: "checkmark")
                    } else {
                        Text(R.string.label.keywordSearch())
                    }
                    
                })
                Button(action: {
                    viewModel.mode = .tag
                }, label: {
                    if viewModel.mode == .tag {
                        Label(R.string.label.tagSearch(), systemImage: "checkmark")
                    } else {
                        Text(R.string.label.tagSearch())
                    }
                })
            }, label: {
                Image(systemName: "magnifyingglass")
            })
            
            Button(action: {
                isBookmarkSheet.toggle()
            }, label: {
                Image(systemName: "bookmark")
            })
    }
}

#Preview {
    ArticleListScreen()
}
