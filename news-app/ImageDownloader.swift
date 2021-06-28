//
//  ImageDownloader.swift
//  news-app
//
//  Created by Marin on 03.06.2021..
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    
    private var imageCache = NSCache<AnyObject, UIImage>()
    private let debug = false
    
    func load(url: URL, size: CGSize? = nil, tag: Int, completionHandler: @escaping(UIImage?, Int) -> Void) {
        let urlString = url.absoluteString
        let key = ImageDownloader.key(urlString: urlString, size: size)
        
        if let cacheImage = imageCache.object(forKey: key) {
            completionHandler(cacheImage, tag)
            if debug {
                print("cache hit for \(key)")
            }
            return
        }
        
        loadUrl(url: url, key: key, size: size, tag: tag) {
            (image, tag) in
            DispatchQueue.main.async {
                completionHandler(image, tag)
            }
        }
    }
    
    static func key(urlString: String, size: CGSize?) -> AnyObject {
        var key = urlString
        
        if let size = size {
            key = key + "\(size.width)-\(size.height)"
        }
        
        return key as AnyObject
    }
    
    func loadUrl(url: URL, key: AnyObject, size: CGSize? = nil, tag: Int,
                 completionHandler: @escaping(UIImage?, Int) -> Void) {
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {
                completionHandler(nil, tag)
                return
            }
            guard var image = UIImage(data: data) else {
                completionHandler(nil, tag)
                return
            }
            
            if let size = size {
                let newSize = image.size.aspectRatioForWidth(size.width)
                if let resized = image.resized(size: newSize) {
                    image = resized
                }
            } else {
                let screenWidth: CGFloat = UIScreen.main.bounds.width
                let newSize = image.size.aspectRatioForWidth(screenWidth)
                if let resized = image.resized(size: newSize) {
                    image = resized
                }
            }
            
            self.imageCache.setObject(image, forKey: key)
            completionHandler(image, tag)
        }
    }
}

extension CGSize {
    func aspectRatioForWidth(_ width: CGFloat) -> CGSize {
        return CGSize(width: width, height: width * self.height / self.width)
    }
}

extension UIImage {
    func resized(size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = self
        
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
