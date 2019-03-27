//
//  PlayerView.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-25.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit
import AVKit

class PlayerView: UIView {
    
    fileprivate let imageViewScale: CGFloat = 0.8
    
    var episode: Episode! {
        didSet {
            episodeTitleLabel.text = episode.title
            authorLabel.text = episode.author
            imageView.sd_setImage(with: URL(string: episode.imageUrl))
            imageView.transform = CGAffineTransform(scaleX: imageViewScale, y: imageViewScale)
            playEpisode()
        }
    }
    
    fileprivate func observeCurrentPlayTime() {
        // observe time elapsed on player since beginning of episode as well as total duration
        let interval = CMTimeMake(value: 1, timescale: 1)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            let timeElapsedString = time.toFormattedTimeStamp()
            self.currentTimestampLabel.text = timeElapsedString
            
            let totalDurationString = self.player.currentItem?.duration.toFormattedTimeStamp()
            self.totalDurationTimestampLabel.text = totalDurationString
        
            self.updateSliderForCurrentTimeStamp()
        }
    }
    
    fileprivate func updateSliderForCurrentTimeStamp() {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let duration = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = Float(currentTime / duration)
        
        playbackTimeSlider.setValue(percentage, animated: false)
    }
    
    override func didMoveToSuperview() {
        
        observeCurrentPlayTime()
        
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) {
            self.animateImageViewTransition()
        }
        
    }
    
    fileprivate let player: AVPlayer = {
        let avp = AVPlayer()
        avp.automaticallyWaitsToMinimizeStalling = false
        return avp
    }()
    
    let currentTimestampLabel: UILabel = {
        let label = UILabel(text: "--:--:--", font: .systemFont(ofSize: 12))
        label.textColor = UIColor(white: 0.5, alpha: 1)
        return label
    }()
    
    let totalDurationTimestampLabel: UILabel = {
        let label = UILabel(text: "--:--:--", font: .systemFont(ofSize: 12))
        label.textColor = UIColor(white: 0.5, alpha: 1)
        return label
    }()
    
    
    let dismissEpisodeButton: UIButton = {
        let button = UIButton(type: .system)
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
    
//    let playbackSettingsButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "verticalMenuDots"), for: .normal)
//        button.constrainWidth(constant: 30)
//        button.constrainHeight(constant: 30)
//        button.tintColor = .purple
//        return button
//    }()
    
    let playbackTimeSlider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(handlePlaybackSliderDrag), for: .touchUpInside)
        return slider
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        button.constrainWidth(constant: 50)
        button.constrainHeight(constant: 100)
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        return button
    }()
    
    let rewind15SecButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "rewind15"), for: .normal)
        button.tintColor = .black
        button.constrainHeight(constant: 50)
        button.addTarget(self, action: #selector(handleRewind), for: .touchUpInside)
        return button
    }()
    
    let forward15SecButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "fastforward15"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleFastForward), for: .touchUpInside)
        button.constrainHeight(constant: 50)
        return button
    }()
    
    let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValueImage = #imageLiteral(resourceName: "muted_volume")
        slider.maximumValueImage = #imageLiteral(resourceName: "max_volume")
        slider.setValue(0.65, animated: false)
        slider.addTarget(self, action: #selector(handleVolumeChange), for: .touchUpInside)
        return slider
    }()
    
    let episodeTitleLabel = UILabel(text: "Title", font: .boldSystemFont(ofSize: 20), numberOfLines: 2)
    
    let authorLabel = UILabel(text: "Ziad Hamdieh", font: .systemFont(ofSize: 18))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        episodeTitleLabel.textAlignment = .center
        authorLabel.textColor = .purple
        volumeSlider.tintColor = .purple
        playbackTimeSlider.tintColor = .purple
        dismissEpisodeButton.tintColor = .purple
        dismissEpisodeButton.titleLabel?.textColor = .purple
        
        
        imageView.constrainWidth(constant: 0.9 * self.frame.width)
        volumeSlider.constrainWidth(constant: 0.9 * self.frame.width)
        playbackTimeSlider.constrainWidth(constant: 0.8 * self.frame.width)
        
//        let playbackStackView = UIStackView(arrangedSubviews: [
//            currentTimestampLabel,
//            totalDurationTimestampLabel
//            ])
//        playbackStackView.alignment = .center
        
        let episodeCredentialsStackView = VerticalStackView(arrangedSubviews: [
            episodeTitleLabel,
            authorLabel,
            ], spacing: 15)
        episodeCredentialsStackView.alignment = .center
        
//        let horizontalStackView = UIStackView(arrangedSubViews: [
//            UIView(),
//            episodeCredentialsStackView,
//            playbackSettingsButton
//            ], spacing: 15)
//        horizontalStackView.alignment = .center
        
        let controlsStackView = UIStackView(arrangedSubViews: [
            rewind15SecButton,
            playPauseButton,
            forward15SecButton
            ], spacing: 60)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            dismissEpisodeButton,
            imageView,
            playbackTimeSlider,
