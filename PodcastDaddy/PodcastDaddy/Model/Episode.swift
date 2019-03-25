//
//  Episode.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-25.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit
import FeedKit

struct Episode {
    let title: String
    let description: String
    let pubDate: Date
    var imageUrl: String
    let author: String
    
    
    init(fromFeedItem item: RSSFeedItem) {
        self.title = item.title ?? ""
        self.description = item.iTunes?.iTunesSubtitle ?? item.description ?? ""
        self.pubDate = item.pubDate ?? Date()
        self.imageUrl = item.iTunes?.iTunesImage?.attributes?.href ?? ""
        self.author = item.iTunes?.iTunesAuthor ?? ""
    }
    
}
