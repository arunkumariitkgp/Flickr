//
//  APIManager.swift
//  Flickr
//
//  Created by Arun Kumar on 28/10/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class APIManager: NSObject {

    func getImagesWithText(_ text : String,
                           _ page : Int,
                       completion : @escaping (_ response : [String : Any]) -> ()) {
        
        DispatchQueue.global().async {
            var components = URLComponents(string : "https://api.flickr.com/services/rest/")
            components?.queryItems = [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: "3e7cc266ae2b0e0d78e279ce8e361736"),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
                URLQueryItem(name: "safe_search", value: "1"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "text", value: text)
            ]
            
            guard let url = components?.url else {
                return
            }
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: urlRequest) {
                (data, response, error) in
                guard error == nil else {
                    return
                }
                guard let responseData = data else {
                    return
                }
                do {
                    guard let response = try JSONSerialization.jsonObject(with: responseData, options: [])
                        as? [String: Any] else {
                            return
                    }
                    completion(response)
                } catch  {
                    return
                }
            }
            task.resume()
        }
    }
}
