//
//  WebService.swift
//  RestRoomFinder
//
//  Created by Nozomu Kuwae on 2022/02/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodingError
    case noData
}

class WebService {
    func getRestrooms(lat: Double, lng: Double, completion: @escaping (Result<[Restroom], NetworkError>) -> Void) {
        guard let url = URL(string: Constants.Urls.restroomsByLatAndLng(lat: lat, lng: lng)) else {
            completion(.failure(.badURL))
            return
        }
        print(url)

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }

            guard let restrooms = try? JSONDecoder().decode([Restroom].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }

            completion(.success(restrooms))
        }.resume()
    }
    
}
