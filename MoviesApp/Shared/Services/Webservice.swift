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

    func getMovieDetailBy(imdbId: String, completion: @escaping (Result<MovieDetail?, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.Urls.urlForMovieDetailsByImdbId(imdbId: imdbId)) else {
            completion(.failure(.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }

            let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data)
            completion(.success(movieDetail))
        }.resume()
    }
}
