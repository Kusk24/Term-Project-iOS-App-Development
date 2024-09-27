//
//  BookingModel.swift
//  Term Project
//
//  Created by Win Yu Maung on 26/09/2024.
//

import Foundation

struct Booking: Codable {
    let id: Int
    let date: String
    let car: Car
}
