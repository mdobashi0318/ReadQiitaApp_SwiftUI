//
//  BookmarkListScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import SwiftUI
import RealmSwift

struct BookmarkListScreen: View {
    
    @ObservedResults(Bookmark.self) var bookmarks
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(bookmarks) { bookmark in
                    NavigationLink(value: bookmark.id , label: {
                        Text(bookmark.title)
                    })
                }
            }
            .navigationTitle("ブックマーク")
            .navigationDestination(for: String.self, destination: { id in
                if let article = bookmarks.first(where: { $0.id == id }) {
                    ArticleScreen(id: article.id, url: article.url, title: article.title)
                }
            })
        }
    }
}

#Preview {
    BookmarkListScreen()
}
