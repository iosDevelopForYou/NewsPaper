import Foundation
final class LocalStorageService {
    
    private init() {}
    static let shared = LocalStorageService()
    
    // keys
    private let categoriesKey = "categories"
    
    // MARK: - login methods
    
    // password
    
    func savePassword(_ password: String, for email: String) {
        save(password, key: email)
    }
    
    func loadPassword(for email: String) -> String? {
        load(key: email)
    }
    
    // name
    
    func saveName(_ name: String, for email: String) {
        save(name, key: "\(email)_name")
    }
    
    func loadName(for email: String) -> String? {
        load(key: "\(email)_name")
    }
    
    // MARK: - categories methods
    
    func saveCategories(_ categories: [String]) {
        save(categories, key: categoriesKey)
    }
    
    func loadCategories() -> [String]? {
        load(key: categoriesKey)
    }
    
    func saveArticles(_ articles: [Article]) {
        save(articles, key: "articles")
    }
    
    func loadArticles() -> [Article]? {
        load(key: "articles")
    }
    
    func loggedIn() -> Bool? {
        load(key: "logged")
    }
    
    func loggedOut(_ logOut: Bool) {
        save(logOut, key: "logged")
    }
    // MARK: - private save / load methods
    
      private func save<T: Codable>(_ object: T, key: String) {
            do {
                let data = try JSONEncoder().encode(object)
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                print("\(T.Type.self) saving failed")
            }
        }
        
      private func load<T: Codable>(key: String) -> T? {
            guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                return object
            } catch {
                print("\(T.Type.self) loading failed")
                return nil
            }
        }
}

