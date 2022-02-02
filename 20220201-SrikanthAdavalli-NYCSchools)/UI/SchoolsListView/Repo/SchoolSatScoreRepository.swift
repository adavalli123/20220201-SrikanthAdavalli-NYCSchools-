//
//  SchoolSatScoreRepository.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/2/22.
//

import Foundation

struct SchoolSatScoreRepository: Repository {
    typealias RepositoryType = [SchoolSATScore]
    
    func fetch(_ endpoint: EndPoint, completion: @escaping (Result<[SchoolSATScore], Error>) -> Void) {
        URLSession.fetch(endpoint, completion: completion)
    }
}
