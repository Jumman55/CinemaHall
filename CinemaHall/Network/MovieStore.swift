//
//  MovieStore.swift
//  CinemaHall
//
//  Created by Jumman Hossen on 01/04/22.
//

import Foundation

class MovieStore: MovieService{
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "e69b260d5a26f972787b9aa2a8f69709"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndpoint) async throws -> [Movie] {
        guard let url = URL(string: "\(baseAPIURL)/movie\(endpoint.rawValue)") else{
            throw MovieError.invalidEndpoint
        }
        let movieResponse: MovieResponse = try await self.loadAndDecode(url: url)
        print(movieResponse.results)
        return movieResponse.results
    }
    
    func fetchMovie(id: Int) async throws -> Movie {
        guard let url = URL(string: "\(baseAPIURL)/movie\(id)") else{
            throw MovieError.invalidEndpoint
        }
        return try await self.loadAndDecode(url: url, params: ["append_to_response": "vidoes,credits"])
    }
    
    func searchMovie(query: String) async throws -> [Movie] {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else{
            throw MovieError.invalidEndpoint
        }
        let movieResponse: MovieResponse = try await self.loadAndDecode(url: url, params: [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ])
        return movieResponse.results
    }
    
    
    private func loadAndDecode<C: Codable>(url: URL, params: [String: String]? = nil) async throws -> C{
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else{
            throw MovieError.invalidEndpoint
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map{ URLQueryItem(name: $0.key, value: $0.value)})
        }// Not clear about the query but still understand basic part
        
        urlComponents.queryItems = queryItems //No idea what is that mean
        
        guard let finalURL = urlComponents.url else{
            throw MovieError.invalidEndpoint
        }
        
        let (data, response) = try await urlSession.data(from: finalURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
            throw MovieError.invalidResponse
        }
        return try self.jsonDecoder.decode(C.self, from: data)
    }
    
   
    
}
