//
//  DetailScreenRouter.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/30/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import Foundation

class DetailScreenRouter {
    
    let movieId: Int
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    private weak var viewController: DetailScreenViewController?

    func createViewController() -> DetailScreenViewController {
        let interactor = DetailScreenInteractor(movieId: movieId)
        let presenter = DetailScreenPresenter()
        let viewController = DetailScreenViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        self.viewController = viewController
        
        interactor.fetchMovieDetail()
        return viewController
    }
}
