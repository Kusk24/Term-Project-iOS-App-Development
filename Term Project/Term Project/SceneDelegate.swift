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
            let _ = handleQuickAction(shortcutItem: shortcutItem) 
        }
        
        print(#function)

    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handled = handleQuickAction(shortcutItem: shortcutItem)
        completionHandler(handled)
    }

    func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false

        if shortcutItem.type == "com.612054.Term-Project.search" {
            SearchHome = true
            navigateToSearchPage()
            handled = true
        } else if shortcutItem.type == "com.612054.Term-Project.favorites" {
            FavoriteHome = true
            navigateToFavoritesPage()
            handled = true
        } else if shortcutItem.type == "com.612054.Term-Project.booking" {
            BookingHome = true
            navigateToBookingPage()
            handled = true
        }else {
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
        
        let bookingAction = UIApplicationShortcutItem(type: "com.612054.Term-Project.booking",
                                                        localizedTitle: "Booking",
                                                        localizedSubtitle: "View your booking history",
                                                        icon: UIApplicationShortcutIcon(type: .bookmark),
                                                        userInfo: nil)
        
        UIApplication.shared.shortcutItems = [searchAction, favoritesAction, bookingAction]
    }
    
    func navigateToSearchPage() {
        if let tabBarController = getTabBarController() {
            tabBarController.selectedIndex = 1 // Assuming the Search Page is at index 1
        } else {
            print("Error: Could not find TabBarController")
        }
    }

    func navigateToFavoritesPage() {
        if let tabBarController = getTabBarController() {
            tabBarController.selectedIndex = 3 // Assuming the Favorites Page is at index 3
        } else {
            print("Error: Could not find TabBarController")
        }
    }

    func navigateToBookingPage() {
        if let tabBarController = getTabBarController() {
            tabBarController.selectedIndex = 2 // Assuming the Booking Page is at index 2
        } else {
            print("Error: Could not find TabBarController")
        }
    }

    func getTabBarController() -> UITabBarController? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let rootViewController = windowScene.windows.first?.rootViewController {
                return findTabBarController(from: rootViewController)
            }
        }
        return nil
    }

    func findTabBarController(from viewController: UIViewController) -> UITabBarController? {
        if let tabBarController = viewController as? UITabBarController {
            return tabBarController
        } else if let navigationController = viewController as? UINavigationController {
            return findTabBarController(from: navigationController.visibleViewController ?? navigationController)
        } else if let presentedViewController = viewController.presentedViewController {
            return findTabBarController(from: presentedViewController)
        }
        return nil
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Check if any quick action needs to be handled when the app becomes active
        if SearchHome && CurrentUserViewModel.shared.loadCurrentUser().isLoggedIn {
            navigateToSearchPage()
            SearchHome = false // Reset after handling
        } else if FavoriteHome && CurrentUserViewModel.shared.loadCurrentUser().isLoggedIn {
            navigateToFavoritesPage()
            FavoriteHome = false
        } else if BookingHome && CurrentUserViewModel.shared.loadCurrentUser().isLoggedIn{
            navigateToBookingPage()
            BookingHome = false
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        setupQuickActions()
    }
    
}


