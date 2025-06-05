//
//  HistoryListScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2025/06/02.
//

import SwiftUI
import SwiftData


struct HistoryListScreen: View {
    
    @Query private var historyList: [History]
    
    @Environment(\.dismiss) private var dismiss
    
    init() {
        _historyList = Query(sort: [SortDescriptor(\History.update_at, order: .reverse)])
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(historyList) { history in
                    NavigationLink(value: history , label: {
                        Text(history.title)
                    })
                }
            }
            .navigationTitle("history")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            }
            .navigationDestination(for: History.self, destination: { history in
                ArticleScreen(id: history.id, url: history.url, title: history.title)
            })
        }
        
    }
}
