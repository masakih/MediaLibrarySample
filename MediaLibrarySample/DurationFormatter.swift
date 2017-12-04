//
//  DurationFormatter.swift
//  MediaLibraryTest
//
//  Created by Hori,Masaki on 2017/12/04.
//  Copyright © 2017年 Hori,Masaki. All rights reserved.
//

import Cocoa

final class DurationFormatter: Formatter {
    
    override func string(for obj: Any?) -> String? {
        
        let v: Double? = {
            if let o = obj as? NSNumber { return o.doubleValue }
            if let o = obj as? Date { return Double(o.timeIntervalSince1970) }
            return nil
        }()
        
        guard let interval = v else { return "" }
        
        let hour = Int(interval / (60 * 60))
        let minComp = interval - Double(hour * 60 * 60)
        let minutes = Int(minComp / 60)
        let secComp = minComp - Double(minutes * 60)
        let seconds = Int(secComp)
        
        return String(format: "%02ld:%02ld:%02ld", hour, minutes, seconds)
    }
}
