//
//  ArticleScreen.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import SwiftUI

struct ArticleScreen: View {
    
    let article: Article
    
    var body: some View {
        WebView(loardUrl: URL(string: article.url)!)
            .navigationTitle("記事")
    }
    
}

//#Preview {
//    ArticleScreen()
//}
