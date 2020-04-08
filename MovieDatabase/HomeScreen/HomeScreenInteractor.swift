//
//  HomeScreenInteractor.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/28/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

protocol HomeScreenInteractorOutput: AnyObject {
    func dataDidUpdate(entity: HomeScreenInteractor.Entity)
}

protocol HomeScreenInteractorInput: AnyObject {
    func browseTapped()
    func backgroundMovieTapped()
}

class HomeScreenInteractor {
    
    struct Entity {
        let movieForHomescreen: GeneralMovieModel?
        let backgroundImage: UIImage?
    }
    
    var entity: Entity?
    
    weak var presenter: HomeScreenInteractorOutput?
    var router: HomeScreenRouting?
    
    var popularMovies: MoviesModel?
    
    var currentBackgroundMovieId: Int?
    
    func fetchLatestMovie() {
        let url = URL(string: URLs.initialURL + URLs.Category.movie + URLs.Category.popular + URLs.apiKey)
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
                let popularMovies = try JSONDecoder().decode(MoviesModel.self, from: responseData)
                self.popularMovies = popularMovies
                let randomMovie = self.randomMovieFromPopular(popularMovies: popularMovies)
                FetchImage.shared.imagePath = randomMovie?.posterPath
                FetchImage.shared.fetchImage { (backgroundImage) in
                    let entity = Entity(movieForHomescreen: randomMovie, backgroundImage: backgroundImage)
                    self.entity = entity
                    self.presenter?.dataDidUpdate(entity: entity)
                }
            } catch {
                print (error)
            }
        }
        
        let dataTask = session.dataTask(with: request, completionHandler: completionHandler)
        dataTask.resume()
    }
    
    func randomMovieFromPopular(popularMovies: MoviesModel) -> GeneralMovieModel? {
        let numberOfMovies = popularMovies.results?.count ?? 0
        let randomIndex = Int.random(in: 0..<numberOfMovies)
        currentBackgroundMovieId = popularMovies.results?[randomIndex].id
        return popularMovies.results?[randomIndex]
    }
}

extension HomeScreenInteractor: HomeScreenInteractorInput {
    
    func backgroundMovieTapped() {
        guard let movieId = currentBackgroundMovieId else {
            return
        }
        
        router?.displayBackgroundMovieDetail(movieId: movieId)
    }
    
    func browseTapped() {
        guard let popularMovies = popularMovies else {
            return
        }
        router?.displayPopularScreen(movies: popularMovies)
    }
    
}
