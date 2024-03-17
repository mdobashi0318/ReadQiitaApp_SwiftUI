//
//  WebView.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/17.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let loardUrl: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: loardUrl)
        webView.load(request)
    }
}
