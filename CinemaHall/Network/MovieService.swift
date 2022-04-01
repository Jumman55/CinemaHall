//
//  MovieService.swift
//  CinemaHall
//
//  Created by Jumman Hossen on 01/04/22.
//

import Foundation

protocol MovieService{
    
    func fetchMovies(from endpoint: MovieListEndpoint) async throws -> [Movie]
    func fetchMovie(id: Int) async throws -> Movie
    func searchMovie(query: String) async throws -> [Movie]
    
}//:MovieService

enum MovieListEndpoint: String, CaseIterable, Identifiable{
    
    var id: String{rawValue}
    
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    /*
     Note clear why do i need CaseIterable protocol and rawValue, and
     discription
     */
    var description: String{
        switch self{
            case .nowPlaying:
                return "Now Playing"
            case .upcoming:
                return "Upcoming"
            case .topRated:
                return "Top Rated"
            case .popular:
                return "Popular"
            
        }
    }
    
}//:MovieListEndpoint

enum MovieError: Error, LocalizedError{
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String{
        switch self{
            case .apiError:
                return "Failed to fetch data from the API"
            case .invalidEndpoint:
                return "Given endpoint is not valid"
            case .invalidResponse:
                return "The web response is not 200"
            case .noData:
                return "No data found from the API"
            case .serializationError:
                return "Failed to decode data"
        }
    }
}//:MovieError
