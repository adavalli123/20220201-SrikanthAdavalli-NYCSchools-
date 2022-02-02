//
//  School.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation

struct School: Decodable {
    let name: String
    let dbn: String
    let overview: String
    let location: String
    let phoneNumber: String
    let website: String
    
    enum CodingKeys: String, CodingKey {
        case name = "schoolName"
        case dbn
        case overview = "overviewParagraph"
        case location
        case phoneNumber
        case website
    }
}
