//
//  EpisodesController.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-25.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    fileprivate let cellId = "cellId"
    
    var podcast: Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName ?? ""
            fetchEpisodes()
            self.tableView.reloadData()
        }
    }
    
    fileprivate var episodes = [Episode]()
    
    fileprivate func fetchEpisodes() {
        
        guard let feedUrl = podcast?.feedUrl else { return }
        
        let isUsingHTTPS = feedUrl.contains("https") ? true : false
        if !isUsingHTTPS {
            print("WARNING: Accessing rss feed through unsecured HTTP protocol")
        }
        
        guard let url = URL(string: feedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { result in
            switch result {
            case let .rss(feed):
                self.episodes = feed.toEpisodes()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case let .failure(error):
                print("Could not fetch episodes using HTTPS: ", error)
                break
            default:
                print("Found a feed")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let currentEpisode = episodes[indexPath.row]
        cell.episode = currentEpisode
        return cell
    }
    
}
