//
//  NewsRepository.swift
//  news-app
//
//  Created by five on 05/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import Foundation

class NewsRepository {
    private let networkDatasource: NetworkDataSource = NetworkDataSource()
    private let coredataDatasource: CoreDataSource =  CoreDataSource()
    
    public func getLatest(searchText: String?, category: NewsCategory?, complete: @escaping([Article])->Void) {
        networkDatasource.fetchTopHeadline(searchText: searchText, category: category, completation: {
            result in
            switch result {
                case .success(let data):
                    complete(data.articles)
                case .failure( _):
                    complete([])
            }
        })
    }
    
    public func getHistory()-> [Article] {
        return coredataDatasource.getHistoryArticles()
    }
    
    public func saveToHistory(article: Article) {
        coredataDatasource.addToHistory(article: article)
    }
    
    public func getSavedArticles()-> [Article] {
        return coredataDatasource.getSavedArticles()
    }
    
    public func saveArticle(article: Article) {
        coredataDatasource.saveArticle(article: article)
    }
    
    public func getByCategory()->[NewsCategory:[Article]] {
        var sorted: [NewsCategory:[Article]] = [:]
        let group: DispatchGroup = DispatchGroup()
        
        NewsCategory.allCases.forEach {
            let value:NewsCategory = $0
            group.enter()
            getLatest(searchText: nil, category: $0, complete: {
                result in
                    sorted[value] = result
                    group.leave()
            })
        }
        group.wait()
        return sorted
    }
}
