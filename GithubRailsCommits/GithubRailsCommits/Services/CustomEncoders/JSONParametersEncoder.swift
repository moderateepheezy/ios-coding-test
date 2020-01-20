//
//  JSONParametersEncoder.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import Foundation

protocol ParametersEncoder {
    func encode(parameters: [String: Any], in request: URLRequest) throws -> URLRequest
}

struct JSONParametersEncoder: ParametersEncoder {

    func encode(parameters: [String: Any], in request: URLRequest) throws -> URLRequest {
        var request = request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let value = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.httpBody = value
        return request
    }
}
