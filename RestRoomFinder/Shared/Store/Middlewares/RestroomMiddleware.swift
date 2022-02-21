//
//  RestroomMiddleware.swift
//  RestRoomFinder
//
//  Created by Nozomu Kuwae on 2022/02/21.
//

import Foundation

func restroomMiddleware() -> Middleware<AppState> {
    return { state, action, dispatch in
        switch action {
        case let action as FetchRestroomsAction:
            WebService().getRestrooms(lat: action.lat, lng: action.lng) { result in
                switch result {
                case .success(let restrooms):
                    dispatch(SetRestroomsAction(restrooms: restrooms))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break
        }
    }
}
