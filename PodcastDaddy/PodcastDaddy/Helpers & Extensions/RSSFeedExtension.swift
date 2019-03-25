//
//  RSSFeedExtension.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-25.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import FeedKit

extension RSSFeed {
    func toEpisodes() -> [Episode] {
        
        var episodes = [Episode]()
        
        let imageUrl = iTunes?.iTunesImage?.attributes?.href
        
        items?.forEach({ feedItem in
            
            var episode = Episode(fromFeedItem: feedItem)
            
            if episode.imageUrl.isEmpty {
                episode.imageUrl = imageUrl ?? ""
            }
            
            episodes.append(episode)
        })
        
        return episodes
    }
}
