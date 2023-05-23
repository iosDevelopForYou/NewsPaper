//
//  NewsService.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 6.05.23.
//

import Foundation

final class NewsService {
    
    private init() {}
    static let shared = NewsService()
    
    // Запрос на рандомные топовые новости
    func topHeadlines() async throws -> News {
        do {
            let response = try await HTTPClient().request(endpoint: NewsEndpoint.getTopHeadlines, responseModel: News.self)
            return response
        } catch {
            print(error)
            throw error
        }
    }
    
    // Запрос для поиска по слову. Использовать в search баре
    func searchWord(word: String) async throws -> News {
        do {
            let response = try await HTTPClient().request(endpoint: NewsEndpoint.searchByWord(searchWord: word), responseModel: News.self)
            return response
        } catch {
            print(error)
            throw error
        }
    }
    
    // Запрос по одной категории. Использовать в карусели при выборе категории
    func searchCategory(category: String) async throws -> News {
        do {
            let response = try await HTTPClient().request(endpoint: NewsEndpoint.searchByCategory(searchCategory: category), responseModel: News.self)
            return response
        } catch {
            print(error)
            throw error
        }
    }
    
    // Запрос по массиву категорий. Использовать на главном экране в рекомендациях пользователя
    func searchCategories(categories: [String]) async throws -> News {
        do {
            let response = try await HTTPClient().request(endpoint: NewsEndpoint.searchByCategories(searchCategories: categories), responseModel: News.self)
            return response
        } catch {
            print(error)
            throw error
        }
    }
}
