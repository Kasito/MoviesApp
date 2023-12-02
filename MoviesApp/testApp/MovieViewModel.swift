//
//  MovieViewModel.swift
//  testApp
//
//  Created by Kasito on 02.12.2023.
//

import UIKit

class MovieViewModel: ObservableObject {
    
    @Published var filteredItems = [MovieItem]()
    
    var networkService: NetworkService
    var movies = [MovieItem]()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        fetchTopRatedMovies()
    }
    
    func fetchTopRatedMovies(page: Int = 1) {
        networkService.fetchRatedMovies(page: page) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self.movies.append(contentsOf: result)
                    self.filteredItems = self.movies
                }
            } else if error != nil {
                print("Error fetching top-rated movies: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func searchMovie(searchText: String) {
        if searchText.isEmpty {
            filteredItems = movies
        } else {
            filteredItems = movies.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func countOccurrences(title: String) -> [Character : Int] {
        var characterCounts: [Character: Int] = [:]
        
        let resultString = String(title.filter { $0.isLetter }).lowercased()
        for char in resultString {
            characterCounts[char, default: 0] += 1
        }
        
        return characterCounts
    }
}
