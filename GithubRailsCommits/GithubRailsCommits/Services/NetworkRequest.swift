//
//  NetworkRequest.swift
//  GithubRailsCommits
//
//  Created by Afees Lawal on 20/01/2020.
//  Copyright © 2020 Sample. All rights reserved.
//

import Foundation


final class HTTPNetworkRequestPerformer {

    func performDataTask<T>(
        with request: URLRequest,
        responseType: T.Type,
        completion: @escaping (T?, _ errorMessage: String?) -> Void) where T : Decodable {

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {

                guard let data = data else {
                    completion(nil, error?.localizedDescription)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result, nil)

                } catch let error {
                    print(error.localizedDescription)
                    completion(nil, error.localizedDescription)
                }
            }
        }.resume()
    }
}
