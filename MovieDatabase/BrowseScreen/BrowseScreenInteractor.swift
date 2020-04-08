//
//  BrowseScreenInteractor.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/30/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

protocol BrowseScreenInteractorInput: AnyObject {
    func selectedMovieId(movieId: Int)
}

protocol BrowseScreenInteractorOutput: AnyObject {
    func dataDidUpdate(entity: BrowseScreenInteractor.Entity)
}

class BrowseScreenInteractor {
    
    weak var presenter: BrowseScreenInteractorOutput?
    var router: BrowseScreenRouting?
    let popularMovies: MoviesModel
    var entity: BrowseScreenInteractor.Entity?
    
    init(popularMoview: MoviesModel) {
        self.popularMovies = popularMoview
    }
    
    struct Entity {
        let movies: [GeneralMovieModel]
    }
    
    func start() {
        guard let popularMovies = popularMovies.results else {
            return
        }
        
        let entity = Entity(movies: popularMovies)
        self.entity = entity
        
        self.presenter?.dataDidUpdate(entity: entity)
    }

}

extension BrowseScreenInteractor: BrowseScreenInteractorInput {
    func selectedMovieId(movieId: Int) {
        router?.displayDetailScreen(movieId: movieId)
    }
    
}

