//
//  NewsTableHandler.swift
//  news-app
//
//  Created by Marin on 04.06.2021..
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import UIKit

class NewsTableHandler: NSObject {
    private var articles: [Article] = []
    
    func loadArticles(_ articles: [Article]) {
        self.articles = articles
    }
}

extension NewsTableHandler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsAppCell.identifier) as! NewsAppCell
        let article = articles[indexPath.row]
        cell.loadArticle(article)
        return cell
    }
}

extension NewsTableHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = articles[indexPath.row]
        
        UIApplication.shared.open(URL(string: item.url)!)
    }
}
