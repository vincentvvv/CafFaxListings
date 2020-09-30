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
    }

    public var state = Observable<State>()

    init() {}

    func fetchCars() {
        state.on(.next(.loading))
    }
}
