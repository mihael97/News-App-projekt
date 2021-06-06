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
    private let numberOfArticles: Int = 30
    
    public func getLatest(searchText: String?, category: NewsCategory?, pageSize: Int? = nil, complete: @escaping([Article])->Void) {
        if let category = category {
            coredataDatasource.incrementSearchByCategory(category: category)
        }
        
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
    
    public func getByCategory(complete: @escaping([NewsCategory:[Article]])->Void) {
        var sorted: [NewsCategory:[Article]] = [:]
        let group: DispatchGroup = DispatchGroup()
        
        NewsCategory.allCases.forEach {
            let value:NewsCategory = $0
            group.enter()
            getLatest(searchText: nil, category: value, complete: {
                result in
                    sorted[value] = result
                    group.leave()
            })
        }
        group.wait()
        complete(sorted)
    }
    
    public func getRecommendations()-> [Article] {
        let recommendations = coredataDatasource.getRecommendations()
        let sumOfItems: Int = recommendations.map {$0.value}.reduce(0, +)
        var articles: [Article] = []
        let group: DispatchGroup = DispatchGroup()
        
        recommendations.forEach {recommendation in
            group.enter()
            let numberOfItems: Double = Double(recommendation.value)/Double(sumOfItems)
            getLatest(searchText: nil, category: recommendation.key, pageSize: Int(numberOfItems.rounded(.up)), complete: {
                result in
                    articles.append(contentsOf: result)
                    group.leave()
            })
        }
        group.wait()
        
        return articles
    }
}
