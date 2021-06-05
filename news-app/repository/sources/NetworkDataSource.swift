//
//  NetworkDatasource.swift
//  news-app
//
//  Created by five on 05/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import Foundation

class NetworkDataSource {
    private let API_KEY: String = "554ca39e01544178924e8f5a5579fe03";
    private let BASE_URL: String = "newsapi.org"
    private let DATE_FORMATTER: DateFormatter
    
    init() {
        DATE_FORMATTER = DateFormatter()
        DATE_FORMATTER.dateFormat = "yyyy-MM-dd"
    }
    
    private func createComponent(path:String, params: [String:String?] = [String:String](), secure:Bool = true) -> URLComponents {
        var component = URLComponents()
        
        component.host = BASE_URL
        component.path = path
        if secure {
            component.scheme = "https"
        } else {
            component.scheme = "http"
        }
                
        let queryParams: [URLQueryItem] = params.map {URLQueryItem(name: $0.key, value: $0.value)}
        component.queryItems = queryParams
        
        return component
    }
    
    private func getParams(searchText: String?, category: NewsCategory?=nil)-> [String: String]{
        var params = [String:String]()
        if let searchText = searchText {
            params["q"] = searchText
        } else {
            params["q"] = "Tesla"
        }
        if let category = category {
            params["category"] = category.rawValue
        }
        params["from"] = DATE_FORMATTER.string(from: Date())
        params["apiKey"] = API_KEY
    
        return params
    }
    
    public func fetch(searchText: String?, completation: @escaping(Result<NewsResponse, RequestError>)->Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let component = createComponent(path: "/v2/everything", params: getParams(searchText: searchText))
        
        guard let url = component.url else {
            completation(.failure(.clientError))
            return
        }
                
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "GET"
        
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                completation(.failure(.clientError))
                return
            }
            guard let data = data else {
                completation(.failure(.noDataError))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completation(.failure(.serverError))
                return
            }
            
            if response.statusCode != 200 {
                completation(.failure(.serverError))
                return
            }
            
            guard let responseData: NewsResponse = try? JSONDecoder().decode(NewsResponse.self, from: data) else {
                completation(.failure(.decodingError))
                return
            }
            completation(.success(responseData))
        }.resume()
    }
    
    public func fetchTopHeadline(searchText: String?, category: NewsCategory?, completation: @escaping(Result<NewsResponse, RequestError>)->Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let component = createComponent(path: "/v2/top-headlines", params: getParams(searchText: searchText, category: category))
        
        guard let url = component.url else {
            completation(.failure(.clientError))
            return
        }
                
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "GET"
        
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                completation(.failure(.clientError))
                return
            }
            guard let data = data else {
                completation(.failure(.noDataError))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completation(.failure(.serverError))
                return
            }
            
            if response.statusCode != 200 {
                completation(.failure(.serverError))
                return
            }
            
            guard let responseData: NewsResponse = try? JSONDecoder().decode(NewsResponse.self, from: data) else {
                completation(.failure(.decodingError))
                return
            }
            completation(.success(responseData))
        }.resume()
    }
}
