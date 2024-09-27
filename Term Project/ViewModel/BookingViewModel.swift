//
//  BookingViewModel.swift
//  Term Project
//
//  Created by Win Yu Maung on 26/09/2024.
//

import Foundation
import UIKit

class BookingViewModel {

    static let shared = BookingViewModel()

    // Save bookings for a specific user
    func saveBookings(bookings: [Booking], username: String) {
        let key = "bookings_\(username)"  // Create a unique key based on the username
        if let encodedData = try? JSONEncoder().encode(bookings) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }

    // Retrieve bookings for a specific user
    func getBookings(username: String) -> [Booking] {
        let key = "bookings_\(username)"  // Retrieve using the unique key
        if let data = UserDefaults.standard.data(forKey: key),
           let bookings = try? JSONDecoder().decode([Booking].self, from: data) {
            return bookings
        }
        return []
    }
    
    func isBooked(id: Int, username: String) -> Bool {
        return getBookings(username: username).contains(where: { $0.car.id == id })
    }

    // Add a booking for a specific user
    func addBooking(carID: Int, username: String, bookingDate: String) {
        var bookings = getBookings(username: username)
        let myCar: Car = CarViewModel.shared.getCarList().first(where: { $0.id == carID })!
        
        let newBooking = Booking(id: bookings.count + 1, date: bookingDate, car: myCar)

        bookings.append(newBooking)
        saveBookings(bookings: bookings, username: username)
        print("\(myCar.brand) booked on \(bookingDate) for \(username).")
    }

    // Remove a booking for a specific user
    func removeBooking(bookingID: Int, username: String) {
        var bookings = getBookings(username: username)

        if let index = bookings.firstIndex(where: { $0.id == bookingID }) {
            bookings.remove(at: index)
            saveBookings(bookings: bookings, username: username)
            print("Booking \(bookingID) removed from \(username)'s bookings.")
        } else {
            print("Cannot find booking \(bookingID) to remove.")
        }
    }

    // Check the booking status for a specific user
    func hasBooking(for carID: Int, username: String) -> Bool {
        let bookings = getBookings(username: username)
        return bookings.contains(where: { $0.car.id == carID })
    }
}
