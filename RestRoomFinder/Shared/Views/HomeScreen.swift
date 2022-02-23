//
//  HomeScreen.swift
//  RestRoomFinder
//
//  Created by Mohammad Azam on 10/14/20.
//

import SwiftUI
import Combine

struct HomeScreen: View {
    @ObservedObject private var locationManager = LocationManager()
    @EnvironmentObject var store: Store<AppState>
    @State private var cancellables: AnyCancellable?

    struct Properties {
        let restrooms: [Restroom]
        let onFetchRestroomsByLatLng: (Double, Double) -> Void
    }

    private func map(state: RestroomState) -> Properties {
        return Properties(restrooms: state.restrooms) { lat, lng in
            store.dispatch(action: FetchRestroomsAction(lat: lat, lng: lng))
        }
    }

    var body: some View {
        let properties = map(state: store.state.restroom)

        VStack(alignment: .leading) {
            HStack {
                EmptyView()
            }.frame(maxWidth: .infinity, maxHeight: 44)

            Spacer()

            HStack {
                Text("Restrooms")
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .padding([.leading])
                Spacer()
                Button(action: {
//                    locationManager.updateLocation()
                }) {
                    Image(systemName: "arrow.clockwise.circle")
                        .font(.title)
                        .foregroundColor(Color.white)
                }.padding()
            }

            List(properties.restrooms, id: \.id) {
                RestroomCell(restroom: $0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.cancellables = locationManager.$location.sink { location in
                if let location = location {
                    properties.onFetchRestroomsByLatLng(
                        location.coordinate.latitude,
                        location.coordinate.longitude
                    )
                }
            }
        }
    }
}

struct RestroomCell: View {
    let restroom: Restroom
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(restroom.name ?? "No name available")
                    .font(.headline)
                Spacer()
                Text(String(format: "%.2f miles", restroom.distance))
            }.padding([.top], 10)

            Text(restroom.address)
                .font(.subheadline)
                .opacity(0.5)

            Button("Directions") {}
            .font(.caption)
            .foregroundColor(Color.white)
            .padding(6)
            .background(Color.green)
            .cornerRadius(6)

            Text(restroom.comment ?? "")
                .font(.footnote)

            HStack {
                Text(restroom.accessible ? "♿️" : "")
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: appReducer, state: AppState(), middlewares: [restroomMiddleware()])
        return HomeScreen().environmentObject(store)
    }
}
