//
//  PlayerView.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-25.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    
    var episode: Episode! {
        didSet {
            episodeTitleLabel.text = episode.title
            authorLabel.text = episode.author
            imageView.sd_setImage(with: URL(string: episode.imageUrl))
        }
    }
    
    let dismissEpisodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.constrainHeight(constant: 350)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let playbackTimeSlider = UISlider()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "pause"), for: .selected)
        button.constrainWidth(constant: 50)
        button.constrainHeight(constant: 100)
        button.addTarget(self, action: #selector(handlePress), for: .touchUpInside)
        return button
    }()
    
    let rewind15SecButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "rewind15"), for: .normal)
        button.constrainHeight(constant: 50)
        return button
    }()
    
    let forward15SecButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "rewind15"), for: .normal)
        button.constrainHeight(constant: 50)
        return button
    }()
    
    let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValueImage = #imageLiteral(resourceName: "muted_volume")
        slider.maximumValueImage = #imageLiteral(resourceName: "max_volume")
        return slider
    }()
    
    let episodeTitleLabel = UILabel(text: "Title skladm slkdm askldm aslkdm", font: .boldSystemFont(ofSize: 20), numberOfLines: 2)
    
    let authorLabel = UILabel(text: "Ziad Hamdieh", font: .systemFont(ofSize: 18))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        authorLabel.textColor = .purple
        volumeSlider.tintColor = .purple
        playbackTimeSlider.tintColor = .purple
        dismissEpisodeButton.tintColor = .purple
        
        imageView.constrainWidth(constant: 0.9 * self.frame.width)
        volumeSlider.constrainWidth(constant: 0.9 * self.frame.width)
        playbackTimeSlider.constrainWidth(constant: 0.8 * self.frame.width)
        
        let episodeCredentialsStackView = VerticalStackView(arrangedSubviews: [
            episodeTitleLabel,
            authorLabel,
            ], spacing: 15)
        episodeCredentialsStackView.alignment = .center
        
        let controlsStackView = UIStackView(arrangedSubViews: [
            rewind15SecButton,
            playPauseButton,
            forward15SecButton
            ], spacing: 60)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            dismissEpisodeButton,
            imageView,
            playbackTimeSlider,
            episodeCredentialsStackView,
            controlsStackView,
            volumeSlider
            ], spacing: 40)
        addSubview(stackView)
        let bottomStatusBarClearance = UIApplication.shared.statusBarFrame.height
        stackView.fillSuperview(padding: .init(top: 40, left: 20, bottom: 50 + bottomStatusBarClearance, right: 20))
        stackView.alignment = .center
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc fileprivate func handlePress(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.6) {
            sender.imageView?.alpha = 0
            sender.isSelected.toggle()
            sender.imageView?.alpha = 1
        }
    }
    
    @objc fileprivate func handleDismiss() {
        self.removeFromSuperview()
    }
    
    
}
