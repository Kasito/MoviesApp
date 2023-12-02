//
//  MovieItems.swift
//  testApp
//
//  Created by Kasito on 02.12.2023.
//

import UIKit

struct MovieItem: Codable {
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Double
    
    var posterURL: String {
        "https://image.tmdb.org/t/p/w200\(poster_path)"
    }
}

struct MovieItems: Codable {
    let page: Int
    let results: [MovieItem]
    let total_pages: Int
    let total_results: Int
}

