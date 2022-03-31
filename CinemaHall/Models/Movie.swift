//
//  Movies.swift
//  CinemaHall
//
//  Created by Jumman Hossen on 31/03/22.
//

import Foundation

struct MovieResponse: Codable{
    let results: [Movie]
}

struct Movie: Codable, Identifiable, Hashable{
    static func == (lhs: Movie, rhs: Movie) -> Bool{
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let title: String
//    let adult: Bool
    let backdropPath: String?
    let posterPath: String?
//    let originalLanguage: String
//    let originalTitle: String
    let overview: String
//    let video: Bool
    let voteAverage: Double
    let voteCount: Int
//    let popularity: Int
    let runtime: Int?
    
    var backdropURL: URL{
     return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
}
