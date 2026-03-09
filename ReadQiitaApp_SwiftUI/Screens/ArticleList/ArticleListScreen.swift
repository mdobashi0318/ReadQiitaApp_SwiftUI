//
//  ArticleListScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/16.
//

import SwiftUI

struct ArticleListScreen: View {
    
    enum DispMode: String {
        case list
        case grid
        
        var title: String {
            return switch self {
            case .list:
                R.string.label.listMode()
            case .grid:
                R.string.label.gridMode()
            }
        }
    }
    
    @State private var viewModel = ArticleListViewModel()
    @State private var isBookmarkSheet = false
    @State private var isHistorySheet = false
    @AppStorage("dispMode") private var dispMode: DispMode = .list
    @AppStorage("SearchMode") private var searchMode: SearchMode = .keyword
    
    var body: some View {
        NavigationStack {
            contentsView
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
                    
                    ToolbarItemGroup(placement: .topBarLeading) {
                        topBarLeading
                    }
                }
                .searchable(text: $viewModel.searchText,
                            prompt: Text(searchMode == .keyword ? R.string.message.keywordSearch() : R.string.message.tagSearch()))
                .onSubmit(of: .search) {
                    viewModel.fetchArticleList(searchMode)
                }
                .onChange(of: viewModel.searchText) {
                    if viewModel.searchText.isEmpty {
                        viewModel.fetchArticleList(searchMode)
                    }
                }
        }
        .onAppear {
            viewModel.fetchArticleList(searchMode)
        }
        .alert(isPresented: $viewModel.isShowAlert) {
            alert
        }
        .fullScreenCover(isPresented: $isBookmarkSheet) {
            BookmarkListScreen()
        }
        .fullScreenCover(isPresented: $isHistorySheet) {
            HistoryListScreen()
        }
    }
    
    @ViewBuilder
    private var contentsView: some View {
        if viewModel.isLoading {
            ProgressView()
        } else {
            if viewModel.model.isEmpty {
                Text(R.string.label.noArticle)
            } else {
                if dispMode == .list {
                    listView
                } else {
                    gridView
                }
            }
        }
    }
    
    private var listView: some View {
        List {
            ForEach(viewModel.model) { model in
                NavigationLink(value: model.id, label: {
                    ArticleRow(article: model)
                })
            }
        }
        .listStyle(.inset)
        .refreshable {
            viewModel.fetchArticleList(searchMode)
        }
    }
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                ForEach(viewModel.model) { model in
                    NavigationLink(value: model.id, label: {
                        ArticleGridRow(article: model)
                    })
                }
            }
        }
        .refreshable {
            viewModel.fetchArticleList(searchMode)
        }
    }
    
    private var alert: Alert {
        Alert(title: Text(viewModel.alertMessage),
              primaryButton: .default(Text(R.string.button.retry()),
                                      action: { viewModel.fetchArticleList(searchMode) }
                                     ),
              secondaryButton: .cancel(Text(R.string.button.close()))
        )
    }
    
    @ViewBuilder
    private var topBarTrailing: some View {
        dispModeButton
        searchModeButton
        Button(action: {
            isBookmarkSheet.toggle()
        }, label: {
            Image(systemName: "bookmark")
        })
    }
    
    private var searchModeButton: some View {
        Menu(content: {
            Button(action: {
                searchMode = .keyword
            }, label: {
                if searchMode == .keyword {
                    Label(R.string.label.keywordSearch(), systemImage: "checkmark")
                } else {
                    Text(R.string.label.keywordSearch())
                }
                
            })
            Button(action: {
                searchMode = .tag
            }, label: {
                if searchMode == .tag {
                    Label(R.string.label.tagSearch(), systemImage: "checkmark")
                } else {
                    Text(R.string.label.tagSearch())
                }
            })
        }, label: {
            Image(systemName: "magnifyingglass")
        })
    }
    
    private var dispModeButton: some View {
        Menu(content: {
            Button(action: {
                dispMode = .list
            }, label: {
                if dispMode == .list {
                    Label(DispMode.list.title, systemImage: "checkmark")
                } else {
                    Text(DispMode.list.title)
                }
            })
            Button(action: {
                dispMode = .grid
            }, label: {
                if dispMode == .grid {
                    Label(DispMode.grid.title, systemImage: "checkmark")
                } else {
                    Text(DispMode.grid.title)
                }
            })
        }, label: {
            Image(systemName: dispMode == .list ? "list.dash" : "square.grid.2x2")
        })
    }
    
    @ViewBuilder
    private var topBarLeading: some View {
        Button(action: {
            isHistorySheet.toggle()
        }, label: {
            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
        })
    }
}

#Preview {
    ArticleListScreen()
}
