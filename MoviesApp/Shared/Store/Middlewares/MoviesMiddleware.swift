//
//  MoviesMiddleware.swift
//  MoviesApp
//
//  Created by Nozomu Kuwae on 2022/02/13.
//

import Foundation

func moviesMiddleware() -> Middleware<AppState> {
    return { state, action, dispatch in
        switch action {
        case let action as FetchMoviesAction:
            Webservice().getMovies(search: action.search.urlEncode()) { result in
                switch result {
                case .success(let movies):
                    dispatch(SetMoviesAction(movies: movies))
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        default:
            break
        }
    }
}
