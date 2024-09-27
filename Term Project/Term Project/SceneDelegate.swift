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

//    func navigateToSearchPage() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Enter storyboard name
//        
//        if let searchVC = storyboard.instantiateViewController(withIdentifier: "Search") as? SearchPage {
//            if let navigationController = window?.rootViewController as? UINavigationController {
//                navigationController.pushViewController(searchVC, animated: true)
//            } else {
//                window?.rootViewController?.present(searchVC, animated: true, completion: nil)
//            }
//        } else {
//            print("Error: Could not instantiate SearchPage from Main storyboard")
//        }
//    }
//
//    func navigateToFavoritesPage() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Enter storyboard name
//        
//        if let favoritesVC = storyboard.instantiateViewController(withIdentifier: "Favorite") as? FavoritePage {
//            if let navigationController = window?.rootViewController as? UINavigationController {
//                navigationController.pushViewController(favoritesVC, animated: true)
//            } else {
//                window?.rootViewController?.present(favoritesVC, animated: true, completion: nil)
//            }
//        } else {
//            print("Error: Could not instantiate FavoritePage from Main storyboard")
//        }
//    }
//    
//    func navigateToBookingPage() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Enter storyboard name
//        
//        if let bookingVC = storyboard.instantiateViewController(withIdentifier: "Booking") as? BookingPage {
//            if let navigationController = window?.rootViewController as? UINavigationController {
//                navigationController.pushViewController(bookingVC, animated: true)
//            } else {
//                window?.rootViewController?.present(bookingVC, animated: true, completion: nil)
//            }
//        } else {
//            print("Error: Could not instantiate BookingPage from Main storyboard")
//        }
//    }
    
    func navigateToSearchPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let searchVC = storyboard.instantiateViewController(withIdentifier: "Search") as? SearchPage else {
            print("Error: Could not instantiate SearchPage from Main storyboard")
            return
        }
        
        // Correctly access the key window for iOS 13 and above
        if let rootVC = getRootViewController() {
            if let navigationController = rootVC as? UINavigationController {
                navigationController.pushViewController(searchVC, animated: true)
            } else {
                // Present the SearchPage if no navigation controller is found
                rootVC.present(searchVC, animated: true, completion: nil)
            }
        }
    }

    func navigateToFavoritesPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let favoritesVC = storyboard.instantiateViewController(withIdentifier: "Favorite") as? FavoritePage else {
            print("Error: Could not instantiate FavoritePage from Main storyboard")
            return
        }
        
        if let rootVC = getRootViewController() {
            if let navigationController = rootVC as? UINavigationController {
                navigationController.pushViewController(favoritesVC, animated: true)
            } else {
                rootVC.present(favoritesVC, animated: true, completion: nil)
            }
        }
    }

    func navigateToBookingPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let bookingVC = storyboard.instantiateViewController(withIdentifier: "Booking") as? BookingPage else {
            print("Error: Could not instantiate BookingPage from Main storyboard")
            return
        }
        
        if let rootVC = getRootViewController() {
            if let navigationController = rootVC as? UINavigationController {
                navigationController.pushViewController(bookingVC, animated: true)
            } else {
                rootVC.present(bookingVC, animated: true, completion: nil)
            }
        }
    }

    // Helper function to get the root view controller safely
    func getRootViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }?.rootViewController
        } else {
            return UIApplication.shared.keyWindow?.rootViewController
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Check if any quick action needs to be handled when the app becomes active
        if SearchHome {
            navigateToSearchPage()
            SearchHome = false // Reset after handling
        } else if FavoriteHome {
            navigateToFavoritesPage()
            FavoriteHome = false
        } else if BookingHome {
            navigateToBookingPage()
            BookingHome = false
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        setupQuickActions()
    }
    
}


