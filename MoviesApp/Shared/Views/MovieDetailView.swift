//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Nozomu Kuwae on 2022/02/20.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var store: Store<AppState>
    let movie: Movie

    struct Properties {
        let movieDetail: MovieDetail?
        let onLoadMovieDetail: (String) -> Void
    }

    private func map(state: MoviesState) -> Properties {
        Properties(movieDetail: state.selectedMovieDetail) { imdbId in
            store.dispatch(action: FetchMovieDetailAction(imdbId: imdbId))
        }
    }

    var body: some View {
        let properties = map(state: store.state.movies)

        Group {
            if let detail = properties.movieDetail {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        URLImage(url: detail.poster)
                        Spacer()
                    }
                    Text(detail.title).padding(5).font(.title)
                    Text(detail.plot).padding(5)
                    HStack {
                        Text("Rating")
                        RatingView(rating: .constant(detail.imdbRating.toInt()))
                    }.padding()
                    Spacer()
                }
            } else {
                Text("Loading ...")
            }
        }.onAppear {
            properties.onLoadMovieDetail(movie.imdbId)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: appReducer, state: AppState(), middlewares: [moviesMiddleware()])
        return MovieDetailView(movie: Movie(title: "Batman Begins", poster: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg", imdbId: "tt0372784"))
            .environmentObject(store)
    }
}
