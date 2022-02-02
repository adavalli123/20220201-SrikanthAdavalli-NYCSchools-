//
//  SchoolListRepository.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation

struct SchoolListRepository: Repository {
    typealias RepositoryType = [School]
    
    func fetch(_ endpoint: EndPoint, completion: @escaping (Result<[School], Error>) -> Void) {
        URLSession.fetch(endpoint, completion: completion)
    }
}
