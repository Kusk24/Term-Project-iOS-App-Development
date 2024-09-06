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

        // Set up quick actions when the app launches
        setupQuickActions()

        // Handle the quick action if the app was launched by one
        if let shortcutItem = connectionOptions.shortcutItem {
            handleQuickAction(shortcutItem: shortcutItem)
        }
    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handled = handleQuickAction(shortcutItem: shortcutItem)
        completionHandler(handled)
    }

    func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false

        if shortcutItem.type == "com.612054.Term-Project.search" {
            navigateToSearchPage()
            handled = true
        } else if shortcutItem.type == "com.612054.Term-Project.favorites" {
            navigateToFavoritesPage()
            handled = true
        } else {
            print("Unhandled quick action type: \(shortcutItem.type)")
        }
        
        return handled
    }

    func setupQuickActions() {
        let searchAction = UIApplicationShortcutItem(type: "com.612054.Term-Project.search",
                                                     localizedTitle: "Search",
                                                     localizedSubtitle: nil,
                                                     icon: UIApplicationShortcutIcon(type: .search),
                                                     userInfo: nil)
        
        let favoritesAction = UIApplicationShortcutItem(type: "com.612054.Term-Project.favorites",
                                                        localizedTitle: "Favorites",
                                                        localizedSubtitle: "View your favorite cars",
                                                        icon: UIApplicationShortcutIcon(type: .favorite),
                                                        userInfo: nil)
        
        UIApplication.shared.shortcutItems = [searchAction, favoritesAction]
    }

    func navigateToSearchPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Enter storyboard name
        
        if let searchVC = storyboard.instantiateViewController(withIdentifier: "Search") as? SearchPage {
            if let navigationController = window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(searchVC, animated: true)
            } else {
                window?.rootViewController?.present(searchVC, animated: true, completion: nil)
            }
        } else {
            print("Error: Could not instantiate SearchPage from Main storyboard")
        }
    }

    func navigateToFavoritesPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Enter storyboard name
        
        if let favoritesVC = storyboard.instantiateViewController(withIdentifier: "Favorite") as? FavoritePage {
            if let navigationController = window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(favoritesVC, animated: true)
            } else {
                window?.rootViewController?.present(favoritesVC, animated: true, completion: nil)
            }
        } else {
            print("Error: Could not instantiate FavoritePage from Main storyboard")
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        setupQuickActions()
    }
}


