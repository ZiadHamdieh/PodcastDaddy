//
//  CMTimeExtension.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-26.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import AVKit

extension CMTime {
    func toFormattedTimeStamp() -> String {
        let timeInt = Int(CMTimeGetSeconds(self))
        let hours = timeInt / 3600
        let minutes = timeInt / 60 - 60 * hours
        let seconds = timeInt % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
