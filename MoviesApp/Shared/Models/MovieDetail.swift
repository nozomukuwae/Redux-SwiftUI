//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by Nozomu Kuwae on 2022/02/20.
//

import Foundation

struct MovieDetail: Decodable {
    let title: String
    let plot: String
    let imdbRating: String
    let poster: String

    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case plot = "Plot"
        case imdbRating = "imdbRating"
        case poster = "Poster"
    }
}
