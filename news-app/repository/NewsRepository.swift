//
//  NewsRepository.swift
//  news-app
//
//  Created by five on 05/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import Foundation

class NewsRepository {
    private let networkDatasource: NetworkDatasource = NetworkDatasource()
    
    public func getLatest(searchText: String?, category: NewsCategory?, complete: @escaping([Article])->Void) {
        networkDatasource.fetchTopHeadline(searchText: searchText, category: category, completation: {
            result in
            switch result {
                case .success(let data):
                    complete(data.articles)
                case .failure(_):
                    complete([])
            }
        })
    }
    
    public func getPublishedHistory(complete: @escaping([Article])->Void) {
        complete([])
    }
    
    public func publishToHistory(article: Article) {
        
    }
    
    public func getSavedArticles(complete: @escaping([Article])->Void) {
        complete([])
    }
    
    public func saveArticle(article: Article) {
        
    }
}
