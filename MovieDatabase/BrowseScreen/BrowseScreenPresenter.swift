//
//  BrowseScreenPresenter.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/30/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import Foundation

class BrowseScreenPresenter {
    
    weak var view: BrowseScreenViewInput?
    var interactor: BrowseScreenInteractorInput?

}

extension BrowseScreenPresenter: BrowseScreenViewOutput {
    func selectedMove(movieId: Int) {
        interactor?.selectedMovieId(movieId: movieId)
    }
}

extension BrowseScreenPresenter: BrowseScreenInteractorOutput {
    func dataDidUpdate(entity: BrowseScreenInteractor.Entity) {
        let viewModel = BrowseScreenViewController.ViewModel(movieDisplayInfos: entity.movies)
        view?.set(viewModel: viewModel)
    }
    
}
