//
//  BrowseViewController.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 7.05.23.
//

import UIKit
import SnapKit

class BrowseViewController: UIViewController, UISearchBarDelegate, FavoriteButtonDelegate {
    
    let allCategory = ["Random", "Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"]
    var articleForCategory: [Article] = []
    var articleForFavoriteCategories: [Article] = []
    // Любимые категории надо загрузить из юзердефаулт
   // var favoritCategories = ["sports", "technology"]
    var favoritCategories = LocalStorageService.shared.loadCategories()
    var favoriteArticles: [Article] = {
        let favorite = LocalStorageService.shared.loadArticles()
        var favToReturn = []
        if favorite == nil {
            favToReturn = []
        } else {
            favToReturn = favorite!
        }
       return favToReturn as! [Article]
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover things of this world"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.allowsSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCell")
        collectionView.allowsSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchBarView = UISearchBar()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let firstIndexPath = IndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: [])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            do {
                articleForCategory = try await NewsService.shared.topHeadlines().articles ?? []
                mainCollectionView.reloadData()
            } catch {
                print("Error =", error.localizedDescription)
            }
        }
        
        Task {
            do {
                print("Избранное ищет по ", favoritCategories)
                articleForFavoriteCategories = try await NewsService.shared.searchCategories(categories: favoritCategories ?? ["sports"]).articles ?? []
                mainTableView.reloadData()
            } catch {
                print("Error =", error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarView.delegate = self
        searchBarView.placeholder = "Search"
        searchBarView.backgroundImage = UIImage()
        searchBarView.showsCancelButton = true
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        setupView()
        setupConstraints()
        
        title = "Browse"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.paragraphStyle: {
                let style = NSMutableParagraphStyle()
                style.firstLineHeadIndent = 0.0
                return style
            }()
        ]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LocalStorageService.shared.saveArticles(favoriteArticles)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(mainLabel)
        view.addSubview(searchBarView)
        view.addSubview(categoryCollectionView)
        view.addSubview(mainCollectionView)
        view.addSubview(mainTableView)
    }
    
    private func setupConstraints() {
        
        mainLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(17)
            $0.top.equalToSuperview().offset(145)
        }
        
        searchBarView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
        
        mainCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(categoryCollectionView.snp.bottom)
            $0.height.equalTo(250)
        }
        
        mainTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(mainCollectionView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    func didTapFavoriteButton(at indexPath: IndexPath) {
        print("Нажали на кнопку избранное в коллекции и отработали код в контроллере")
        let selectedArticle = articleForCategory[indexPath.item]
        let isFavorite = favoriteArticles.contains(selectedArticle)
        if isFavorite {
            // Удаление статьи из массива избранного
            if let index = favoriteArticles.firstIndex(of: selectedArticle) {
                favoriteArticles.remove(at: index)
            }
        } else {
            // Добавление статьи в массив избранного
            favoriteArticles.append(selectedArticle)
        }
        mainCollectionView.reloadItems(at: [indexPath])
        print("Добавлено в избранное", favoriteArticles.count)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            print("Выполняется поиск: \(searchText)")
            searchBar.resignFirstResponder()
            Task {
                do {
                    articleForCategory = try await NewsService.shared.searchWord(word: searchText).articles ?? []
                    mainCollectionView.reloadData()
                } catch {
                    print("Error =", error.localizedDescription)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print("Нажали отмена в поиске")
    }
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let selectedCategory = allCategory[indexPath.item]
            print("Нажали на категорию =", selectedCategory)
            if selectedCategory == "Random" {
                Task {
                    do {
                        articleForCategory = try await NewsService.shared.topHeadlines().articles ?? []
                        mainCollectionView.reloadData()
                    } catch {
                        print("Error =", error.localizedDescription)
                    }
                }
            } else {
                Task {
                    do {
                        articleForCategory = try await NewsService.shared.searchCategory(category: selectedCategory.lowercased()).articles ?? []
                        mainCollectionView.reloadData()
                    } catch {
                        print("Error =", error.localizedDescription)
                    }
                }
            }
        } else {
            let selectedCategory = articleForCategory[indexPath.item]
            print("Нажали на главную ячейку =", selectedCategory)
            let article = articleForCategory[indexPath.item]
            let vc = DetailNewsViewController()
            vc.article = article
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return allCategory.count
        } else {
            return articleForCategory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
            let category = allCategory[indexPath.item]
            cell.configureCell(title: category)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCollectionViewCell
            cell.delegate = self
            cell.indexPath = indexPath
            
            var selectedArticle = articleForCategory[indexPath.item]
            let isFavorite = favoriteArticles.contains(selectedArticle)
            if isFavorite {
                selectedArticle.favorites = true
            } else {
                selectedArticle.favorites = false
            }
            cell.configureCell(article: selectedArticle)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            let text = allCategory[indexPath.row]
            let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width + 30.0
            return CGSize(width: cellWidth, height: 40)
        } else {
            return CGSize(width: 200, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == mainCollectionView && section == 0 {
            let leftInset: CGFloat = 10
            let rightInset: CGFloat = 10
            let itemCount = collectionView.numberOfItems(inSection: section)
            if itemCount > 0 {
                return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
            }
        }
        return UIEdgeInsets.zero
    }
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource, FavoriteButtonDelegate2 {

    func didTapFavoriteButton2(in cell: MainTableViewCell) {
        print("Нажали на кнопку избранное в таблице и отработали код в контроллере")
        
        guard let indexPath = mainTableView.indexPath(for: cell) else {
            return
        }
        
        let selectedArticle = articleForFavoriteCategories[indexPath.row]
        
        // Check if the article is already in the favorite list
        if favoriteArticles.contains(selectedArticle) {
            if let index = favoriteArticles.firstIndex(of: selectedArticle) {
                favoriteArticles.remove(at: index)
            }
        } else {
            favoriteArticles.append(selectedArticle)
        }
        
        // Reload the specific row in the table view
        mainTableView.reloadRows(at: [indexPath], with: .automatic)
        
        print("Добавлено в избранное", favoriteArticles.count)
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleForFavoriteCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell", for: indexPath) as! MainTableViewCell
        //let article = articleForFavoriteCategories[indexPath.item]
        
        cell.delegate = self
        
        var selectedArticle = articleForFavoriteCategories[indexPath.item]
        let isFavorite = favoriteArticles.contains(selectedArticle)
        if isFavorite {
            selectedArticle.favorites = true
        } else {
            selectedArticle.favorites = false
        }
        cell.configureCell(article: selectedArticle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articleForFavoriteCategories[indexPath.row]
        print("Нажали на ячейку таблицы =", selectedArticle)
        let article = articleForFavoriteCategories[indexPath.item]
        let vc = DetailNewsViewController()
        vc.article = article
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
