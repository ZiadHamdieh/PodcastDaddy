//
//  PodcastSearchCell.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-24.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class PodcastSearchCell: UITableViewCell {
    
    var podcast: Result! {
        didSet {
            title.text = podcast?.trackName ?? ""
            artist.text = podcast?.artistName ?? ""
            episodeCount.text = (podcast.trackCount > 1) ?
                "\(podcast.trackCount) episodes" :
                "\(podcast.trackCount) episode"
            imageView?.sd_setImage(with: URL(string: podcast?.artworkUrl100 ?? ""))
        }
    }
    
    let artwork: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        iv.constrainWidth(constant: 80)
        iv.constrainHeight(constant: 80)
        return iv
    }()
    
    let title = UILabel(text: "", font: .boldSystemFont(ofSize: 18))
    let artist = UILabel(text: "", font: .systemFont(ofSize: 16))
    let episodeCount = UILabel(text: "", font: .systemFont(ofSize: 16) )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        episodeCount.textColor = UIColor(white: 0.5, alpha: 1)
        
        let stackView = UIStackView(arrangedSubViews: [
            artwork,
            UIView(),
            VerticalStackView(arrangedSubviews: [
                title,
                artist,
                episodeCount
                ], spacing: 8)
            ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
