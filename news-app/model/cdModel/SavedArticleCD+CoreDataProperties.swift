//
//  SavedArticleCD+CoreDataProperties.swift
//  news-app
//
//  Created by five on 07/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedArticleCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedArticleCD> {
        return NSFetchRequest<SavedArticleCD>(entityName: "SavedArticleCD")
    }

    @NSManaged public var articleRelationship: ArticleCD?

}
