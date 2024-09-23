//
//  AppDelegate.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit
import Alamofire
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Request notification permissions
        
        // Set the delegate for UNUserNotificationCenter
        UNUserNotificationCenter.current().delegate = self
        
        CarViewModel.shared.fetchCarsData{ result in
            switch result {
            case .success(let mycars):
                cars = mycars
            case .failure(let error):
                print("Error fetching cars: \(error)")
            }
        }
        
        // Alamofire request as a "static block"
//        let url = "https://mocki.io/v1/a5ea996a-042f-418f-8cdb-0bac9954417f"
//        //let url = "https://mocki.io/v1/efb6b91b-ae74-4a1a-b2d7-ade81f9d3b8f"
//        AF.request(url).responseDecodable(of: CarsResponse.self) { data in
//            switch data.result {
//            case .success(let carResponse):
//                cars = carResponse.cars
//                print("Cars loaded:", cars)
//            case .failure(let error):
//                print("Failed to load cars:", error)
//            }
//        }
        
//        CarViewModel.shared.fetchCars { result in
//            switch result {
//            case .success(let mycars):
//                // Successfully fetched the cars, handle the data
//                cars = mycars
//                print("Fetched \(cars.count) cars.")
//            case .failure(let error):
//                // Handle error
//                print("Error fetching cars: \(error.localizedDescription)")
//            }
//        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - UNUserNotificationCenterDelegate Methods

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound]) // Show alert, badge, and play sound
    }
}


