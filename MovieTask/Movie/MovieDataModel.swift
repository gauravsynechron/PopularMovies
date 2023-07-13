//
//  MovieDataModel.swift
//  MovieTask
//
//  Created by Gaurav R on 12/07/23.
//

import Foundation

struct ResponseData: Decodable {
    var page: Int?
    var total_pages: Int?
    var total_results: Int?
    var results: [MovieData]?
    var status_code: Int?
    var success: Bool?
    var status_message: String?
}

struct MovieData: Decodable {
    var title: String?
    var poster_path: String?
}
