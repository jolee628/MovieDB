//
//  MoviesModel.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/28/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import Foundation

struct MoviesModel: Decodable {
    let results: [GeneralMovieModel]?
}
