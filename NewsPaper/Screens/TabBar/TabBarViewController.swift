//
//  TabBarViewController.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 7.05.23.
////
//

import UIKit

class TabBarViewController: UITabBarController {
    
    enum Tabs: Int {
        case browse
        case categories
        case bookmarks
        case profile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        let categoriesView = CategoriesViewFabric.get(isOnboarding: false)
        viewControllers = [
            generateVC(viewController: BrowseViewController(), title: "Browse", image: UIImage(systemName: "house")?.withTintColor(.gray), selectedImage: UIImage(systemName: "house.fill")?.withTintColor(UIColor(named: "purplePrimary")!), tag: Tabs.browse.rawValue),
            generateVC(viewController: CategoriesViewController(categoriesView), title: "Categories", image: UIImage(systemName: "square.grid.2x2")?.withTintColor(.gray), selectedImage: UIImage(systemName: "square.grid.2x2.fill")?.withTintColor(UIColor(named: "purplePrimary")!), tag: Tabs.categories.rawValue),
            generateVC(viewController: BookmarksViewController(), title: "Bookmarks", image: UIImage(systemName: "bookmark")?.withTintColor(.gray), selectedImage: UIImage(systemName: "bookmark.fill")?.withTintColor(UIColor(named: "purplePrimary")!), tag: Tabs.bookmarks.rawValue),
            generateVC(viewController: ProfileViewController(), title: "Profile", image: UIImage(systemName: "person")?.withTintColor(.gray), selectedImage: UIImage(systemName: "person.fill")?.withTintColor(UIColor(named: "purplePrimary")!), tag: Tabs.profile.rawValue)
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?, tag: Int) -> UIViewController {
        viewController.tabBarItem.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        viewController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        viewController.tabBarItem.tag = tag
        viewController.tabBarItem.title = title
        return UINavigationController(rootViewController: viewController)
       // return viewController
    }
    
    private func setTabBarAppearance() {
        selectedIndex = 0
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(named: "purplePrimary")
    }
}
