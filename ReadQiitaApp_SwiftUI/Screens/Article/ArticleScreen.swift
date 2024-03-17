//
//  ArticleScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import SwiftUI
import RealmSwift

struct ArticleScreen: View {
        
    @ObservedResults(Bookmark.self) var bookmarks
    
    let id: String
    let url: String
    let title: String
    
    var body: some View {
        WebView(loardUrl: URL(string: url)!)
            .navigationTitle("記事")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        if let model = bookmarks.where({ $0.id == self.id }).first {
                            $bookmarks.remove(model)
                        } else {
                            let model = Bookmark()
                            model.id = id
                            model.url = url
                            model.title = title
                            $bookmarks.append(model)
                        }
                        
                    }, label: {
                        if let model = bookmarks.where({ $0.id == self.id }).first {
                            Image(systemName: "trash")
                        } else {
                            Image(systemName: "plus")
                        }
                        
                    })
                })
            }
    }
    
}

//#Preview {
//    ArticleScreen()
//}
