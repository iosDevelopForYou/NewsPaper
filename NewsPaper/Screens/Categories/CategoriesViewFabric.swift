//
//  CategoryPageService.swift
//  NewsPaper
//
//  Created by Sofya Olekhnovich on 11.05.2023.
//

 struct CategoriesViewFabric {
     static func get(isOnboarding: Bool) -> CategoriesView {
         return isOnboarding ?
         CategoriesView(isOnboarding: isOnboarding, header: "Select your favorite topics", info: "Select some of your favorite topics to let us suggest better news for you.") :
         CategoriesView(isOnboarding: isOnboarding, header: "Categories", info: "Thousands of articles in each category")
     }
}
