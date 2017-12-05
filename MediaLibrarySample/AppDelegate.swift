//
//  AppDelegate.swift
//  MediaLibraryTest
//
//  Created by Hori,Masaki on 2017/12/04.
//  Copyright © 2017年 Hori,Masaki. All rights reserved.
//

import Cocoa

import MediaLibrary

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    @objc dynamic var mediaObjects: [MLMediaObject] = []
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        observerSet.library = libaray.observe(\MLMediaLibrary.mediaSources) { lib, _ in
            
            self.mediaSource = lib.mediaSources?[MLMediaSourceiTunesIdentifier]
        }
        
        libaray.load()
    }
    
    private let libaray = MLMediaLibrary(options: [MLMediaLoadIncludeSourcesKey: [MLMediaSourceiTunesIdentifier],
                                           MLMediaLoadSourceTypesKey: MLMediaSourceType.audio.rawValue])
    private var mediaSource: MLMediaSource? {
        didSet {
            
            observerSet.source = mediaSource?.observe(\MLMediaSource.rootMediaGroup) { source, _ in
                
                self.rootMediaGroup = source.rootMediaGroup
            }
            
            mediaSource?.load()
        }
    }
    private var rootMediaGroup: MLMediaGroup? {
        didSet {
            
            observerSet.rootGroup = rootMediaGroup?.observe(\MLMediaGroup.mediaObjects) { rootGroup, _ in
                
                self.mediaObjects = rootGroup.mediaObjects ?? []
            }
            
            rootMediaGroup?.load()
        }
    }
    
    private struct ObservalSet {
        var library: NSKeyValueObservation?
        var source: NSKeyValueObservation?
        var rootGroup: NSKeyValueObservation?
        
        init() {}
    }
    private var observerSet = ObservalSet()
}
