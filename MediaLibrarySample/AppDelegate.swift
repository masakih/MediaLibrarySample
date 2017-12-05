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
    
    private let libaray = MLMediaLibrary(options: [MLMediaLoadIncludeSourcesKey: [MLMediaSourceiTunesIdentifier],
                                           MLMediaLoadSourceTypesKey: MLMediaSourceType.audio.rawValue])
    private var mediaSource: MLMediaSource?
    private var rootMediaGroup: MLMediaGroup?
    
    private struct ObservalSet {
        var library: NSKeyValueObservation?
        var source: NSKeyValueObservation?
        var rootGroup: NSKeyValueObservation?
        
        init() {}
    }
    private var observerSet = ObservalSet()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        observerSet.library = libaray.observe(\MLMediaLibrary.mediaSources) { (lib, _) in
            
            lib.mediaSources.map(self.setMediaSources(sources:))
        }
        
        libaray.load()
    }
    
    private func setMediaSources(sources: [String: MLMediaSource]) {
        
        mediaSource = sources[MLMediaSourceiTunesIdentifier]
        
        observerSet.source = mediaSource?.observe(\MLMediaSource.rootMediaGroup) { (source, _) in
            
            source.rootMediaGroup.map(self.setRootMediaGroup(rootGroup:))
        }
        
        mediaSource?.load()
    }
    
    private func setRootMediaGroup(rootGroup: MLMediaGroup) {
        
        rootMediaGroup = rootGroup
        
        observerSet.rootGroup = rootMediaGroup?.observe(\MLMediaGroup.mediaObjects) { (rootGroup, _) in
            
            rootGroup.mediaObjects.map(self.setMediaObjects(mediaObjects:))
        }
        
        rootMediaGroup?.load()
    }
    
    private func setMediaObjects(mediaObjects newObjects: [MLMediaObject]) {
        
        mediaObjects = newObjects
    }
}
