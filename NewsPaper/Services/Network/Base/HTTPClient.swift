//
//  HTTPClient.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 6.05.23.
//

import Foundation

class HTTPClient {
    
    func request<T: Codable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.baseUrl
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.parameters
        
        guard let url = urlComponents.url else {
            throw RequestError.urlNotCreated
        }
        // Печатаем ссылку запроса
        //print("Делаем запрос по", url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        do {
            let session = URLSession(configuration: .default)
            let (data, response) = try await session.data(for: urlRequest)
            // Печатаем содержимое джейсона в консоль
            //print(data.prettyJSON as Any)
            
            if let response = response as? HTTPURLResponse {
                
                switch response.statusCode {
                case 200..<300: break
                case 400..<500:
                    throw RequestError.clientError
                case 500..<600:
                    throw RequestError.serverError
                default:
                    throw RequestError.unknownStatusCode
                }
            }

            let responseJson = try JSONDecoder().decode(T.self, from: data)
            let responseObject = responseJson
            return responseObject
        } catch {
            print("Ошибка декодирования =", error.localizedDescription)
            throw error
        }
    }
}
