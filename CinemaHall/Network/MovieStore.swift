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
    private let baseAPI = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndpoint) async throws -> [Movie] {
        <#code#>
    }
    
    func fetchMovie(id: Int) async throws -> Movie {
        <#code#>
    }
    
    func searchMovie(query: String) async throws -> [Movie] {
        <#code#>
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
