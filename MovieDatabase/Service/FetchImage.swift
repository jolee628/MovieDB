//
//  FetchImage.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/29/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

class FetchImage {
    static let shared = FetchImage()
    var imagePath: String?
    
    func fetchImage(complete: @escaping ( _ image: UIImage?) -> Void) {
        var imageUrl: URL?
        if let imagePath = imagePath {
            imageUrl = URL(string: URLs.initialImageURL + imagePath)
        }
        
        let request = URLRequest(url: imageUrl!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let completionHandler: (Data?, URLResponse?, Error?) -> Void = {
            (data, response, error) in
            if error != nil {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let image = UIImage(data: data)
                complete(image)
            } catch {
                print (error)
            }
        }
        
        let dataTask = session.dataTask(with: request, completionHandler: completionHandler)
        dataTask.resume()
    }
    
}
