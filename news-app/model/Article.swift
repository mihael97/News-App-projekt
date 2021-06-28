//
//  Article.swift
//  news-app
//
//  Created by five on 05/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import Foundation


struct Article:Codable {
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
    
    init(articleCD: ArticleCD) {
        self.source = Source(sourceCD: articleCD.source! as! SourceCD)
        self.author = articleCD.author!
        self.title = articleCD.title!
        self.description = articleCD.description
        self.url = articleCD.url!
        self.urlToImage = articleCD.urlToImage!
        self.publishedAt = articleCD.publishedAt!
        self.content = articleCD.content!
    }
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage="urlToImage"
        case publishedAt = "publishedAt"
        case content
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source = try values.decodeIfPresent(Source.self, forKey: .source)!
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        content = try values.decodeIfPresent(String.self, forKey: .content) ?? ""
    }
}
