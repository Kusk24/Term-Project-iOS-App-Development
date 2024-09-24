//
//  CarModelView.swift
//  Term Project
//
//  Created by Win Yu Maung on 23/09/2024.
//

import Foundation
import Alamofire
import UIKit

class CarViewModel {
    var cars: [Car] = []

    static let shared = CarViewModel()
//    let url = "https://mocki.io/v1/38f2fe3a-2ecc-45ad-88fd-405ade9a68da"
//   let url = "https://mocki.io/v1/89331fe5-1826-4829-a5c7-7c4fadcc9b3d"
    let url = "https://mocki.io/v1/38f2fe3a-2ecc-45ad-88fd-405ade9a68da"
    
    func fetchCarsData(completion: @escaping (Result<[Car], Error>) -> Void) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    // Decode the data
                    let decoder = JSONDecoder()
                    let carList = try decoder.decode(CarsResponse.self, from: data)
                    
                    self.cars = carList.cars
                    // Return the car list via completion handler
                    completion(.success(carList.cars))
                } catch let decodingError {
                    // Handle decoding error
                    completion(.failure(decodingError))
                }
            case .failure(let error):
                // Handle networking error
                completion(.failure(error))
            }
        }
    }
    
    // Method to return the count of cars
    func getCarCount() -> Int {
        return self.cars.count
    }
    
    func getCarList() -> [Car] {
        return self.cars
    }
    
    // Method to get a specific car by index
    func getCar(at index: Int) -> Car? {
        guard index >= 0 && index < self.cars.count else { return nil }
        return self.cars[index]
    }
    
    // You can add more methods to manipulate car data as needed, e.g. filter by brand, etc.
    func getCarImage(id: Int) -> String? {
        if let car = self.cars.first(where: { $0.id == id }) {
                // Assuming you have a way to get the UIImage for the car
            let imageConvert = car.images[0]
            return imageConvert
        }
        return nil
    }
    
    func getCarBrand(id: Int) -> String? {
        if let car = self.cars.first(where: { $0.id == id }) {
            return car.brand
        }
        return nil
    }
    
    func getCarModel(id: Int) -> String? {
        if let car = self.cars.first(where: { $0.id == id }) {
            return car.model
        }
        return nil
    }
    
    func getCarYear(id: Int) -> String? {
        if let car = self.cars.first(where: { $0.id == id }) {
            return String(car.year)
        }
        return nil
    }
    
    func getCarPrice(id: Int) -> String? {
        if let car = self.cars.first(where: { $0.id == id }) {
            return String(car.price)
        }
        return nil
    }
    
    func getCarLocation(id: Int) -> String? {
        if let car = self.cars.first(where: { $0.id == id }) {
            return car.location
        }
        return nil
    }
    
    func getCarType(id: Int) -> String? {
        if let car = self.cars.first(where: { $0.id == id }) {
            return car.type
        }
        return nil
    }
    
    func getImageList(id: Int) -> [String]? {
        if let car = self.cars.first(where: { $0.id == id }) {
            return car.images
        }
        return nil
    }
}
