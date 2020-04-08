//
//  DetailScreenPresenter.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/30/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import Foundation

class DetailScreenPresenter {
    var interactor: DetailScreenInteractorInput?
    weak var view: DetailScreenViewInput?
    
    func makeViewModel(entity: DetailScreenInteractor.Entity) -> DetailScreenViewController.ViewModel {
        
        var rating: String?
        if let voteAverage = entity.movieDetail?.voteAverage {
            rating = starRating(average: voteAverage)
        }
        
        return DetailScreenViewController.ViewModel(title: entity.movieDetail?.title, overview: entity.movieDetail?.overview, rating: rating, image: entity.posterImage)
    }
    
    func starRating(average: Float) -> String {
        let numberOfStars = round((average/10)*5)
        var starString = ""
        for _ in stride(from: 0, to: numberOfStars, by: 1) {
            starString.append("🤩")
        }
        
        return starString
    }
}

extension DetailScreenPresenter: DetailScreenInteractorOutput {
    func dataDidUpdate(entity: DetailScreenInteractor.Entity) {
        let viewModel = makeViewModel(entity: entity)
        view?.set(viewModel: viewModel)
    }
    
}

extension DetailScreenPresenter: DetailScreenViewOutput {
    
}
