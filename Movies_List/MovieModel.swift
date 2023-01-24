//
//  MovieModel.swift
//  Movies_List
//
//  Created by Alejandro Arce on 23/1/23.
//

import Foundation
struct Search : Decodable {
    let search: [MovieModelTitle]
}

struct MovieModelTitle: Decodable{
    let title: String
    let id: String
}

struct MovieModelId: Decodable {
    let title: String
    let description: String
    let imdbid: String
    let poster: String
    let score : Int
}

