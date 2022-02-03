//
//  School.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation

public struct School: Decodable, Equatable {
    public let name: String
    public let dbn: String
    public let overview: String
    public let location: String
    public let phoneNumber: String
    public let website: String
    
    enum CodingKeys: String, CodingKey {
        case name = "schoolName"
        case dbn
        case overview = "overviewParagraph"
        case location
        case phoneNumber
        case website
    }
}
