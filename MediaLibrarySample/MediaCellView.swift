//
//  MediaCellView.swift
//  MediaLibraryTest
//
//  Created by Hori,Masaki on 2017/12/04.
//  Copyright © 2017年 Hori,Masaki. All rights reserved.
//

import Cocoa

import MediaLibrary

class MediaCellView: NSTableCellView {
    
    struct AttributeKey {
        
        fileprivate let rawValue: String
        
        static let dateModified = AttributeKey(rawValue: "Date Modified")
        static let contentType = AttributeKey(rawValue: "contentType")
        static let protected = AttributeKey(rawValue: "Protected")
        static let year = AttributeKey(rawValue: "Year")
        static let genre = AttributeKey(rawValue: "Genre")
        static let identifier = AttributeKey(rawValue: "identifier")
        static let trackID = AttributeKey(rawValue: "Track ID")
        static let trackCount = AttributeKey(rawValue: "Track Count")
        static let duration = AttributeKey(rawValue: "Duration")
        static let totalTime = AttributeKey(rawValue: "Total Time")
        static let bitRate = AttributeKey(rawValue: "Bit Rate")
        static let sampleRate = AttributeKey(rawValue: "Sample Rate")
        static let name = AttributeKey(rawValue: "name")
        static let kind = AttributeKey(rawValue: "Kind")
        static let artist = AttributeKey(rawValue: "Artist")
        static let mediaSourceIdentifier = AttributeKey(rawValue: "mediaSourceIdentifier")
        static let album = AttributeKey(rawValue: "Album")
        static let modificationDate = AttributeKey(rawValue: "modificationDate")
        static let mediaType = AttributeKey(rawValue: "mediaType")
        static let TrackNumber = AttributeKey(rawValue: "Track Number")
        static let dateAdded = AttributeKey(rawValue: "Date Added")
        static let URL = AttributeKey(rawValue: "URL")
        static let fileSize = AttributeKey(rawValue: "fileSize")
        static let releaseDate = AttributeKey(rawValue: "Release Date")
        
    }
    
    override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        
        switch key {
        case #keyPath(objectValue): return []
        default: return [#keyPath(objectValue)]
        }
    }
    
    @IBOutlet weak var artistField: NSTextField?
    @IBOutlet weak var durationField: NSTextField?
    @IBOutlet weak var modificationDateField: NSTextField?
    
    @objc dynamic var duration: Any? {
        
        return self[.duration]
    }
    
    @objc dynamic var artist: String? {
        
        return self[.artist]
    }
    
    override var backgroundStyle: NSView.BackgroundStyle {
        didSet {
            switch backgroundStyle {
            case .dark:
                textColor = .white
            default:
                textColor = .controlTextColor
            }
        }
    }
    
    private var textColor: NSColor = .controlTextColor {
        didSet {
            artistField?.textColor = textColor
            durationField?.textColor = textColor
            modificationDateField?.textColor = textColor
        }
    }
    
    private subscript<T>(_ key: AttributeKey) -> T? {
        
        guard let mediaObject = objectValue as? MLMediaObject else { return nil }
        return mediaObject.attributes[key.rawValue] as? T
    }
    
}