//            playbackStackView,
//            horizontalStackView,
            episodeCredentialsStackView,
            controlsStackView,
            volumeSlider
            ], spacing: 40)
        addSubview(stackView)
        let bottomStatusBarClearance = UIApplication.shared.statusBarFrame.height
        stackView.fillSuperview(padding: .init(top: 50, left: 20, bottom: 50 + bottomStatusBarClearance, right: 20))
        stackView.alignment = .center
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc fileprivate func handlePlayPause(_ sender: UIButton) {
            if self.player.timeControlStatus == .playing {
                self.player.pause()
                sender.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                animateImageViewTransition()
            } else {
                self.player.play()
                sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                animateImageViewTransition()
            }
    }
    
    @objc fileprivate func handleDismiss() {
        self.removeFromSuperview()
    }
    
    fileprivate func playEpisode() {
        guard let episodeUrl = URL(string: episode.episodeUrl) else { return }
        let playerItem = AVPlayerItem(url: episodeUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    fileprivate func animateImageViewTransition() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if self.player.timeControlStatus == .playing {
                self.imageView.transform = .identity
            } else {
                self.imageView.transform = CGAffineTransform(scaleX: self.imageViewScale, y: self.imageViewScale)
            }
        })
    }
    
    @objc fileprivate func handlePlaybackSliderDrag(sender: UISlider) {
        let percentage = sender.value
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: Int32(NSEC_PER_SEC))
        player.seek(to: seekTime)
    }
    
    @objc fileprivate func handleVolumeChange(sender: UISlider) {
        player.volume = sender.value
    }
    
    @objc fileprivate func handleRewind() {
        performTimeShift(direction: .backwards)
    }
    
    @objc fileprivate func handleFastForward() {
        performTimeShift(direction: .forwards)
    }
    
    fileprivate enum TimeShiftDirection {
        case forwards
        case backwards
    }
    
    fileprivate func performTimeShift(direction: TimeShiftDirection) {
        let timeShift = CMTimeMakeWithSeconds(Float64(15), preferredTimescale: 1)
        switch direction {
        case .backwards:
            player.seek(to: player.currentTime() - timeShift)
            break
        case .forwards:
            player.seek(to: player.currentTime() + timeShift)
        }
        
    }
    
}


//import UIKit
//
//class LoopLabelView: UIView {
//
//    private var labelText : String?
//    private var rect0: CGRect!
//    private var rect1: CGRect!
//    private var labelArray = [UILabel]()
//    private var isStop = false
//    private var timeInterval: TimeInterval!
//    private let leadingBuffer = CGFloat(25.0)
//    private let loopStartDelay = 2.0
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    var text: String? {
//        didSet {
//            labelText = text
//            setup()
//        }
//    }
//
//    func setup() {
//        self.backgroundColor = UIColor.yellow
//        let label = UILabel()
//        label.text = labelText
//        label.frame = CGRect.zero
//
//
//        timeInterval = TimeInterval((labelText?.count)! / 5)
//        let sizeOfText = label.sizeThatFits(CGSize.zero)
//        let textIsTooLong = sizeOfText.width > frame.size.width ? true : false
//
//        rect0 = CGRect(x: leadingBuffer, y: 0, width: sizeOfText.width, height: self.bounds.size.height)
//        rect1 = CGRect(x: rect0.origin.x + rect0.size.width, y: 0, width: sizeOfText.width, height: self.bounds.size.height)
//        label.frame = rect0
//
//        super.clipsToBounds = true
//        labelArray.append(label)
//        self.addSubview(label)
//
//        //self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: 0, height: 0))
//
//        if textIsTooLong {
//            let additionalLabel = UILabel(frame: rect1)
//            additionalLabel.text = labelText
//            self.addSubview(additionalLabel)
//
//            labelArray.append(additionalLabel)
//
//            animateLabelText()
//        }
//    }
//
//    func animateLabelText() {
//        if(!isStop) {
//            let labelAtIndex0 = labelArray[0]
//            let labelAtIndex1 = labelArray[1]
//
//            UIView.animate(withDuration: timeInterval, delay: loopStartDelay, options: [.curveLinear], animations: {
//                labelAtIndex0.frame = CGRect(x: -self.rect0.size.width,y: 0,width: self.rect0.size.width,height: self.rect0.size.height)
//                labelAtIndex1.frame = CGRect(x: labelAtIndex0.frame.origin.x + labelAtIndex0.frame.size.width,y: 0,width: labelAtIndex1.frame.size.width,height: labelAtIndex1.frame.size.height)
//            }, completion: { finishied in
//                labelAtIndex0.frame = self.rect1
//                labelAtIndex1.frame = self.rect0
//
//                self.labelArray[0] = labelAtIndex1
//                self.labelArray[1] = labelAtIndex0
//                self.animateLabelText()
//            })
//        } else {
//            self.layer.removeAllAnimations()
//        }
//    }
//}
