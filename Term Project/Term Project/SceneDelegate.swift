//
//  SceneDelegate.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit
var FavoriteHome : Bool = false
var BookingHome: Bool = false
var SearchHome: Bool = false

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
    
    func navigateToBookingPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Enter storyboard name
        
        if let bookingVC = storyboard.instantiateViewController(withIdentifier: "Booking") as? BookingPage {
            if let navigationController = window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(bookingVC, animated: true)
            } else {
                window?.rootViewController?.present(bookingVC, animated: true, completion: nil)
            }
        } else {
            print("Error: Could not instantiate BookingPage from Main storyboard")
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        setupQuickActions()
    }
    
}


