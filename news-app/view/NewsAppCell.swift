//
//  NewsAppCell.swift
//  news-app
//
//  Created by Marin on 03.06.2021..
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import UIKit

class NewsAppCell: UITableViewCell {
    static let identifier: String = "NewsCell"
    static let logoSize: CGSize = CGSize(width: 20, height: 20)
    
    private var articleImageView: UIImageView! = UIImageView()
    private var logo: UIImageView! = UIImageView()
    private var ago: UILabel! = UILabel()
    private var source: UILabel! = UILabel()
    private var summary: UILabel! = UILabel()
    private var title: UILabel! = UILabel()
    
    private let cornerRadius: CGFloat = 6
    private let sourceFontSize: CGFloat = 12
    private let fontSize: CGFloat = 15
    private let imageHeight: CGFloat = 120
    private let inset: CGFloat = 15
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        summary.numberOfLines = 0
        contentView.addSubviewForAutoLayout(title)
        
        articleImageView.backgroundColor = .secondarySystemBackground
        articleImageView.contentMode = .scaleToFill
        articleImageView.clipsToBounds = true
        articleImageView.layer.cornerRadius = cornerRadius
        articleImageView.layer.masksToBounds = true
        contentView.addSubviewForAutoLayout(articleImageView)
        
        source.font = .boldSystemFont(ofSize: sourceFontSize)
        contentView.addSubviewForAutoLayout(source)
        
        title.numberOfLines = 4
        
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        if let descriptor = systemFont.fontDescriptor.withDesign(.default) {
            title.font = UIFont(descriptor: descriptor, size: fontSize)
        }
        contentView.addSubviewForAutoLayout(title)
        
        ago.font = .boldSystemFont(ofSize: sourceFontSize)
        ago.textColor = .secondaryLabel
        
        contentView.addSubviewForAutoLayout(ago)
        contentView.addSubviewForAutoLayout(logo)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            articleImageView.widthAnchor.constraint(equalToConstant: imageHeight),
            
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: NewsAppCell.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: NewsAppCell.logoSize.height),
            
            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 4),
            source.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            
            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 2),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),
            
            ago.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: ago.bottomAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: inset)
        ])
    }
    
    func loadArticle(_ article: Article) {
        title.text = article.title
        source.text = article.source.name
        ago.text = article.ago
        
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        logo.load(urlString: article.urlToSourceLogo, downloader: ImageDownloader.shared)
    }
    
    private func load(urlString: String?, downloader: ImageDownloader = ImageDownloader.shared, size: CGSize? = nil, completionHandler: (() -> Void)? = nil) {
        articleImageView.load(urlString: urlString, size: size, downloader: downloader) {
            completionHandler?()
        }
        
        guard let string = urlString else {
//            print("error for image \(urlString ?? "")")
            return
        }
        guard URL(string: string) != nil else {
//            print("error url \(string)")
            return
        }
    }
    
    private func loadLogo(urlString: String?, size: CGSize, downloader: ImageDownloader = ImageDownloader.shared) {
        self.logo.load(urlString: urlString, downloader: downloader)
    }
}

extension UIImageView {
    func load(urlString:String?, size: CGSize? = nil, downloader: ImageDownloader,
              completionHandler: (() -> Void)? = nil) {
        guard let string = urlString else {
            completionHandler?()
            return
        }
        guard let url = URL(string: string) else {
            completionHandler?()
            return
        }
        let tag = Int.random(in: 1..<1000)
        self.tag = tag
        downloader.load(url: url, size: size, tag: tag) {
            (downloaded, downloadTag) in
            guard self.tag == downloadTag else { return }
            
            self.image = downloaded
            completionHandler?()
        }
    }
}

extension UIView {
    func addSubviewForAutoLayout(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension Article {
    var ago: String? {
        let rdf = RelativeDateTimeFormatter()
        
        guard let date = ISO8601DateFormatter().date(from: publishedAt) else {
            return nil
        }
        
        return rdf.localizedString(for: date, relativeTo: Date())
    }
    
    var urlToSourceLogo: String {
        let url = URL(string: url)
        guard let host = url?.host else {
            return ""
        }
        
        return "https://logo.clearbit.com/\(host)"
    }
}
