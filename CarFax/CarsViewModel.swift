//
//  CarsViewModel.swift
//  CarFax
//
//  Created by Vincent Vuong on 9/30/20.
//  Copyright © 2020 Vincent Vuong. All rights reserved.
//

import Foundation
import Snail

class CarsViewModel {
    enum State {
        case loading
        case loaded
        case error(error: ApiError)
    }

    public var state = Observable<State>()
    private let carFaxService: CarFaxService

    init(carFaxService: CarFaxService) {
        self.carFaxService = carFaxService
    }

    func fetchListings() {
        state.on(.next(.loading))

        carFaxService.getListings(onNext: { [weak self] listings in
            self?.state.on(.next(.loaded))
        }, onError: { [weak self] error in
            self?.state.on(.next(.error(error: error)))
        })
    }
}
