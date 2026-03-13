//
//  ArticleScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import SwiftUI
import SwiftData
import WebKit

struct ArticleScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var bookmarks: [Bookmark]
    @Query private var historys: [History]
    @State private var page = WebPage()
    @State private var alertMessage = ""
    @State private var isShowAlert = false
    @State private var isAdd = false
    @State private var pageCount = 0
    
    private let id: String
    private let url: String
    private let title: String
    
    
    init(id: String, url: String, title: String) {
        _bookmarks = Query(filter: #Predicate { model in
            if id.isEmpty {
                true
            } else {
                model.id.localizedStandardContains(id)
            }
        })
        
        _historys = Query(sort: [SortDescriptor(\History.update_at, order: .reverse)])
        self.id = id
        self.url = url
        self.title = title
    }
    
    var body: some View {
        ZStack {
            WebView(page)
            if page.estimatedProgress < 1 {
                ProgressView(value: page.estimatedProgress)
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .navigationTitle(R.string.label.article())
        .toolbar {
            toolbar
            leadingToolbar
        }
        .navigationBarBackButtonHidden()
        .alert(isPresented: $isShowAlert) {
            return Alert(title: Text(isAdd ? R.string.label.addBookmark() : R.string.label.deleteBookmark()), dismissButton: .default(Text(R.string.button.close())))
        }
        .onAppear {
            page.load(URL(string: url)!)
            let date = DateFormatter.dateFormatNow(type: .secnd)
            if let history = historys.first(where: { $0.id == id }) {
                history.update_at = date
            } else {
                let history = History()
                history.id = id
                history.url = url
                history.title = title
                history.created_at = date
                history.update_at = date
                modelContext.insert(history)
                
                if historys.count >= 30,
                   let last = historys.last {
                    modelContext.delete(last)
                }
            }
            
            
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
                    let date = DateFormatter.dateFormatNow(type: .secnd)
                    isAdd = true
                    let bookmark = Bookmark()
                    bookmark.id = id
                    bookmark.url = url
                    bookmark.title = title
                    bookmark.created_at = date
                    bookmark.update_at = date
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
    
    private var leadingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading, content: {
            BackForwardMenuView(
                list: page.backForwardList.backList.reversed(),
                label: .init(text: "Backward", systemImage: "chevron.backward")
            ) {
                page.load($0)
            } dissmiss: {
                dismiss()
            }
        })
    }
}


// https://developer.apple.com/documentation/webkit/webpage/backforwardlist-swift.struct
private struct BackForwardMenuView: View {
    struct LabelConfiguration {
        let text: String
        let systemImage: String
    }


    let list: [WebPage.BackForwardList.Item]
    let label: LabelConfiguration
    let navigateToItem: (WebPage.BackForwardList.Item) -> Void
    let dissmiss: () -> Void


    var body: some View {
        Menu {
            ForEach(list) { item in
                Button(item.title ?? item.url.absoluteString) {
                    navigateToItem(item)
                }
            }
        } label: {
            Label(label.text, systemImage: label.systemImage)
                .labelStyle(.iconOnly)
        } primaryAction: {
            if let first = list.first{
                navigateToItem(first)
            } else {
                dissmiss()
            }
        }
    }
}
