//
//  HomeScreenRouter.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/28/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

protocol HomeScreenRouting: AnyObject {
    func displayPopularScreen(movies: MoviesModel)
    func displayBackgroundMovieDetail(movieId: Int)
}

class HomeScreenRouter {
    private weak var viewController: HomeScreenViewController?
    
    func createViewController() -> HomeScreenViewController {
        let interactor = HomeScreenInteractor()
        let presenter = HomeScreenPresenter()
        let viewController = HomeScreenViewController()
        viewController.presenter = presenter
        interactor.presenter = presenter
        interactor.router = self
        presenter.interactor = interactor
        presenter.view = viewController
        self.viewController = viewController
        
        interactor.fetchLatestMovie()
        return viewController
    }
}

extension HomeScreenRouter: HomeScreenRouting {
    
    func displayBackgroundMovieDetail(movieId: Int) {
        let detailRouter = DetailScreenRouter(movieId: movieId)
        viewController?.navigationController?.pushViewController(detailRouter.createViewController(), animated: true)
    }
    
    func displayPopularScreen(movies: MoviesModel) {
        let browseRouter = BrowseScreenRouter(popularMovies: movies, type: URLs.Category.popular)
        viewController?.navigationController?.pushViewController(browseRouter.createViewController(), animated: true)
    }
    
}
