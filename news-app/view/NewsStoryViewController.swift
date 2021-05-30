//
//  NewsStoryViewController.swift
//  news-app
//
//  Created by Ante on 30.05.2021..
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import UIKit

class NewsStoryViewController: UIViewController {

    private var coverImageView: UIImageView!
    private var flipView: UIView!
    private var tracksLabel: UILabel!
    private var artistLabel: UILabel!
    private var albumNameLabel: UILabel!
    private var songNameLabel: UILabel!
//    private var song: Song!
//    private var album: Album!
    private var isLoadingMore = false
    private var tracks = [String]()
//    let cache = NetworkManager.shared.cache
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configure()
//        configureFlipView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tracks = []
//        loadAlbumInfo()
//        populateScreen()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if coverImageView.isHidden {
            tracksLabel.isHidden = true
            coverImageView.isHidden = false
        }
        coverImageView.image = nil
    }
    
//    func set(song: Song) {
//        self.song = song
//    }
//
//    private func populateScreen() {
//        self.songNameLabel.text = self.song.title
//        self.artistLabel.text = self.song.artist.name
//    }
//
//    private func loadAlbumInfo() {
//        showLoadingView()
//        isLoadingMore = true
//        NetworkManager.shared.getAlbumSongs(for: song.album.id) { [weak self] result in
//            guard let self = self else { return }
//            self.dismissLoadingView()
//
//            switch result {
//            case .success(let album):
//                self.album = album
//                for track in self.album.tracks.data {
//                    self.tracks.append(track.title)
//                }
//                DispatchQueue.main.async {
//                    self.albumNameLabel.text = self.album.title
//                    self.download(from: self.album.cover_big)
//                    self.tracksLabel.text = self.tracks.map {String($0)}.joined(separator: "\n")
//                }
//            case .failure(let error):
//                self.presentCustomAlertOnMainThread(title: K.loadingError, message: error.rawValue, buttonTitle: "OK")
//            }
//            self.isLoadingMore = false
//        }
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
        songNameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        songNameLabel.textColor = .systemPink
        songNameLabel.numberOfLines = 2
        
        artistLabel = UILabel()
        artistLabel.textAlignment = .center
        artistLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        artistLabel.textColor = .secondaryLabel
        artistLabel.numberOfLines = 2
        
        albumNameLabel = UILabel()
        albumNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        albumNameLabel.textAlignment = .center
        albumNameLabel.numberOfLines = 2
        
        tracksLabel = UILabel()
        tracksLabel.textColor = .systemGreen
        tracksLabel.font = UIFont.boldSystemFont(ofSize: 18)
        tracksLabel.numberOfLines = 18
        tracksLabel.isHidden = true
        tracksLabel.backgroundColor = .systemBackground
        
        coverImageView = UIImageView()
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.clipsToBounds = true
        coverImageView.layer.borderWidth = 2
        coverImageView.layer.borderColor = UIColor.label.cgColor
        coverImageView.isHidden = false
        
        view.addSubview(albumNameLabel)
        view.addSubview(songNameLabel)
        view.addSubview(artistLabel)
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        tracksLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
//    private func configureFlipView() {
//        flipView = UIView()
//        flipView.addSubview(coverImageView)
//        flipView.addSubview(tracksLabel)
//        view.addSubview(flipView)
//        flipView.translatesAutoresizingMaskIntoConstraints = false
//
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flipCard))
//        flipView.addGestureRecognizer(tapGestureRecognizer)
//    }
    
//    @objc func flipCard() {
//        coverImageView.isHidden = !coverImageView.isHidden
//        tracksLabel.isHidden = !tracksLabel.isHidden
//
//        UIView.transition(from: coverImageView.isHidden ? tracksLabel : coverImageView,
//                          to: !tracksLabel.isHidden ? tracksLabel : coverImageView,
//                          duration: K.spinTimeInterval,
//                          options: [.transitionFlipFromTop, .showHideTransitionViews])
//    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            flipView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            flipView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            flipView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            flipView.heightAnchor.constraint(equalTo: flipView.widthAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: flipView.safeAreaLayoutGuide.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: flipView.safeAreaLayoutGuide.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: flipView.safeAreaLayoutGuide.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalTo: flipView.widthAnchor),
            
            tracksLabel.topAnchor.constraint(equalTo: flipView.safeAreaLayoutGuide.topAnchor),
            tracksLabel.leadingAnchor.constraint(equalTo: flipView.safeAreaLayoutGuide.leadingAnchor),
            tracksLabel.trailingAnchor.constraint(equalTo: flipView.safeAreaLayoutGuide.trailingAnchor),
            tracksLabel.heightAnchor.constraint(equalTo: flipView.widthAnchor),
            
            songNameLabel.topAnchor.constraint(equalTo: flipView.bottomAnchor, constant: 16),
            songNameLabel.leadingAnchor.constraint(equalTo: flipView.leadingAnchor, constant: 5),
            songNameLabel.trailingAnchor.constraint(equalTo: flipView.trailingAnchor, constant: -5),
            songNameLabel.heightAnchor.constraint(equalToConstant: 70),
            
            artistLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 4),
            artistLabel.leadingAnchor.constraint(equalTo: songNameLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: songNameLabel.trailingAnchor),
            artistLabel.heightAnchor.constraint(equalToConstant: 34),
            
            albumNameLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 4),
            albumNameLabel.leadingAnchor.constraint(equalTo: songNameLabel.leadingAnchor),
            albumNameLabel.trailingAnchor.constraint(equalTo: songNameLabel.trailingAnchor),
            albumNameLabel.heightAnchor.constraint(equalToConstant: 58),
        ])
    }
}
