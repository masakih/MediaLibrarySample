//
//  MediaLibraryExtension.swift
//  MediaLibrarySample
//
//  Created by Hori,Masaki on 2017/12/05.
//  Copyright © 2017年 Hori,Masaki. All rights reserved.
//

import Foundation
import MediaLibrary

extension MLMediaLibrary {
    
    func load() {
        
        _ = mediaSources?.reduce(0) { _,_ in 1 }
    }
}

extension MLMediaSource {
    
    func load() {
        
        _ = rootMediaGroup.map { _ in 1 }
    }
}

extension MLMediaGroup {
    
    func load() {
        
        _ = mediaObjects.map { _ in 1 }
    }
}
