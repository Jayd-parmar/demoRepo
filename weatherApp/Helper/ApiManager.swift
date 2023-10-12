//
//  ApiManager.swift
//  weatherApp
//
//  Created by Jaydip Parmar on 25/09/23.
//


import Foundation

typealias Handler<T> = (Result<T, DataError>) -> Void

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

final class APIManager {
    static let shared = APIManager()
    //Singleton desing pattern
    static var searchCity: String? = nil
    private init() {}
    
    func request<T: Codable>(
        modelType: T.Type,    // Response
        type: EndPointAPIType,
        completion: @escaping Handler<T>
    ) {
        guard let strURL = type.url else {
            completion(.failure(.invalidURL))
            return
        }
            
        // For queryParams
        let queryItems = [URLQueryItem(name: "q", value: APIManager.searchCity), URLQueryItem(name: "appid", value: "3f12be7cfb02c3ddcdc448d07932bc07")]
        var urlComps = URLComponents(string: strURL)
        urlComps?.queryItems = queryItems
        
        var request = URLRequest(url: (urlComps?.url)!)
        request.httpMethod = type.methods.rawValue
        request.allHTTPHeaderFields = type.headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let weatherResponse = try JSONDecoder().decode(modelType, from: data)
                completion(.success(weatherResponse))
            } catch {
                print(error)
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
    
}
