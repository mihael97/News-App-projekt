//
//  WeatherView.swift
//  news-app
//
//  Created by Ante on 29.05.2021..
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    enum weatherInfo {
        case sunny, rainy, cloudy, stormy, snowy, windy
    }

    private var weatherImage: UIImageView!
    private var locationLabel: UILabel!
    private var temperatureLabel: UILabel!
    private var chanceOfRainLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        weatherImage = UIImageView()
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.contentMode = .scaleAspectFill
        weatherImage.tintColor = .systemBlue
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.tintColor = .systemRed
        locationLabel.textAlignment = .center
        
        temperatureLabel = UILabel()
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.tintColor = .systemRed
        temperatureLabel.textAlignment = .center
        
        chanceOfRainLabel = UILabel()
        chanceOfRainLabel.translatesAutoresizingMaskIntoConstraints = false
        chanceOfRainLabel.tintColor = .systemRed
        chanceOfRainLabel.textAlignment = .center

        
        addSubview(weatherImage)
        addSubview(locationLabel)
        addSubview(temperatureLabel)
        addSubview(chanceOfRainLabel)
    }

    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: self.topAnchor),
            weatherImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            weatherImage.widthAnchor.constraint(equalToConstant: 80),
            weatherImage.heightAnchor.constraint(equalToConstant: 80),
            
            locationLabel.centerYAnchor.constraint(equalTo: weatherImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 12),
            locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            locationLabel.heightAnchor.constraint(equalToConstant: 22),
            
            temperatureLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            temperatureLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 22),
            
            chanceOfRainLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 20),
            chanceOfRainLabel.centerXAnchor.constraint(equalTo: weatherImage.centerXAnchor),
//            chanceOfRainLabel.leadingAnchor.constraint(equalTo: weatherImage.leadingAnchor),
//            chanceOfRainLabel.trailingAnchor.constraint(equalTo: weatherImage.trailingAnchor),
            chanceOfRainLabel.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    
    func set(conditions: weatherInfo, degrees: Int, location: String, chanceOfRain: Int) {
        switch conditions {
        case .sunny:
            weatherImage.image = UIImage(systemName: "sun.max")
        case .rainy:
            weatherImage.image = UIImage(systemName: "cloud.rain")
        case .cloudy:
            weatherImage.image = UIImage(systemName: "cloud")
        case .snowy:
            weatherImage.image = UIImage(systemName: "cloud.snow")
        case .stormy:
            weatherImage.image = UIImage(systemName: "cloud.bolt.rain")
        case .windy:
            weatherImage.image = UIImage(systemName: "wind")
        }

        temperatureLabel.text = String(degrees)
        locationLabel.text = location
        chanceOfRainLabel.text = "\(chanceOfRain) %"

    }

}
