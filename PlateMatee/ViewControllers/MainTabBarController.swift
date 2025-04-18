//
//  MainTabBarController.swift
//  PlateMatee
//
//  Created by Chernokoz on 18.04.2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        customizeAppearance()
    }
    
    private func setupViewControllers() {
        // 1. Создаем экземпляры ваших контроллеров
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let cartVC = CartViewController()
        let profileVC = ProfileViewController()
        
        // 2. Настраиваем иконки и заголовки
        homeVC.tabBarItem = createTabBarItem(title: "Главная", imageName: "house")
        searchVC.tabBarItem = createTabBarItem(title: "Поиск", imageName: "magnifyingglass")
        cartVC.tabBarItem = createTabBarItem(title: "Корзина", imageName: "cart")
        profileVC.tabBarItem = createTabBarItem(title: "Профиль", imageName: "person")
        
        // 3. Обертываем в NavigationController (рекомендуется)
        viewControllers = [
            embedInNavigation(homeVC),
            embedInNavigation(searchVC),
            embedInNavigation(cartVC),
            embedInNavigation(profileVC)
        ]
    }
    
    private func createTabBarItem(title: String, imageName: String) -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: UIImage(systemName: imageName),
            selectedImage: UIImage(systemName: "\(imageName).fill")
        )
    }
    
    private func embedInNavigation(_ vc: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        // Дополнительные настройки NavigationController при необходимости
        return navController
    }
    
    private func customizeAppearance() {
        // Настройки для iOS 15+
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.tintColor = .systemBlue // Цвет выбранной иконки
        tabBar.unselectedItemTintColor = .systemGray // Цвет невыбранных иконок
        
        // Дополнительно: скрыть заголовок NavigationBar при прокрутке
        if let viewControllers = viewControllers {
            for case let navController as UINavigationController in viewControllers {
                navController.navigationBar.prefersLargeTitles = true
            }
        }
    }
}
