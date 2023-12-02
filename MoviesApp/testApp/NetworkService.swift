//
//  NetworkService.swift
//  testApp
//
//  Created by Kasito on 02.12.2023.
//

import UIKit

class NetworkService: ObservableObject {
    
    let bearer = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYmY0YmI3NzlhZDljOTlmZGRlZGZiZmIyZmJiNTQzMiIsInN1YiI6IjY1NmExZGNlNGE0YmY2MDEzZDhkNDUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kPi3rt5TDI6j42sQUKFpjBH0Nfqnip0LgYv02hn7wGQ"
    
    func fetchRatedMovies(page: Int, completion: @escaping ([MovieItem]?, Error?) -> Void) {
        let baseURL = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=\(page)"
        let headers = ["accept": "application/json", "Authorization": bearer]
        guard  let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MovieItems.self, from: data)
                    completion(result.results, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
        
        dataTask.resume()
    }
}



