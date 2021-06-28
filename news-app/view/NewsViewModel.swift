//
//  NewsViewModel.swift
//  news-app
//
//  Created by Marin on 06.06.2021..
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import UIKit

@available(iOS 14.0, *)
class NewsViewModel {
    private var controller: UIViewController
    private var categoryName: String = ""
    private let repository = NewsRepository()
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func load() {
        loadArticles()
    }
    
    private func loadArticles(category: String = "general") {
        repository.getLatest(searchText: nil, category: NewsCategory(rawValue: category)) {
            articles in
            let controller = self.controller as! NewsByCategoriesViewController
            controller.load(articles: articles)
            DispatchQueue.main.async {
                controller.newsTableView.reloadData()
//                controller.newsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
        self.controller.navigationItem.title = category.capitalized
    }
    
    private func selectCategory(_ category: String) {
        loadArticles(category: category)
    }
    
    var categoryMenu: UIMenu {
        let menuActions = NewsCategory.allCases.map({ (item) -> UIAction in
            let name = item.rawValue
            return UIAction(title: name.capitalized, image: UIImage(systemName: item.systemName)) {
                _ in
                self.selectCategory(name)
            }
        })
        return UIMenu(title: "Change category", children: menuActions)
    }
}

extension NewsCategory {
    var systemName: String {
        switch self {
        case .general:
            return "newspaper"
        case .business:
            return "briefcase"
        case .entertainment:
            return "gamecontroller"
        case .health:
            return "bolt.heart"
        case .science:
            return "atom"
        case .sports:
            return "figure.walk"
        case .technology:
            return "cpu"
        }
    }
}
