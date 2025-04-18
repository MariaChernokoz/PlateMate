//
//  SceneDelegate.swift
//  PlateMatee
//
//  Created by Chernokoz on 18.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Создаем и настраиваем TabBarController
        let tabBarController = MainTabBarController()
        print("TabBarController created with:", tabBarController.viewControllers?.count ?? 0, "tabs")
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemRed // Временная проверка
        
        // Проверка иерархии через 1 секунду
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let rootVC = self.window?.rootViewController {
                print("Root controller:", type(of: rootVC))
                
                if let topVC = self.findTopViewController(root: rootVC) {
                    print("Top controller:", type(of: topVC))
                }
            }
        }
    }

    // Вспомогательная функция для поиска верхнего контроллера
    private func findTopViewController(root: UIViewController) -> UIViewController? {
        if let presented = root.presentedViewController {
            return findTopViewController(root: presented)
        }
        
        if let tab = root as? UITabBarController,
           let selected = tab.selectedViewController {
            return findTopViewController(root: selected)
        }
        
        return root
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save Core Data changes
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

