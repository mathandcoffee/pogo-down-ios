//
//  SplashEvent.swift
//  FuckYouTube
//
//  Created by Bryan Malumphy on 8/6/22.
//

import Foundation

enum SplashEvent: Event {
    case finishedPreloading(createdAt: Date = Date())
    case preloadingFailed(createdAt: Date = Date())
}
