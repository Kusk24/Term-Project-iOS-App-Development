//
//  SceneDelegate.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
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
        // Called as the scene transitions from the foreground to the background.
        setupQuickActions()
    }
    
    // Method to handle quick actions when the app is already running
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "com.612054.search" {
            // Navigate to the search page
            completionHandler(true)
        } else if shortcutItem.type == "com.612054.favorites" {
            // Navigate to the favorites page
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }

    // Method to set up quick actions for the app
    func setupQuickActions() {
        let searchAction = UIApplicationShortcutItem(type: "com.yourapp.search", localizedTitle: "Search", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .search), userInfo: nil)
        
        let favoritesAction = UIApplicationShortcutItem(type: "com.yourapp.favorites", localizedTitle: "Favorites", localizedSubtitle: "View your favorite cars", icon: UIApplicationShortcutIcon(type: .favorite), userInfo: nil)
        
        UIApplication.shared.shortcutItems = [searchAction, favoritesAction]
    }

}

