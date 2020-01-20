//
//  RequestFactory.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import Foundation

final class RequestFactory {

    func makeRequest(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?) -> URLRequest {
        let encoding: ParametersEncoder = [.GET, .DELETE].contains(method) ? URLParameretersEncoder() : JSONParametersEncoder()

        guard let url = URL(string: url) else {
            fatalError("Wrong URL")
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 46.0)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.rawValue

        if let parameters = parameters {
            guard let encoded = try? encoding.encode(parameters: parameters, in: urlRequest) else {
                fatalError()
            }
            urlRequest = encoded
        }

        if let headers = headers {
            headers.forEach {
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }

        return urlRequest
    }
}
