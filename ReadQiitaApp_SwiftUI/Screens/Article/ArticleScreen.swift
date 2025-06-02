//
//  ArticleScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import SwiftUI
import SwiftData

struct ArticleScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var bookmarks: [Bookmark]
    
    private let id: String
    private let url: String
    private let title: String
    
    @State private var alertMessage = ""
    
    @State private var isShowAlert = false
    
    @State private var isAdd = false
    
    init(id: String, url: String, title: String) {
        _bookmarks = Query(filter: #Predicate { model in
            if id.isEmpty {
                true
            } else {
                model.id.localizedStandardContains(id)
            }
        })
        self.id = id
        self.url = url
        self.title = title
    }
    
    var body: some View {
        WebView(loadUrl: URL(string: url)!)
            .navigationTitle(R.string.label.article())
            .toolbar {
                toolbar
            }
            .alert(isPresented: $isShowAlert) {
                return Alert(title: Text(isAdd ? R.string.label.addBookmark() : R.string.label.deleteBookmark()), dismissButton: .default(Text(R.string.button.close())))
            }
    }
    
    
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing, content: {
            Button(action: {
                if let bookmark = bookmarks.first {
                    isAdd = false
                    modelContext.delete(bookmark)
                    isShowAlert.toggle()
                } else {
                    isAdd = true
                    let bookmark = Bookmark()
                    bookmark.id = id
                    bookmark.url = url
                    bookmark.title = title
                    modelContext.insert(bookmark)
                    isShowAlert.toggle()
                }
                
            }, label: {
                if let _ = bookmarks.first {
                    Image(systemName: "trash")
                } else {
                    Image(systemName: "plus")
                }
                
            })
        })
    }
    
}

//#Preview {
//    ArticleScreen()
//}
