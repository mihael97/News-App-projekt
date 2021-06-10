//
//  SourceCD+CoreDataProperties.swift
//  news-app
//
//  Created by five on 07/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//
//

import Foundation
import CoreData


extension SourceCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceCD> {
        return NSFetchRequest<SourceCD>(entityName: "SourceCD")
    }

    @NSManaged public var idCD: String?
    @NSManaged public var name: String?

}
