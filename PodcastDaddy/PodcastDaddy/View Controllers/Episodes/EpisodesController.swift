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
        }
    }
    
    fileprivate var episodes = [Episode]()
    
    fileprivate func fetchEpisodes() {
        guard let feedUrl = podcast?.feedUrl else { return }
        Service.shared.fetchEpisodes(feedUrl: feedUrl) { episodes in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        cell.selectionStyle = .none
        let currentEpisode = episodes[indexPath.row]
        cell.episode = currentEpisode
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let window = UIApplication.shared.keyWindow
        let playerView = PlayerView(frame: self.view.frame)
        playerView.episode = episodes[indexPath.row]
        playerView.backgroundColor = .white
        window?.addSubview(playerView)
    }
    
}
