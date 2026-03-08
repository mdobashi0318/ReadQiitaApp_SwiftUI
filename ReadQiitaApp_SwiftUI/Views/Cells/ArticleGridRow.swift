//
//  ArticleGridRow.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2026/03/02.
//

import SwiftUI

struct ArticleGridRow: View {
    
    let article: Article
    
    private let cornerRadius: CGFloat = 6
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(lineWidth: 1)
            .frame(height: 180)
            .tint(.secondary)
            .background(Color.systemBackground)
            .cornerRadius(cornerRadius)
            .clipped()
            .shadow(color: .secondary.opacity(0.2), radius: cornerRadius)
            .overlay(content: {
                GridRow {
                    VStack(alignment: .leading) {
                        Text(article.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                        Text(article.user.name)
                            .lineLimit(1)
                        organizationView
                        Text(DateFormatter.stringFromString(article.created_at, type: .date))
                        tagView
                        likeCountView
                        Spacer()
                    }
                    .foregroundStyle(Color.textColor)
                    .padding(5)
                }
            })
    }
    
    @ViewBuilder
    private var organizationView: some View {
        if !(article.user.organization?.isEmpty ?? true) {
            HStack {
                Image(systemName: "person.3.fill")
                    .resizable()
                    .frame(width: 20, height: 18)
                Text(article.user.organization ?? "")
                    .lineLimit(1)
            }
        }
    }
    
    private var tagView: some View {
        HStack(alignment: .top) {
            Image(systemName: "tag.fill")
                .rotation3DEffect(.degrees(270), axis: (x: 0, y: 0, z: 1))
            Text(Tags.names(article.tags))
                .lineLimit(2)
        }
    }
    
    private var likeCountView: some View {
        HStack {
            Image(systemName: "heart")
            Text("\(article.likes_count)")
                .lineLimit(1)
        }
    }
    
}

#Preview(traits: .fixedLayout(width: 300, height: 220)) {
    ArticleGridRow(article: Article.mock2)
}
