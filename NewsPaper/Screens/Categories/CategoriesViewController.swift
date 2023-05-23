
//  CategoriesViewController.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 7.05.23.


import UIKit

class CategoriesViewController: UIViewController {
    
    var categoriesView: CategoriesView!
    var categories = [CategoryModel(emoji: "💶", name: "business", isSelected: false), CategoryModel(emoji: "🎯", name: "entertainment", isSelected: false), CategoryModel(emoji: "📰", name: "general", isSelected: false), CategoryModel(emoji: "🏥", name: "health", isSelected: false), CategoryModel(emoji: "🧬", name: "science", isSelected: false), CategoryModel(emoji: "🏈", name: "sports", isSelected: false), CategoryModel(emoji: "💻", name: "technology", isSelected: false)]
    
    // MARK: - init
    
    init(_ categoriesView: CategoriesView) {
        super.init(nibName: nil, bundle: nil)
        self.categoriesView = categoriesView
        self.navigationItem.hidesBackButton = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        view = categoriesView
        let stack = CategoryStackView()
        setupButtons(for: stack)
        categoriesView.setUIElements(stack: stack)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveSelection()
    }
    
    func saveSelection() {
        if (CategoryButton.wasChanged) {
            let selectedCategories = Array(CategoryButton.selectedNames)
            LocalStorageService.shared.saveCategories(selectedCategories)
        }
    }
    
    // MARK: - setup
    
    func setupTitle() {
        title = categoriesView.headerText
        if (categoriesView.isOnboarding) {
            navigationController?.navigationBar.largeTitleTextAttributes =
            [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28)]
        } else {
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
                NSAttributedString.Key.paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.firstLineHeadIndent = 0.0
                    return style
                }()
            ]
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupButtons(for stack: CategoryStackView) {
        let selectedCaregories = LocalStorageService.shared.loadCategories()
        let notNil = selectedCaregories != nil
        for var category in categories {
            if(notNil){
                if(selectedCaregories!.contains(category.name)) {
                    category.isSelected = true && !categoriesView.isOnboarding
                }
            }
            let button = CategoryButton(category: category)
            stack.addSubview(categoryButton: button)
        }
    }
}
