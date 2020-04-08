//
//  Constants.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/29/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

public enum URLs {
    public enum Category {
        static let movie: String = "movie/"
        static let popular: String = "popular"
        static let upcoming: String = "upcoming"
    }
    static let apiKey: String = "?api_key=79fd70ca187e9b5219025e4d0c3e0eec"
    static let initialURL: String = "https://api.themoviedb.org/3/"
    static let initialImageURL: String = "https://image.tmdb.org/t/p/w342"
}
