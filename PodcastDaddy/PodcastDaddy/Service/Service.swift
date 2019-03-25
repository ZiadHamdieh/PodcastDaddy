//
//  Service.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-24.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import Alamofire
import FeedKit

class Service {
    
//    private init()
    
    static let shared = Service()
    
    func fetchPodcasts(searchQuery: String, completionHandler: @escaping (PodcastSearchResult?) -> ()) {
        let urlString = "https://itunes.apple.com/search"
        let parameters = ["term"  : searchQuery,
                          "media" : "podcast",
                          "limit" : "25"]
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData(completionHandler: { (response) in
            if let error = response.error {
                print("Failed to fetch search results: ", error)
                return
            }
            
            guard let resp = response.data else { return }
            
            do {
                let podcastData = try JSONDecoder().decode(PodcastSearchResult.self, from: resp)
                completionHandler(podcastData)
            } catch let decodeError {
                print("Failed to decode search JSON: ", decodeError)
            }
        })
        
        Alamofire.request(urlString)
    }
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        
        let isUsingHTTPS = feedUrl.contains("https") ? true : false
        if !isUsingHTTPS {
            print("WARNING: Accessing rss feed through unsecured HTTP protocol")
        }
        
        guard let url = URL(string: feedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { result in
            switch result {
            case let .rss(feed):
                completionHandler(feed.toEpisodes())
                break
            case let .failure(error):
                print("Could not fetch episodes using HTTPS: ", error)
                break
            default:
                print("Found a feed")
            }
        }
    }
    
}
