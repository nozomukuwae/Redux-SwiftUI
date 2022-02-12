//
//  IncrementMiddleware.swift
//  HelloRedux
//
//  Created by Nozomu Kuwae on 2022/02/12.
//

import Foundation

func incrementMiddleware() -> Middleware<AppState> {
    return { state, action, dispatch in
        switch action {
        case _ as IncrementActionAsync:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                dispatch(IncrementAction())
            }
        default:
            break
        }
    }
}
