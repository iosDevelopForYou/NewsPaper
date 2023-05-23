//
//  SceneDelegate.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 6.05.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
    //   let navigationController = UINavigationController(rootViewController: BookmarksViewController())
        let userDefaults = UserDefaults.standard
        print(userDefaults.bool(forKey: "isFirstLaunch"))
        var controller = UIViewController()
        if userDefaults.bool(forKey: "isFirstLaunch") == false {
            controller = UINavigationController(rootViewController: OnboardingViewController())
        } else {
            controller = TabBarViewController()
        }
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}
