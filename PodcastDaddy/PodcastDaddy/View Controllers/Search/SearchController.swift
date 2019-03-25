//
//  SearchController.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-24.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit
import SDWebImage

class SearchController: UITableViewController, UISearchBarDelegate {
    
    fileprivate let cellId = "cellId"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var podcasts: PodcastSearchResult? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        
    }
    
    fileprivate func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Podcasts"
        definesPresentationContext = true
    }
    
    fileprivate func setupTableView() {
        tableView.register(PodcastSearchCell.self, forCellReuseIdentifier: cellId)
        // to get rid of separator lines without actually removing them
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastSearchCell
        cell.selectionStyle = .none
        let podcast = podcasts?.results[indexPath.row]
        cell.podcast = podcast
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodesController = EpisodesController()
        episodesController.podcast = podcasts?.results[indexPath.row]
        navigationController?.pushViewController(episodesController, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Service.shared.fetchPodcasts(searchQuery: searchText) { podcastResults in
            self.podcasts = podcastResults
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.text = "Search for a Podcast"
        header.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        header.textAlignment = .center
        header.textColor = .purple
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (podcasts?.results.count ?? 0) > 0 ? 0 : 250
    }
    
}
