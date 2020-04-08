//
//  HomeScreenPresenter.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/28/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

class HomeScreenPresenter {
    weak var view: HomeScreenViewInput?
    var interactor: HomeScreenInteractorInput?
    
    func makeViewModel(entity: HomeScreenInteractor.Entity) -> HomeScreenViewController.ViewModel {
        let backgroundImage = entity.backgroundImage ?? UIImage(named: "icondark")!
        let iconImage = UIImage(named: "themoviedb")!
        let viewModel = HomeScreenViewController.ViewModel(backgroundImage: backgroundImage, iconImage: iconImage)
        return viewModel
    }
}

extension HomeScreenPresenter: HomeScreenViewOutput {
    
    func backgroundMovieTapped() {
        interactor?.backgroundMovieTapped()
    }
    
    func browseTapped() {
        interactor?.browseTapped()
    }
    
}

extension HomeScreenPresenter: HomeScreenInteractorOutput {
    func dataDidUpdate(entity: HomeScreenInteractor.Entity) {
        let viewModel = makeViewModel(entity: entity)
        view?.setViewModel(viewModel: viewModel)
    }
    
}
