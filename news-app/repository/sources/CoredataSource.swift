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
        let request: NSFetchRequest<ArticleCD> = ArticleCD.fetchRequest()
        let managedContect = coreDataStack.persistentContainer.viewContext
        
        do {
            return try managedContect.fetch(request).map {a in
                let article: Article = Article(articleCD: a)
                return article
            }
        } catch(let error) {
            print(error)
        }
        
        return []
    }
    
    private func getSource(source: Source)->SourceCD {
        let request: NSFetchRequest<SourceCD> = SourceCD.fetchRequest()
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        do {
            var predicate: NSPredicate
            if let id = source.id {
                predicate = NSPredicate(format: "id == %@ AND name == %@", id, source.name)
            } else {
                predicate = NSPredicate(format: "name == %@", source.name)
            }
            request.predicate = predicate
            let results = try managedContext.fetch(request)
            if results.count != 0 {
                return results[0]
            }
            let sourceCd: SourceCD = SourceCD(context: managedContext)
            sourceCd.idCD = source.id
            sourceCd.name = source.name
            
            return sourceCd
        } catch(let error) {
            print(error)
        }
        return SourceCD()
    }
    
    public func addToHistory(article: Article) {
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        do {
            let articleCD = ArticleCD(context: managedContext)
            articleCD.author = article.author
            articleCD.content = article.content
            articleCD.descriptionCD = article.description
            articleCD.publishedAt = article.publishedAt
            articleCD.sourceRelationship = getSource(source: article.source)
            articleCD.title = article.title
            try managedContext.save()
        } catch(let error) {
            print(error)
        }
    }
    
    public func getSavedArticles()-> [Article] {
        let request: NSFetchRequest<ArticleCD> = ArticleCD.fetchRequest()
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        do {
            let results = try managedContext.fetch(request)
            return results.map {a in
                let article: Article = Article(articleCD: a)
                return article
            }
        } catch(let error) {
            print(error)
        }
        
        return []
    }
    
    public func saveArticle(article: Article) {
        let request: NSFetchRequest<SavedArticleCD> = SavedArticleCD.fetchRequest()
        let managedContext = coreDataStack.persistentContainer.viewContext
        do {
            let predicate: NSPredicate = NSPredicate(format: "article.title == %@", article.title)
            request.predicate = predicate
            let results = try managedContext.fetch(request)
            if results.count == 0 {
                let savedArticle: SavedArticleCD = SavedArticleCD(context: managedContext)
                let historyRequest: NSFetchRequest<ArticleCD> = ArticleCD.fetchRequest()
                historyRequest.predicate = NSPredicate(format: "title == %@", article.title)
                let historyResults = try managedContext.fetch(historyRequest)
                
                if historyResults.count == 1 {
                    savedArticle.articleRelationship = historyResults[0]
                    try managedContext.save()
                }
            }
        } catch(let error) {
            print(error.localizedDescription)
        }
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
