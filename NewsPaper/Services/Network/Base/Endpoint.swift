//
//  Endpoint.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 6.05.23.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}
