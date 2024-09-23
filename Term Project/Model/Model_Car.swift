//
//  Model_Car.swift
//  Term Project
//
//  Created by Win Yu Maung on 03/09/2024.
//

//import Foundation
//
//struct CarsResponse: Codable {
//    let cars: [Car]
//
//    enum CodingKeys: String, CodingKey {
//        case cars = "Cars"
//    }
//}
//
//struct Car: Codable {
//    let brand: String
//    let model: String
//    let year: Int
//    let image: String
//    let video: String
//    let price: Int
//    let location: String
//
//    enum CodingKeys: String, CodingKey {
//        case brand = "Brand"
//        case model = "Model"
//        case year = "Year"
//        case image = "Image"
//        case video = "Video"
//        case price = "Price"
//        case location = "Location"
//    }
//}


import Foundation

// Model for the car data
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

// Wrapper for the car list (since your JSON starts with {"Cars": [...]})
struct CarsResponse: Codable {
    let cars: [Car]
    
    enum CodingKeys: String, CodingKey {
        case cars = "Cars"
    }
}
