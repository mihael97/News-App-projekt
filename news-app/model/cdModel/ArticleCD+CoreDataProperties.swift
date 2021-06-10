//
//  ArticleCD+CoreDataProperties.swift
//  news-app
//
//  Created by five on 07/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//
//

import Foundation
import CoreData


extension ArticleCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleCD> {
        return NSFetchRequest<ArticleCD>(entityName: "ArticleCD")
    }

    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptionCD: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?
    @NSManaged public var source: NSObject?
    @NSManaged public var sourceRelationship: SourceCD?

}
