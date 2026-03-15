//
//  HistoryRow.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2026/03/09.
//

import SwiftUI

struct HistoryRow: View {
    
    let history: History
    let isBookmarked: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(history.title)
                    .font(.headline)
                Text(DateFormatter.stringFromDate(date: history.update_at, type: .None))
                    .font(.subheadline)
            }
            if isBookmarked {
                Image(systemName: "bookmark.fill")
            }
        }
    }
}
