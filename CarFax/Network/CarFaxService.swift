//
//  CarFaxService.swift
//  CarFax
//
//  Created by Vincent Vuong on 9/30/20.
//  Copyright © 2020 Vincent Vuong. All rights reserved.
//

import Foundation

class CarFaxService {
    private let router = Router<CardFaxEndPointType>()

    func getListings(onNext: (([Listing]) -> Void)?, onError: ((ApiError) -> Void)?) {
        router.request(.listings) { data, response, error in
            guard let jsonData = data else {
                onError?(ApiError.emptyData)
                return
            }
            do {
                onNext?(try JSONDecoder().decode(CardFaxResponse.self, from: jsonData).listings ?? [])
            } catch {
                onError?(ApiError.decode)
            }
        }
    }
}
