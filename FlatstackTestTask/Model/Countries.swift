//
//  Countries.swift
//  FlatstackTestTask
//
//  Created by Павел Прокопьев on 12.06.2021.
//

import Foundation

struct Countries: Codable {
    var name: String
    var continent: String
    var capital: String
    var population: String
    var descriptionSmall: String?
    var description: String?
    var image: String?
    var images: String?
    var flag: String?
    var next: String?
}
