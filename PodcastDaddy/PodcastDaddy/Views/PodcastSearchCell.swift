//
//  PodcastSearchCell.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-24.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class PodcastSearchCell: UITableViewCell {
    
    let artwork: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let title = UILabel()
    let artist = UILabel()
    
//    let separatorView: UIVie
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [
            artwork,
            title,
            artist
            ])
        addSubview(stackView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
