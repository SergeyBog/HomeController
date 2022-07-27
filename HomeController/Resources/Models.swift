//
//  Models.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import Foundation

struct Response: Decodable {
    var devices: [Device]
    var user: User
}

struct Device: Decodable {
    var id: Int
    var deviceName: String
    var intensity: Int?
    var position: Int?
    var mode: String?
    var temperature: Float?
    var productType: String
}

struct User: Decodable {
    var firstName: String
    var lastName: String
    var address: Address
    var birthDate: Int
}

struct Address: Decodable {
    var city: String
    var postalCode: Int
    var street: String
    var streetCode: String
    var country: String
}

struct Light {
    var id: Int
    var deviceName: String
    var intensity: Int
    var mode: String
}

struct RollerShutter {
    var id: Int
    var deviceName: String
    var position: Int
    var mode: String
}

struct Heater {
    var id: Int
    var deviceName: String
    var mode: String
    var temperature: Float
}
