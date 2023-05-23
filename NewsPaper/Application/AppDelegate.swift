//
//  AppDelegate.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 6.05.23.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
//        // Получение ссылки на хранилище пользовательских настроек
//        let userDefaults = UserDefaults.standard
//
//        // Проверка флага первого включения
//        if userDefaults.bool(forKey: "isFirstLaunch") {
//            // Это первое включение программы
//            print("Первое включение программы")
//            
//            // Устанавливаем флаг первого включения в false
//            userDefaults.set(false, forKey: "isFirstLaunch")
//            LocalStorageService.shared.loggedOut(false)
//        } else {
//            // Не первое включение программы
//            print("Не первое включение программы")
//        }

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
