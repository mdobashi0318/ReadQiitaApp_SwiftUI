//
//  ArticleRow.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/15.
//

import SwiftUI

struct ArticleRow: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("@\(article.user.id)")
                Text(article.user.organization ?? "")
            }
            
            Text(DateFormatter.stringFromString(article.created_at, type: .date))
            Text(article.title)
                .font(.title2)
                .bold()
                
            
            HStack(alignment: .top) {
                Image(systemName: "tag.fill")
                    .rotation3DEffect(.degrees(270), axis: (x: 0, y: 0, z: 1))
                Text(Tags.names(article.tags))
            }
            HStack {
                Image(systemName: "heart")
                Text("\(article.likes_count)")
                
            }
        }
    }
    
}
