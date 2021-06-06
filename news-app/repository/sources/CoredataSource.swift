//
//  CoredataSource.swift
//  news-app
//
//  Created by five on 05/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import Foundation

class CoreDataSource {
    public func getHistoryArticles()-> [Article] {
        return []
    }
    
    public func addToHistory(article: Article) {
        
    }
    
    public func getSavedArticles()-> [Article] {
        return []
    }
    
    public func saveArticle(article: Article) {
        
    }
    
    public func incrementSearchByCategory(category: NewsCategory) {
        
    }
    
    public func getRecommendations()-> [NewsCategory:Int] {
        return [:]
    }
}
