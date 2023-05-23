//
//  FakeViewController.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 6.05.23.
//

import UIKit

// Фэйковый класс для проверки запросов. Ниже примеры того, как использовать запрос
class FakeViewController: UIViewController {
    
    var newsAll: News?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        Task {
            do {
                newsAll = try await NewsService.shared.topHeadlines()
                printArticle((newsAll?.articles)!)
            } catch {
                print("Error =", error.localizedDescription)
            }
        }
        
//        Task {
//            do {
//                newsAll = try await NewsService.shared.searchWord(word: "bitcoin")
//                printArticle((newsAll?.articles)!)
//            } catch {
//                print("Error =", error.localizedDescription)
//            }
//        }
        
//        Task {
//            do {
//                newsAll = try await NewsService.shared.searchCategory(category: "sports")
//                printArticle((newsAll?.articles)!)
//            } catch {
//                print("Error =", error.localizedDescription)
//            }
//        }
        
//        Task {
//            do {
//                newsAll = try await NewsService.shared.searchCategories(categories: ["sports", "technology"])
//                printArticle((newsAll?.articles)!)
//            } catch {
//                print("Error =", error.localizedDescription)
//            }
//        }
       
    }
    
    func printArticle(_ art: [Article]) {
        for i in art {
            print(i.title ?? "")
        }
    }
}
