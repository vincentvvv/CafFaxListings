//
//  CarFaxResponse.swift
//  CarFax
//
//  Created by Vincent Vuong on 9/30/20.
//  Copyright © 2020 Vincent Vuong. All rights reserved.
//

import Foundation

struct CardFaxResponse: Codable {
    let listings: [Listing]?
}

struct Listing: Codable {
    let images: [Image]?
    let listPrice: Int?
    let year: Int?
    let make: String?
    let model: String?
    let trim: String?
    let mileage: Int?
    let dealer: Dealer?
}

struct Image: Codable {
    let firstPhoto: [Photo]?
}

struct Photo: Codable {
    let large: String?
    let medium: String?
    let small: String?
}

struct Dealer: Codable {
    let city: String?
    let phone: String?
    let state: String?
}
