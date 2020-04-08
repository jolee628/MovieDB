//
//  BrowseScreenRouter.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/30/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

protocol BrowseScreenRouting: AnyObject {
    func displayDetailScreen(movieId: Int)
}

class BrowseScreenRouter {
    let popularMovies: MoviesModel
    let type: String
    init(popularMovies: MoviesModel, type: String) {
        self.popularMovies = popularMovies
        self.type = type
    }
    private weak var viewController: BrowseScreenViewController?

    func createViewController() -> BrowseScreenViewController {
        let interactor = BrowseScreenInteractor(popularMoview: popularMovies)
        let presenter = BrowseScreenPresenter()
        let viewController = BrowseScreenViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.router = self
        self.viewController = viewController
        
        interactor.start()
        return viewController
    }
}

extension BrowseScreenRouter: BrowseScreenRouting {
    func displayDetailScreen(movieId: Int) {
        let detailViewController = DetailScreenRouter(movieId: movieId).createViewController()
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
