//
//  EndPointApiType.swift
//  weatherApp
//
//  Created by Jaydip Parmar on 25/09/23.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
}

protocol EndPointAPIType {
    var path: String { get }
    var baseURL: String { get }
    var url: String? { get }
    var methods: HttpMethod { get }
    var headers: [String: String]? { get }
}

enum EndPointItems {
    case weather
}

extension EndPointItems: EndPointAPIType {
    
    var headers: [String : String]? {
        return APIManager.commonHeaders
    }
    
    var path: String {
        return "2.5/weather"
    }
    var baseURL: String {
        return "https://api.openweathermap.org/data/"
    }
    var url: String? {
        return "\(baseURL)\(path)"
    }
    var methods: HttpMethod {
        switch self {
        case .weather:
            return .get
        }
    }
}
