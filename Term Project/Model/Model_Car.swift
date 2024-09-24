//
//  Model_Car.swift
//  Term Project
//
//  Created by Win Yu Maung on 03/09/2024.
//

import Foundation

struct Car: Codable {
    let id: Int
    let brand: String
    let model: String
    let year: Int
    let images: [String]
    let price: Int
    let location: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case brand = "Brand"
        case model = "Model"
        case year = "Year"
        case images = "Image"
        case price = "Price"
        case location = "Location"
        case type = "Type"
    }
}

struct CarsResponse: Codable {
    let cars: [Car]
    
    enum CodingKeys: String, CodingKey {
        case cars = "Cars"
    }
}

//class CarData {
//    static var cars: [Car] = []
//    
//    static func getCars() -> [Car] {
//        return cars
//    }
//    
//    static func loadCars(loadedCars: [Car]) {
//        cars = loadedCars
//    }
//}
