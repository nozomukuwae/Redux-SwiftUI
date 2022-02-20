//
//  MoviesReducer.swift
//  MoviesApp
//
//  Created by Nozomu Kuwae on 2022/02/13.
//

import Foundation

func moviesReducer(_ state: MoviesState, _ action: Action) -> MoviesState {
    var state = state
    switch action {
    case let action as SetMoviesAction:
        state.movies = action.movies
    case let action as SetMovieDetailAction:
        state.selectedMovieDetail = action.detail
    default:
        break
    }
    return state
}
