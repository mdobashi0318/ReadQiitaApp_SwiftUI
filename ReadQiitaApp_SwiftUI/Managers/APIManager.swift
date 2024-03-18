//
//  APIManager.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/15.
//

import Foundation
import Alamofire


struct APIError: Error {
    let message: String
}


struct APIManager {
    
    private static let baseUrl = "https://qiita.com/api/v2/"
    
    static func request<T: Codable>(request: String, param: Parameters? = nil) async throws -> T {
        guard let url = URL(string: baseUrl + request) else {
            throw APIError(message: R.string.message.errorMessage())
        }
        
        let dataTask = await AF.request(url, parameters: param)
            .validate()
            .serializingDecodable(T.self)
            .response
        
        guard let result = dataTask.value else {
            throw APIError(message: R.string.message.errorMessage())
        }
        
        return result
    }
    
}


