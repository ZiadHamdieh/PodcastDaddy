//
//  SearchController.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-24.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit
import Alamofire

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
    
//
//    fileprivate let podcasts = [
//        PodcastSearchResult(name: "1", artistName: "1"),
//        PodcastSearchResult(name: "1", artistName: "1"),
//        PodcastSearchResult(name: "1", artistName: "1"),
//    ]
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let podcast = podcasts?.results[indexPath.row]
        cell.textLabel?.text = podcast?.trackName
//        cell.title.text = podcast?.trackName ?? ""
//        cell.artist.text = podcast?.artistName ?? ""
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let urlString = "https://itunes.apple.com/search"
        let parameters = ["term"  : searchText,
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
                self.podcasts = podcastData
            } catch let decodeError {
                print("Failed to decode search JSON: ", decodeError)
            }
        })
        
        Alamofire.request(urlString)
    }
    
}
