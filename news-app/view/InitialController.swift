//
//  InitialController.swift
//  news-app
//
//  Created by five on 20/05/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import UIKit

class InitialController: UIViewController {
    
    let weatherView = WeatherView()
    let feedTableView = UITableView()
    let newsStoryViewController = NewsStoryViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .purple
        
        weatherView.backgroundColor = .orange
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.set(conditions: .stormy, degrees: 12, location: "Zagreb", chanceOfRain: 55)
        view.addSubview(weatherView)
        
        feedTableView.backgroundColor = .blue
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(feedTableView)
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.register(NewsCustomCell.self, forCellReuseIdentifier: "cell")

        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.185),
            
            feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            feedTableView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 10),
            feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            feedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    
    
}

extension InitialController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 //news.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        newsStoryViewController.set(song: songs[indexPath.row])
        self.show(newsStoryViewController, sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SongsCustomCell
//        cell.setCell(song: news[indexPath.row])
//        return cell
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

