//
//  NewsEndpoint.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 6.05.23.
//

import Foundation

// Забираем значение ключа из info.pls Там его меняйте на свой
let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String

// Все доступные категории апи. На главном экране добавляем Random для рандомных новостей
let allCategory = ["business", "entertainment", "general", "health", "science", "sports", "technology"]

enum NewsEndpoint: Endpoint {
    
    case getTopHeadlines
    case searchByWord(searchWord: String)
    case searchByCategory(searchCategory: String)
    case searchByCategories(searchCategories: [String])
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseUrl: String {
        switch self {
        default:
            return "newsapi.org"
        }
    }
    
    var path: String {
        switch self {
        case .getTopHeadlines, .searchByCategory(searchCategory: _), .searchByCategories(searchCategories: _):
            return "/v2/top-headlines"
        case .searchByWord(_):
            return "/v2/everything"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getTopHeadlines:
            return  [URLQueryItem(name: "country", value: "us"),
                     URLQueryItem(name: "apiKey", value: apiKey)]
            
        case .searchByWord(searchWord: let searchWord):
            return  [URLQueryItem(name: "q", value: searchWord),
                     URLQueryItem(name: "apiKey", value: apiKey)]
            
        case .searchByCategory(searchCategory: let searchCategory):
            return  [URLQueryItem(name: "country", value: "us"),
                     URLQueryItem(name: "category", value: searchCategory),
                     URLQueryItem(name: "apiKey", value: apiKey)]
            
        case .searchByCategories(searchCategories: let searchCategories):
            var queryItems = [URLQueryItem]()
            queryItems.append(URLQueryItem(name: "country", value: "us"))
            queryItems.append(contentsOf: searchCategories.map { URLQueryItem(name: "category", value: $0) })
            queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
            return queryItems
        }
    }
    
    var method: String {
        switch self {
        case .getTopHeadlines, .searchByCategory(searchCategory: _), .searchByWord(searchWord: _), .searchByCategories(searchCategories: _):
            return "GET"
        }
    }
}
