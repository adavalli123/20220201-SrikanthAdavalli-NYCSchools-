//
//  Repository.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation

protocol Repository {
    associatedtype RepositoryType
    func fetch(_ endpoint: EndPoint, completion: @escaping (Result<RepositoryType, Error>) -> Void)
}
