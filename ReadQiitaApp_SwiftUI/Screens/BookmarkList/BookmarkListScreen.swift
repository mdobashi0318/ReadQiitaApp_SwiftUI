//
//  BookmarkListScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import SwiftUI

struct BookmarkListScreen: View {
    
    @StateObject private var viewModel = BookmarkListViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            list
                .navigationTitle(R.string.label.bookmark())
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                        })
                    }
                }
                .navigationDestination(for: String.self, destination: { id in
                    if let article = viewModel.model.first(where: { $0.id == id }) {
                        ArticleScreen(id: article.id, url: article.url, title: article.title)
                            .onDisappear {
                                viewModel.allFetch()
                            }
                    }
                })
        }
    }
    
    
    @ViewBuilder
    private var list: some View {
        if viewModel.model.isEmpty {
            Text(R.string.label.noBookmark())
        } else {
            List {
                ForEach(viewModel.model) { bookmark in
                    NavigationLink(value: bookmark.id , label: {
                        Text(bookmark.title)
                    })
                }
            }
        }
    }
}

#Preview {
    BookmarkListScreen()
}
