//
//  CoredataSource.swift
//  news-app
//
//  Created by five on 05/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import Foundation
import CoreData

class CoreDataSource {
    private let coreDataStack: CoreDataStack = CoreDataStack()
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
        let request: NSFetchRequest<RecommendationCD> = RecommendationCD.fetchRequest()
        let managedContext = coreDataStack.persistentContainer.viewContext
        do {
            let predicate: NSPredicate = NSPredicate(format:"name == %@", category.rawValue)
            request.predicate = predicate
            let results = try managedContext.fetch(request)
            if results.count == 0 {
                let recommendation: RecommendationCD = RecommendationCD(context: managedContext)
                recommendation.name = category.rawValue
                recommendation.count = 1
            } else {
                results[0].count+=1
            }
            try managedContext.save()
        } catch(let error) {
            print(error)
        }
    }
    
    public func getRecommendations()-> [NewsCategory:Int] {
        let request: NSFetchRequest<RecommendationCD> = RecommendationCD.fetchRequest()
        let managedContext = coreDataStack.persistentContainer.viewContext
        do {
            let sorts = [NSSortDescriptor(key:"count", ascending:false)]
            request.sortDescriptors = sorts
            let results = try managedContext.fetch(request)
            var map: [NewsCategory:Int] = [:]
            for result in results {
                map[NewsCategory.init(rawValue: result.name!)!] = Int(result.count)
            }
            return map
        } catch(let error) {
            print(error)
        }
        return [:]
    }
}
