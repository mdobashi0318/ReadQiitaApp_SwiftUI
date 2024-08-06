//
//  ArticleScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import SwiftUI
import RealmSwift

struct ArticleScreen: View {
    
    @ObservedResults(Bookmark.self) private var bookmarks
    
    let id: String
    let url: String
    let title: String
    
    @State private var alertMessage = ""
    
    @State private var isShowAlert = false
    
    @State private var isAdd = false
    
    var body: some View {
        WebView(loardUrl: URL(string: url)!)
            .navigationTitle(R.string.label.article())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        if let model = bookmarks.where({ $0.id == self.id }).first {
                            isAdd = false
                            $bookmarks.remove(model)
                            isShowAlert.toggle()
                        } else {
                            isAdd = true
                            let model = Bookmark()
                            model.id = id
                            model.url = url
                            model.title = title
                            $bookmarks.append(model)
                            isShowAlert.toggle()
                        }
                        
                    }, label: {
                        if let _ = bookmarks.where({ $0.id == self.id }).first {
                            Image(systemName: "trash")
                        } else {
                            Image(systemName: "plus")
                        }
                        
                    })
                })
            }
            .alert(isPresented: $isShowAlert) {
                    return Alert(title: Text(isAdd ? R.string.label.addBookmark() : R.string.label.deleteBookmark()), dismissButton: .default(Text(R.string.button.close())))
                
            }
    }
    
}

//#Preview {
//    ArticleScreen()
//}
