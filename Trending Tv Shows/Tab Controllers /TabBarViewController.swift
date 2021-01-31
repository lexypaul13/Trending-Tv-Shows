//
//  TabBarViewController.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/6/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemBlue
        viewControllers                 = [createShowcontroller(), createFavoritecontroller()]
    }
    
    func createShowcontroller()->UINavigationController{
        let todayController = WeeklyViewController()
        todayController.title = "This Week"
        todayController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        return UINavigationController(rootViewController: todayController)
    }
    
    func createFavoritecontroller()->UINavigationController{
        let favoriteController = FavoriteViewController()
        favoriteController.title = "Favorites"
        favoriteController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        return UINavigationController(rootViewController: favoriteController)
    }
    

}
