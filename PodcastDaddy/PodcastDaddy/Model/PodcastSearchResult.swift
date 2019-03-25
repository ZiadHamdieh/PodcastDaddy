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
    var artworkUrl600: String?
    let feedUrl: String
    let collectionName: String
    let trackCount: Int
}

struct Episode: Decodable {
    let title: String
}
