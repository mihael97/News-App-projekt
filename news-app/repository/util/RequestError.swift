//
//  RequestError.swift
//  news-app
//
//  Created by five on 05/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noDataError
    case decodingError
}
