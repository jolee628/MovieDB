//
//  BrowseScreenTableViewCell.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/30/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

protocol VoteButtonDelegate: AnyObject {
    func buttonPresed(upvote: Bool)
}

class BrowseTableViewCell: UITableViewCell {
    lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imageWithVoteStackView: UIStackView = {
       let stackView = UIStackView(frame: .zero)
       stackView.axis = .horizontal
       stackView.distribution = .fillProportionally
       stackView.spacing = 0
       stackView.translatesAutoresizingMaskIntoConstraints = false
       return stackView
    }()
    
    lazy var upvoteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.tag = 0
//        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var downvoteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("-", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .black
        button.tag = 1
//        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return imageView
    }()
    
    lazy var titleLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    weak var delegate: VoteButtonDelegate?
    
    var movieId: Int?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpCell()
    }
    
    @objc func buttonPressed(_ sender: UIButton!) {
        print(sender.tag)
        delegate?.buttonPresed(upvote: false)
    }
    
    func setUpCell(){
        imageWithVoteStackView.addArrangedSubview(downvoteButton)
        imageWithVoteStackView.addArrangedSubview(movieImageView)
        imageWithVoteStackView.addArrangedSubview(upvoteButton)
        cellStackView.addArrangedSubview(imageWithVoteStackView)
        cellStackView.addArrangedSubview(titleLable)

        addSubview(cellStackView)
        backgroundColor = .black
        
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            cellStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            cellStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cellStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        titleLable.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        self.contentView.backgroundColor = .black
    }
    
    func apply(viewModel: GeneralMovieModel, image: UIImage) {
        movieImageView.image = image
        titleLable.text = viewModel.title
        movieId = viewModel.id
        layoutIfNeeded()
    }

}
