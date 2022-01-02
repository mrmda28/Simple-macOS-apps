//
//  NetworkManager.swift
//  URL-Shortener
//
//  Created by Dmitriy Maslennikov on 02/01/2022.
//  Copyright © 2022 Dmitriy Maslennikov. All rights reserved.
//

import Foundation

class NetworkManager {

    private let key = ""

    static let shared = NetworkManager()

    func getShortenedURL(urlString: String, completion: @escaping (String) -> ()) {
        guard let apiURL = URL(string: "https://cutt.ly/api/api.php?key=\(key)&short=\(urlString)") else { return }

        let dataTask = URLSession.shared.dataTask(with: apiURL) { data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
            else {
                completion("Error")
                return
            }
            
            guard
                let response = try? JSONDecoder().decode(APIResponse?.self, from: data)
            else {
                completion("Error")
                return
            }
            
            DispatchQueue.main.async {
                completion(response.url.shortLink)
            }
        }
        dataTask.resume()
    }
}
