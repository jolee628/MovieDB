//
//  HomeScreenViewController.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/28/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

protocol HomeScreenViewInput: AnyObject {
    func setViewModel(viewModel: HomeScreenViewController.ViewModel)
}

protocol HomeScreenViewOutput: AnyObject {
    func browseTapped()
    func backgroundMovieTapped()
}

class HomeScreenViewController: UIViewController {
    var homeView = HomeScreenView()
    
    var presenter: HomeScreenViewOutput?
    
    struct ViewModel {
        let backgroundImage: UIImage
        let iconImage: UIImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        view.alpha = 1
        setUpView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
    }
    
    func setUpView() {
        view.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeView.rightAnchor.constraint(equalTo: view.rightAnchor),
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension HomeScreenViewController: HomeScreenViewInput {
    func setViewModel(viewModel: HomeScreenViewController.ViewModel) {
        homeView.apply(viewModel: viewModel)
    }
}

extension HomeScreenViewController: HomeScreenViewDelegate {
    
    func showBackgroundMovie() {
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
            self.removeSpinner()
            self.presenter?.backgroundMovieTapped()
        }
    }
    
    func browseButtonTapped() {
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
            self.removeSpinner()
            self.presenter?.browseTapped()
        }
    }
}
