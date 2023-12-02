//
//  MovieListView.swift
//  testApp
//
//  Created by Kasito on 02.12.2023.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieViewModel
    @State private var page: Int = 1
    @State private var searchText = ""
    @State private var isActive = false
    
    var body: some View {
    
        NavigationView {
            VStack {
                SearchBar(searchText: $searchText)
                    .onChange(of: searchText) { newText in
                        viewModel.searchMovie(searchText: newText)
                    }
                List(viewModel.filteredItems, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailView(title: movie.title, countOccurrences: viewModel.countOccurrences(title: movie.title))) {
                        MovieCell(movie: movie)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                            .onAppear {
                                if viewModel.movies.last?.title == movie.title {
                                    page += 1
                                    viewModel.fetchTopRatedMovies(page: page)
                                }
                            }
                    }
                }
                
                .refreshable {
                    searchText = ""
                    viewModel.movies.removeAll()
                    viewModel.fetchTopRatedMovies()
                }
               
                .navigationTitle("Top Rated Movies")
            }
        }
    }
}

struct MovieCell: View {
    var movie: MovieItem
    
    var body: some View {
        VStack {
            Text(movie.title)
                .bold()
            AsyncImage(url: URL(string: movie.posterURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "exclamationmark.icloud")
                        .imageScale(.large)
                        .frame(width: 50, height: 50)
                @unknown default:
                    fatalError()
                }
                
                HStack {
                    Spacer()
                    Text("Vote average: \(String(format: "%.1f", movie.vote_average))")
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search movie", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .foregroundColor(Color.gray)
                .accessibilityIdentifier("searchBarTextField")
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var vm = MovieViewModel(networkService: NetworkService())
    static var previews: some View {
        MovieListView(viewModel: vm)
    }
}
