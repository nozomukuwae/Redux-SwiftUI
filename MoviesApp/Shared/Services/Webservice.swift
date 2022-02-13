//
//  Webservice.swift
//  MoviesApp (iOS)
//
//  Created by Nozomu Kuwae on 2022/02/13.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodingError
    case noData
}

class Webservice {
    func getMovies(search: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        guard let url = URL(string: Constants.Urls.urlBySearch(search: search)) else {
            completion(.failure(.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }

            guard let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }

            completion(.success(movieResponse.movies))
        }.resume()
    }
}
