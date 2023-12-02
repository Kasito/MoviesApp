//
//  testApp.swift
//  testApp
//
//  Created by Kasito on 02.12.2023.
//

import SwiftUI

@main
struct MoviesApp: App {
    var vm = MovieViewModel(networkService: NetworkService())
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: vm)
        }
    }
}
