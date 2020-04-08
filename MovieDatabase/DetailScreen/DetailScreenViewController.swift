//
//  DetailScreenViewController.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/30/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

protocol DetailScreenViewInput: AnyObject {
    func set(viewModel: DetailScreenViewController.ViewModel)
}

protocol DetailScreenViewOutput: AnyObject {
    
}

class DetailScreenViewController: UIViewController {
    
    lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textAlignment = .center
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 36.0)
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    struct ViewModel {
        let title: String?
        let overview: String?
        let rating: String?
        let image: UIImage?
    }
    
    var presenter: DetailScreenViewOutput?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .black
        view.alpha = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        detailStackView.addArrangedSubview(ratingLabel)
        detailStackView.addArrangedSubview(titleLabel)
        detailStackView.addArrangedSubview(overviewLabel)
        
        view.addSubview(movieImageView)
        view.addSubview(detailStackView)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.4),
            
            detailStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 8),
            detailStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16),
            detailStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension DetailScreenViewController: DetailScreenViewInput {
    func set(viewModel: DetailScreenViewController.ViewModel) {
        DispatchQueue.main.async {
            self.movieImageView.image = viewModel.image
            self.titleLabel.text = viewModel.title
            
            if let overView = viewModel.overview {
                    self.overviewLabel.text = "Overview:\n\n" + overView
            } else {
                self.overviewLabel.text = "No Overview"
            }
            
            if let rating = viewModel.rating {
                self.ratingLabel.text = rating + " out of 5"
            } else {
                self.ratingLabel.text = "No Rating Available"
            }
            
        }
    }
}
