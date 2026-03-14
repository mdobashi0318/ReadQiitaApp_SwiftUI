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
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var confirmDelete = false
    
    init() {
        _historyList = Query(sort: [SortDescriptor(\History.update_at, order: .reverse)])
    }
    
    var body: some View {
        NavigationStack {
            list
                .navigationTitle(R.string.label.history())
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            confirmDelete.toggle()
                        }, label: {
                            Image(systemName: "trash")
                        })
                    }
                }
                .alert("全件削除しますか?", isPresented: $confirmDelete) {
                    Button(role: .destructive, action: {
                        allDelete()
                    }, label: {
                        Text(R.string.button.delete())
                    })
                    
                    Button(role: .cancel, action: {
                        confirmDelete = false
                    }, label: {
                        Text(R.string.button.cancel())
                    })
                }
                .navigationDestination(for: History.self, destination: { history in
                    ArticleScreen(id: history.id, url: history.url, title: history.title)
                })
        }
    }
    
    @ViewBuilder
    private var list: some View {
        if historyList.isEmpty {
            Text(R.string.label.noHistory())
        } else {
            List {
                ForEach(historyList) { history in
                    NavigationLink(value: history , label: {
                        HistoryRow(history: history)
                    })
                }
                .onDelete(perform: delete)
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for offset in offsets {
            do {
                let history = historyList[offset]
                modelContext.delete(history)
                try modelContext.save()
            } catch {
                confirmDelete = true
            }
        }
    }
    
    private func allDelete() {
        do {
            try modelContext.delete(model: History.self)
        } catch {
            print("Historyの全削除失敗")
        }
    }
}
