//
//  GeneralMovieModel.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/28/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import Foundation

struct GeneralMovieModel: Decodable {
    let title : String?
    let id: Int?
    let posterPath: String?
    let overview: String?
    let voteAverage: Float?
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case posterPath = "poster_path"
        case overview
        case voteAverage = "vote_average"
    }
}
