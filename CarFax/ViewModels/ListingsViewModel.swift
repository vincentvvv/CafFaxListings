//
//  CarsViewModel.swift
//  CarFax
//
//  Created by Vincent Vuong on 9/30/20.
//  Copyright © 2020 Vincent Vuong. All rights reserved.
//

import Foundation
import Snail

class ListingsViewModel {
    enum State {
        case loading
        case loaded
        case error(error: ApiError)
    }

    public var state = Observable<State>()
    private let carFaxService: CarFaxService

    var listings: [Listing] = []

    init(carFaxService: CarFaxService) {
        self.carFaxService = carFaxService
    }

    func getListing(at index: Int) -> Listing? {
        guard (0...listings.count).contains(index) else {
            return nil
        }
        return listings[index]
    }

    func fetchListings() {
        state.on(.next(.loading))

        carFaxService.getListings(onNext: { [weak self] listings in
            print("Got listings")
            self?.listings = listings
            self?.state.on(.next(.loaded))
        }, onError: { [weak self] error in
            self?.state.on(.next(.error(error: error)))
        })
    }
}
