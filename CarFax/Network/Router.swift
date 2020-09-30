//
//  Router.swift
//  CarFax
//
//  Created by Vincent Vuong on 9/30/20.
//  Copyright © 2020 Vincent Vuong. All rights reserved.
//

import Foundation

class Router<Endpoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?

    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let url = route.url else {
            completion(nil, nil, ApiError.invalidURL)
            return
        }

        task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            completion(data, response, error == nil ? nil : ApiError.network)
        }
        self.task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }
}
