//
//  EndPoint.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation

enum EndPoint: Hashable {
    case schools
    case sat(dbn: String)
}

extension EndPoint {
    public var base: String { "https://data.cityofnewyork.us/" }
    
    var path: URL? {
        let baseURL = URL(string: base)
        
        switch self {
        case .schools:
            return baseURL?.appendingPathComponent("resource/s3k6-pzi2.json")
        case .sat(let dbn):
            return baseURL?.appendingPathComponent("resource/f9bf-2cp4.json").appending([URLQueryItem(name: "dbn", value: dbn)])
        }
    }
}
