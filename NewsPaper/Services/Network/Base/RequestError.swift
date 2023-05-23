//
//  RequestError.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 6.05.23.
//

import Foundation

enum RequestError: Error {
    
    case mappingError
    case noNetworkError
    case clientError
    case serverError
    case urlNotCreated
    case unknownStatusCode
    
    var description: String {
        switch self {
        case .mappingError:
            return "Ошибка парсинга модели"
        case .noNetworkError:
            return "Отсутсвует интернет"
        case .clientError:
            return "Клиентская ошибка"
        case .serverError:
            return "Серверная ошибка"
        case .urlNotCreated:
            return "Не удалось создать URL для запроса"
        case .unknownStatusCode:
            return "Ошибка с неизвестным статус кодом"
        }
    }
}
