//
//  BookmarksViewController.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 7.05.23.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    //var articleForFavoriteCategories: [Article] = []
    //var favoritCategories = ["sports", "technology"]
    
    var favoriteArticles: [Article] = {
        let favorite = LocalStorageService.shared.loadArticles()
        var favToReturn = []
        if favorite == nil {
            favToReturn = []
        } else {
            favToReturn = favorite!
        }
        print("Сохранили вот столько статей =", favToReturn.count)
       return favToReturn as! [Article]
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Saved articles to the library"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func addviewLayout() {
        view.addSubview(descriptionLabel)
        view.addSubview(mainTableView)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mainTableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        Task {
//            do {
//                articleForFavoriteCategories = try await NewsService.shared.searchCategories(categories: favoritCategories).articles ?? []
//                mainTableView.reloadData()
//            } catch {
//                print("Error =", error.localizedDescription)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        view.backgroundColor = .white
        
        addviewLayout()
        
        self.title = "Bookmarks"
        // Create large title font
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.paragraphStyle: {
                let style = NSMutableParagraphStyle()
                style.firstLineHeadIndent = 0.0
                return style
            }()
        ]
        navigationController?.navigationBar.prefersLargeTitles = true
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LocalStorageService.shared.saveArticles(favoriteArticles)
    }
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource, FavoriteButtonDelegate2 {
    
    func didTapFavoriteButton2(in cell: MainTableViewCell) {
        print("Нажали на кнопку избранное в избранном контроллере и отработали код в контроллере")
        
        guard let indexPath = mainTableView.indexPath(for: cell) else {
            return
        }
        
        let selectedArticle = favoriteArticles[indexPath.row]
        
        // Check if the article is already in the favorite list
        if favoriteArticles.contains(selectedArticle) {
            if let index = favoriteArticles.firstIndex(of: selectedArticle) {
                favoriteArticles.remove(at: index)
            }
        } else {
            favoriteArticles.append(selectedArticle)
        }
        
        // Reload the specific row in the table view
     //   mainTableView.reloadRows(at: [indexPath], with: .automatic)
        mainTableView.reloadData()
        
        print("Добавлено в избранное", favoriteArticles.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell", for: indexPath) as! MainTableViewCell
        cell.delegate = self
        
        var selectedArticle = favoriteArticles[indexPath.item]
        let isFavorite = favoriteArticles.contains(selectedArticle)
        if isFavorite {
            selectedArticle.favorites = true
        } else {
            selectedArticle.favorites = false
        }
        cell.configureCell(article: selectedArticle)
//        let article = articleForFavoriteCategories[indexPath.item]
//        cell.configureCell(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = favoriteArticles[indexPath.row]
        print("Нажали на ячейку таблицы =", selectedArticle)
        let article = favoriteArticles[indexPath.item]
        let vc = DetailNewsViewController()
        vc.article = article
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
