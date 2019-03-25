//
//  PodcastSearchResult.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-24.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

struct PodcastSearchResult: Decodable {
    let results: [Result]
    let resultCount: Int
}

struct Result: Decodable {
    var trackName: String?
    var artistName: String?
    let artworkUrl100: String
    let collectionName: String
}
