//
//  ApiError.swift
//  CarFax
//
//  Created by Vincent Vuong on 9/30/20.
//  Copyright © 2020 Vincent Vuong. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case network
    case emptyData
    case decode
    case invalidURL

    var message: String? {
        switch self {
        case .network: return "Network error"
        case .emptyData: return "Empty data error"
        case .decode: return "Decode error"
        case .invalidURL: return "Invalid URL error"
        }
    }
}
