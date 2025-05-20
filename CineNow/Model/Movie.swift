//
//  Movie.swift
//  CineNow
//
//  Created by Rishal Bazim on 24/04/25.
//

import Foundation

struct PopularMoviesResponse: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let poster_path: String?
    let backdrop_path: String?
    let genre_ids: [Int]
    let vote_average: Double
    let vote_count: Int
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
