//
//  BrowseScreenViewController.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/30/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

protocol BrowseScreenViewInput: AnyObject {
    func set(viewModel: BrowseScreenViewController.ViewModel)
}

protocol BrowseScreenViewOutput: AnyObject {
    func selectedMove(movieId: Int)
}
class BrowseScreenViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BrowseTableViewCell.self, forCellReuseIdentifier: searchCellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = .black
        return tableView
    }()
    let searchCellId = "searchCellId"
    
    var presenter: BrowseScreenViewOutput?
    
    var viewModel: ViewModel?
    
    var previousSelectedindexPath: IndexPath?
    
    struct ViewModel {
        let movieDisplayInfos: [GeneralMovieModel]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .black
        if let previousSelectedindexPath = previousSelectedindexPath {
            tableView.deselectRow(at: previousSelectedindexPath, animated: false)
            self.previousSelectedindexPath = nil
        }
        view.alpha = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.alpha = 0
    }
    
    override func viewDidLoad() {
        setUpView()
    }
    
    func setUpView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension BrowseScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BrowseTableViewCell, let selectedMovieId = cell.movieId else {
          return
        }
        cell.selectionStyle = .none
        presenter?.selectedMove(movieId: selectedMovieId)
    }
}

extension BrowseScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        
        return viewModel.movieDisplayInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: searchCellId) as? BrowseTableViewCell else {
          return UITableViewCell()
        }
        FetchImage.shared.imagePath = viewModel.movieDisplayInfos[indexPath.row].posterPath
        FetchImage.shared.fetchImage { (movieImage) in
            DispatchQueue.main.async {
                cell.apply(viewModel: viewModel.movieDisplayInfos[indexPath.row], image: movieImage!)
            }
        }
        cell.layoutIfNeeded()
        return cell
    }
    
}

extension BrowseScreenViewController: BrowseScreenViewInput {
    func set(viewModel: BrowseScreenViewController.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}
