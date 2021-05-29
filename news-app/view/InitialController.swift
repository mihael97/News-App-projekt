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
    
//    let weatherView = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .purple
        
        weatherView.backgroundColor = .orange
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.set(conditions: .stormy, degrees: 12, location: "Zagreb", chanceOfRain: 55)
        view.addSubview(weatherView)

        
        NSLayoutConstraint.activate([
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.23)
        ])
        

    }
}
