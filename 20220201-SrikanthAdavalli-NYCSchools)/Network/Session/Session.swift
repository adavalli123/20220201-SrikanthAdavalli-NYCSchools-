//
//  Session.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation

protocol Session {
    static func fetch<T: Decodable>(_ endpoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void)
}

@available(macOS 11.0, *)
extension URLSession: Session {
    static func fetch<T>(_ endpoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        let request = URLRequest(endpoint: endpoint)
        Self.shared.dataTask(with: request) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    preconditionFailure("No error was received but we also don't have data...")
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedObject = try decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
