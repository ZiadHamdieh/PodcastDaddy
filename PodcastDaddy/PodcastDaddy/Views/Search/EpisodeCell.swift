//
//  EpisodeCell.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-25.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    fileprivate let dateFormatter = DateFormatter()
    
    var episode: Episode! {
        didSet {
            artwork.sd_setImage(with: URL(string: episode.imageUrl))
            print("episode imageurl: \(episode.imageUrl)")
            title.text = episode.title
            publicationDate.text = dateFormatter.string(from: episode.pubDate)
            summary.text = episode.description 

        }
    }

    fileprivate let title = UILabel(text: "Episode Title", font: .boldSystemFont(ofSize: 18), numberOfLines: 2)
    fileprivate let publicationDate = UILabel(text: "Pub Date", font: .systemFont(ofSize: 16))
    fileprivate let summary = UILabel(text: "Description of the episode", font: .systemFont(ofSize: 14), numberOfLines: 3)
    fileprivate let artwork: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.constrainWidth(constant: 120)
        iv.constrainHeight(constant: 120)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        publicationDate.textColor = .purple
        summary.textColor = UIColor(white: 0.5, alpha: 1)
        
        let stackView = UIStackView(arrangedSubViews: [
            artwork,
            VerticalStackView(arrangedSubviews: [
                publicationDate,
                title,
                summary
                ], spacing: 4)
            ], spacing: 28)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackView.alignment = .center
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
