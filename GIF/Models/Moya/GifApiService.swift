//
//  GifApiService.swift
//  GIF
//
//  Created by admin on 06.07.2021.
//

import Moya

enum GifApiService {
    case search(name: String)
}

extension GifApiService: TargetType {
    var baseURL: URL {
        return URL(string: Network.API.baseURL)!
    }
    
    var path: String {
        switch self {
        
        case .search:
            return "/search"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let name):
            return .requestParameters(parameters: ["api_key" : Network.ApiKeys.gifKey,
                                                   "q" : name],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
