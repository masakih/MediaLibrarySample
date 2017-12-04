//
//  AppDelegate.swift
//  MediaLibraryTest
//
//  Created by Hori,Masaki on 2017/12/04.
//  Copyright © 2017年 Hori,Masaki. All rights reserved.
//

import Cocoa

import MediaLibrary

private var mediaSourcesContext = 0
private var rootMediaGroupContext = 0
private var mediaObjectsContext = 0

private struct MLMediaLibraryPropertyKeys {
    static let mediaSourcesKey = "mediaSources"
    static let rootMediaGroupKey = "rootMediaGroup"
    static let mediaObjectsKey = "mediaObjects"
    static let contentTypeKey = "contentType"
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    let libaray = MLMediaLibrary(options: [MLMediaLoadIncludeSourcesKey: [MLMediaSourceiTunesIdentifier],
                                           MLMediaLoadSourceTypesKey: MLMediaSourceType.audio.rawValue])
    
    private var mediaSource: MLMediaSource?
    private var rootMediaGroup: MLMediaGroup?
    
    @objc dynamic var mediaObjects: [MLMediaObject] = []
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        libaray.addObserver(self,
                            forKeyPath: MLMediaLibraryPropertyKeys.mediaSourcesKey,
                            options: NSKeyValueObservingOptions.new,
                            context: &mediaSourcesContext)
        
        libaray.mediaSources?.forEach { key, value in print(key) }
    }
    
    private func observeMediaSource() {
        
        guard let ms = libaray.mediaSources?[MLMediaSourceiTunesIdentifier] else { return }
        
        mediaSource = ms
        
        mediaSource?.addObserver(self,
                       forKeyPath: MLMediaLibraryPropertyKeys.rootMediaGroupKey,
                       options: NSKeyValueObservingOptions.new,
                       context: &rootMediaGroupContext)
        
        mediaSource?.rootMediaGroup.map { print($0) }
        
    }
    
    private func observeGroup() {
        
        mediaSource?.removeObserver(self, forKeyPath: MLMediaLibraryPropertyKeys.rootMediaGroupKey)
        
        rootMediaGroup = mediaSource?.rootMediaGroup
        
        rootMediaGroup?.addObserver(self,
                                    forKeyPath: MLMediaLibraryPropertyKeys.mediaObjectsKey,
                                    options: NSKeyValueObservingOptions.new,
                                    context: &mediaObjectsContext)
        
        rootMediaGroup?.mediaObjects?.forEach { print($0) }
        
    }
    
    private func observeObject() {
        
        rootMediaGroup?.removeObserver(self, forKeyPath: MLMediaLibraryPropertyKeys.mediaObjectsKey)
        
        guard let objects = rootMediaGroup?.mediaObjects else { return }
        
        self.mediaObjects = objects
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == MLMediaLibraryPropertyKeys.mediaSourcesKey,
            context == &mediaSourcesContext,
            object! is MLMediaLibrary {
            
            observeMediaSource()
            return
        }
        
        if keyPath == MLMediaLibraryPropertyKeys.rootMediaGroupKey,
            context == &rootMediaGroupContext,
            object! is MLMediaSource {
            
            observeGroup()
            return
        }
        
        if keyPath == MLMediaLibraryPropertyKeys.mediaObjectsKey,
            context == &mediaObjectsContext,
            object! is MLMediaGroup {
            
            observeObject()
            return
        }
        
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
    }

}

