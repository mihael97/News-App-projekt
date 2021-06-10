//
//  Source.swift
//  news-app
//
//  Created by five on 05/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import Foundation

struct Source: Codable {
    let id: String?
    let name: String
        
    init(sourceCD: SourceCD) {
        self.id = sourceCD.idCD
        self.name = sourceCD.name!
    }
}
