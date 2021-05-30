//
//  NewsCustomCell.swift
//  news-app
//
//  Created by Ante on 30.05.2021..
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import UIKit

class NewsCustomCell: UITableViewCell {
    
    private var coverImageView: UIImageView!
    private var numberLabel: UILabel!
    private var artistLabel: UILabel!
    private var durationLabel: UILabel!
    private var songNameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.systemPink.cgColor
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    func setCell(song: Song) {
//        songNameLabel.text = song.title
//        artistLabel.text = song.artist.name
//        numberLabel.text = "#" + String(song.position)
//        durationLabel.text = String(secondsToMinutesSeconds(seconds: song.duration))
//        download(from: song.artist.picture)
//    }
//
//    private func download(from url: String) {
//        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                self.coverImageView.image = image
//            }
//        }
//    }
    
    private func configure() {
        songNameLabel = UILabel()
        songNameLabel.textAlignment = .center
        songNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        songNameLabel.textColor = .label
        songNameLabel.numberOfLines = 2
        
        artistLabel = UILabel()
        artistLabel.textAlignment = .center
        artistLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        artistLabel.textColor = .secondaryLabel
        
        numberLabel = UILabel()
        numberLabel.textColor = .systemGreen
        numberLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        durationLabel = UILabel()
        durationLabel.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        durationLabel.textAlignment = .right
        
        coverImageView = UIImageView()
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.clipsToBounds = true
        
        addSubview(songNameLabel)
        addSubview(coverImageView)
        addSubview(numberLabel)
        addSubview(durationLabel)
        addSubview(artistLabel)
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            coverImageView.widthAnchor.constraint(equalToConstant: bounds.width * 0.35),
            coverImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 7),
            coverImageView.bottomAnchor.constraint(equalTo: numberLabel.topAnchor),
            
            numberLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 7),
            numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 32),
            
            songNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            songNameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 5),
            songNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            
            artistLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor,constant: 5),
            artistLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            artistLabel.bottomAnchor.constraint(equalTo: durationLabel.topAnchor, constant: -5),
            
            durationLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 10),
            durationLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 2),
            durationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            durationLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -7)
        ])
    }
    
}
