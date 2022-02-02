//
//  SchoolSATScore.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/2/22.
//

import Foundation

struct SchoolSATScore: Decodable {
    let numberOfTestTakers: String
    let mathAvgScore: String
    let criticalReadingAvgScore: String
    let writingAvgScore: String
    
    enum CodingKeys: String, CodingKey {
        case numberOfTestTakers = "numOfSatTestTakers"
        case mathAvgScore = "satMathAvgScore"
        case criticalReadingAvgScore = "satCriticalReadingAvgScore"
        case writingAvgScore = "satWritingAvgScore"
    }
}
