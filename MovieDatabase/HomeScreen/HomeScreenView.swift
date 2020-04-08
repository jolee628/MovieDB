//
//  HomeScreenView.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/28/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

protocol HomeScreenViewDelegate: class {
    // delegate method to notify the view controller that action has been requested
    func browseButtonTapped()
    func showBackgroundMovie()
}

class HomeScreenView: UIView {

    lazy var browseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Browse Popular Movies", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(browseAction), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    lazy var backgroundMovieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show me the background movie", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(backgroundMovieAction), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    weak var delegate: HomeScreenViewDelegate?
    
    
    @objc func browseAction() {
        delegate?.browseButtonTapped()
    }
    
    @objc func backgroundMovieAction() {
        delegate?.showBackgroundMovie()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundImage.addSubview(iconImage)
        backgroundImage.addSubview(backgroundMovieButton)
        backgroundImage.addSubview(browseButton)
        
        addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            browseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            browseButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            
            backgroundMovieButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundMovieButton.bottomAnchor.constraint(equalTo: browseButton.topAnchor, constant: -8),
            
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            // Making the icon image to stick to the top, center, and a square
            iconImage.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 50.0),
            iconImage.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            iconImage.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 0.3),
            iconImage.heightAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 0.3)
        ])
    }
    
    func apply(viewModel: HomeScreenViewController.ViewModel) {
        DispatchQueue.main.async {
            self.backgroundImage.image = viewModel.backgroundImage
            self.iconImage.image = viewModel.iconImage
        }
    }
    
}
