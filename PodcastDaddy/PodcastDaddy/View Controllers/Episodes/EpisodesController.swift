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
    
    var podcast: Podcast! {
        didSet {
            navigationItem.title = podcast.trackName
            fetchEpisodes()
            self.tableView.reloadData()
        }
    }
    
    fileprivate func fetchEpisodes() {
        
    }
    
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let episode = episodes[indexPath.row]
        
        return cell
    }
    
}
