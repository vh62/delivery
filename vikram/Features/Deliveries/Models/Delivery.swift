//
//  Delivery.swift
//  vikram
//
//  Created by Vikram on 15/11/24.
//

import Foundation
import SwiftData

//struct Delivery: Decodable, Identifiable {
//    let id: String
//    let remarks: String
//    let pickupTime: String
//    let goodsPicture: String
//    let deliveryFee: String
//    let surcharge: String
//    let route: Route
//    let sender: Sender
//}

//struct MockDeliveryData {
//    static let sampleDeliveries = [
//        Delivery(
//            id: "5dd5f3a7156bae72fa5a5d6c",
//            remarks: "Minim veniam minim nisi ullamco consequat anim reprehenderit laboris aliquip voluptate sit.",
//            pickupTime: "2014-10-06T10:45:38-08:00",
//            goodsPicture: "https://loremflickr.com/320/240/cat?lock=9953",
//            deliveryFee: "$92.14",
//            surcharge: "$136.46",
//            route: Route(
//                start: "Noble Street",
//                end: "Montauk Court"
//            ),
//            sender: Sender(
//                name: "Harding Welch",
//                phone: "+1 (899) 523-3905",
//                email: "hardingwelch@comdom.com"
//            )
//        ),
//        Delivery(
//            id: "5dd5f3a787c49789dca0b43f",
//            remarks: "Minim deserunt nisi qui veniam est amet pariatur voluptate ea est exercitation cupidatat sit ea.",
//            pickupTime: "2018-11-22T07:06:05-08:00",
//            goodsPicture: "https://loremflickr.com/320/240/cat?lock=28542",
//            deliveryFee: "$104.23",
//            surcharge: "$288.13",
//            route: Route(
//                start: "Henry Street",
//                end: "Clinton Street"
//            ),
//            sender: Sender(
//                name: "Kendra Guthrie",
//                phone: "+1 (942) 512-3379",
//                email: "kendraguthrie@comdom.com"
//            )
//        )
//    ]
//}

@Model
class Delivery: Decodable {
    @Attribute(.unique)
    var id: String
    var remarks: String
    var pickupTime: String
    var goodsPicture: String
    var deliveryFee: String
    var surcharge: String
    var route: Route
    var sender: Sender
    
    enum CodingKeys: String, CodingKey {
        case id
        case remarks
        case pickupTime
        case goodsPicture
        case deliveryFee
        case surcharge
        case route
        case sender
    }
    
    init() {
        self.id = UUID().uuidString
        self.remarks = ""
        self.pickupTime = ""
        self.goodsPicture = ""
        self.deliveryFee = ""
        self.surcharge = ""
        self.route = Route()
        self.sender = Sender()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        remarks = try container.decode(String.self, forKey: .remarks)
        pickupTime = try container.decode(String.self, forKey: .pickupTime)
        goodsPicture = try container.decode(String.self, forKey: .goodsPicture)
        deliveryFee = try container.decode(String.self, forKey: .deliveryFee)
        surcharge = try container.decode(String.self, forKey: .surcharge)
        route = try container.decode(Route.self, forKey: .route)
        sender = try container.decode(Sender.self, forKey: .sender)
    }
    
    init(id: String, remarks: String, pickupTime: String, goodsPicture: String, deliveryFee: String, surcharge: String, route: Route, sender: Sender) {
        self.id = id
        self.remarks = remarks
        self.pickupTime = pickupTime
        self.goodsPicture = goodsPicture
        self.deliveryFee = deliveryFee
        self.surcharge = surcharge
        self.route = route
        self.sender = sender
    }
}

@Model
class Route: Decodable {
    var start: String
    var end: String
    
    enum CodingKeys: String, CodingKey {
        case start
        case end
    }
    
    init() {
        self.start = ""
        self.end = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.start = try container.decode(String.self, forKey: .start)
        self.end = try container.decode(String.self, forKey: .end)
    }
    
    init(start: String, end: String) {
        self.start = start
        self.end = end
    }
}

@Model
class Sender: Decodable {
    var name: String
    var phone: String
    var email: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case phone
        case email
    }
    
    init() {
        self.name = ""
        self.phone = ""
        self.email = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.email = try container.decode(String.self, forKey: .email)
    }
    
    init(name: String, phone: String, email: String) {
        self.name = name
        self.phone = phone
        self.email = email
    }
}

@Model
class Favorite {
    @Attribute(.unique)
    var id = UUID().uuidString
    @Relationship var delivery: Delivery?
    
    init() {
        self.delivery = nil
    }
    
    init(delivery: Delivery) {
        self.delivery = delivery
    }
}
