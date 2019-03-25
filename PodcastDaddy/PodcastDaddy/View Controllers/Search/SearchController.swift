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
    
    fileprivate func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        
    }
    
    fileprivate func setupTableView() {
        tableView.register(PodcastSearchCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastSearchCell
        let podcast = podcasts?.results[indexPath.row]
        cell.podcast = podcast
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Service.shared.fetchPodcasts(searchQuery: searchText) { podcastResults in
            self.podcasts = podcastResults
        }
    }
    
}
