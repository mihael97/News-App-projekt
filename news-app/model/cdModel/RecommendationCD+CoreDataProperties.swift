//
//  RecommendationCD+CoreDataProperties.swift
//  news-app
//
//  Created by five on 07/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//
//

import Foundation
import CoreData


extension RecommendationCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecommendationCD> {
        return NSFetchRequest<RecommendationCD>(entityName: "RecommendationCD")
    }

    @NSManaged public var count: Int32
    @NSManaged public var name: String?

}
