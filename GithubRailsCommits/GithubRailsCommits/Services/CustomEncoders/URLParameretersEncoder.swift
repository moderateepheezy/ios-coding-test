//
//  URLParameretersEncoder.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import Foundation

struct URLParameretersEncoder: ParametersEncoder {

    func encode(parameters: [String: Any], in request: URLRequest) throws -> URLRequest {
        var request = request
        var query = "?"

        parameters.forEach {
            query.append("\($0.key)=\($0.value)&")
        }

        /// Removes last component of the query.
        query.removeLast()

        guard
            let urlString = request.url?.absoluteString,
            let encoded = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: urlString + encoded)
        else {
            throw NSError("Encoding Error")
        }
        request.url = url
        return request
    }
}
