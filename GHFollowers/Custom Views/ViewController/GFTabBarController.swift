//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Brandon Rodriguez on 3/21/22.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesNC()]
        
    }
    
    func createSearchNC() -> UINavigationController {
        
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
        
    }
    
    func createFavoritesNC() -> UINavigationController {
        
        let favoritesListNC = FavoritesListVC()
        favoritesListNC.title = "Favorites"
        favoritesListNC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListNC)
        
    }

}
