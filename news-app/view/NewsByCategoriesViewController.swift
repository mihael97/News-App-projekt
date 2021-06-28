//
//  NewsByCategoriesViewController.swift
//  news-app
//
//  Created by Marin on 04.06.2021..
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import UIKit

@available(iOS 14.0, *)
class NewsByCategoriesViewController: UIViewController {
    var newsTableView: UITableView!
    private var viewModel: NewsViewModel!
    private var newsHandler = NewsTableHandler()
    private let downloader = ImageDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = NewsViewModel(controller: self)
        configure()
        viewModel.load()
    }
    
    private func configure() {
        view.backgroundColor = .systemGray6
        configureNavigation()
        configureTableView()
        newsTableView.dataSource = newsHandler
        newsTableView.delegate = newsHandler
    
        newsTableView.reloadData()
    }
    
    private func configureNavigation() {
        let categoryImage = UIImage(systemName: "list.dash")
        let categoryButton = UIBarButtonItem(title: nil, image: categoryImage, primaryAction: nil, menu: viewModel.categoryMenu)
        categoryButton.tintColor = .systemGray
        navigationItem.leftBarButtonItem = categoryButton
    }
    
    private func configureTableView() {
        newsTableView = UITableView(frame: .zero, style: .plain)
        newsTableView.register(NewsAppCell.self, forCellReuseIdentifier: NewsAppCell.identifier)
        newsTableView.separatorInset = .zero
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.cellLayoutMarginsFollowReadableWidth = true
        view.addSubviewForAutoLayout(newsTableView)
        
        addTableViewConstraints()
    }
    
    private func addTableViewConstraints() {
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func load(articles: [Article]) {
        newsHandler.loadArticles(articles)
    }
}
