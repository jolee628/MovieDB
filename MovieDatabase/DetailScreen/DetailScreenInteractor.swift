//
//  DetailScreenInteractor.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/30/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

protocol DetailScreenInteractorOutput: AnyObject {
    func dataDidUpdate(entity: DetailScreenInteractor.Entity)
}

protocol DetailScreenInteractorInput: AnyObject {
    
}

class DetailScreenInteractor {
    
    struct Entity {
        let movieDetail: GeneralMovieModel?
        let posterImage: UIImage?
    }
    
    let movieId: Int
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    weak var presenter: DetailScreenInteractorOutput?
    
    func fetchMovieDetail() {
        let url = URL(string: URLs.initialURL + URLs.Category.movie + "\(movieId)\(URLs.apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let completionHandler: (Data?, URLResponse?, Error?) -> Void = {
            (data, response, error) in
            
            guard error == nil else {
                return
            }

            guard let responseData = data else {
                print ("No Data")
                return
            }
            
            do {
                let movieDetail = try JSONDecoder().decode(GeneralMovieModel.self, from: responseData)
                FetchImage.shared.imagePath = movieDetail.posterPath
                FetchImage.shared.fetchImage { (backgroundImage) in
                    let entity = Entity(movieDetail: movieDetail, posterImage: backgroundImage)
                    self.presenter?.dataDidUpdate(entity: entity)
                }
            } catch {
                print (error)
            }
        }
        
        let dataTask = session.dataTask(with: request, completionHandler: completionHandler)
        dataTask.resume()
    }
}

extension DetailScreenInteractor: DetailScreenInteractorInput {
    
}
