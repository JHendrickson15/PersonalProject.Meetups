//
//  Events.swift
//  PersonProject
//
//  Created by Jordan Hendrickson on 7/9/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import Foundation

struct TopLevelJSON: Decodable {
    let _embedded: EmbeddedDictionary
}

struct EmbeddedDictionary: Decodable {
    let events: [Events]
}

struct Events: Decodable {
    var name: String
    let dates: Dates
    let _embedded: SecondEmbeddedDictionary
}
struct Dates: Decodable {
    let start: Start
}
struct Start: Decodable {
    var localDate: String
}
struct SecondEmbeddedDictionary: Decodable{
    let venues: [Venues]
}
struct Venues: Decodable {
    let name: String
}
