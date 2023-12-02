//
//  MovieDetailScreen.swift
//  testApp
//
//  Created by Kasito on 02.12.2023.
//

import SwiftUI

struct MovieDetailView: View {
    var title: String
    var countOccurrences: [Character : Int]
    
    var body: some View {
        VStack {
            Text("Character Count for \n\(title):")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            ForEach(Array(countOccurrences), id: \.key) { char, count in
                HStack {
                    Text("\(String(char)):")
                    Text("\(count)")
                }
                .padding(.horizontal)
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(title: "test", countOccurrences: ["a" : 5])
    }
}
