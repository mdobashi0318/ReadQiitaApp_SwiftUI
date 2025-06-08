//
//  BookmarkListScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import SwiftUI
import SwiftData

struct BookmarkListScreen: View {
    
    @Query private var bookmarks: [Bookmark]
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isShowAlert = false
    
    @State private var alertMessage = ""
    
    init() {
        _bookmarks = Query(sort: [SortDescriptor(\Bookmark.update_at, order: .reverse)])
    }
    
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
                .navigationDestination(for: Bookmark.self, destination: { bookmark in
                    ArticleScreen(id: bookmark.id, url: bookmark.url, title: bookmark.title)
                })
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text(alertMessage),
                          dismissButton: .cancel(Text("閉じる"), action: { dismiss() })
                    )
                }
        }
    }
    
    
    @ViewBuilder
    private var list: some View {
        if bookmarks.isEmpty {
            Text(R.string.label.noBookmark())
        } else {
            List {
                ForEach(bookmarks) { bookmark in
                    NavigationLink(value: bookmark , label: {
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
