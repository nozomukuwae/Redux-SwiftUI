//
//  LogMiddleware.swift
//  HelloRedux
//
//  Created by Nozomu Kuwae on 2022/02/12.
//

import Foundation

func logMiddleWare() -> Middleware<AppState> {
    return { state, action, dispatch in
        print("Log middleware")
    }
}
