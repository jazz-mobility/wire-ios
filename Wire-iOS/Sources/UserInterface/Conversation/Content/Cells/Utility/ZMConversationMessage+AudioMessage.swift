// 
// Wire
// Copyright (C) 2016 Wire Swiss GmbH
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
// 


import Foundation

extension ZMConversationMessage {
    public func audioCanBeSaved() -> Bool {
        if let fileMessageData = self.fileMessageData,
            let fileURL = fileMessageData.fileURL,
            let _ = fileURL.path
            where fileMessageData.isAudio() {
            return true
        }
        else {
            return false
        }
    }
    
    func audioTrack() -> AudioTrack? {
        if let fileMessageData = self.fileMessageData
            where fileMessageData.isAudio() {
            return self as? AudioTrack
        }
        else {
            return .None
        }
    }
}

extension ZMAssetClientMessage: AudioTrack {
    public var title: String? {
        get {
            guard let fileMessageData = self.fileMessageData else { return "" }
            
            return fileMessageData.filename
        }
    }
    public var author: String? {
        get {
            return self.sender?.displayName
        }
    }
    
    public var artwork: UIImage? {
        get {
            return .None
        }
    }
    
    public var duration: NSTimeInterval {
        get {
            guard let fileMessageData = self.fileMessageData else { return 0 }
            
            return NSTimeInterval(Float(fileMessageData.durationMilliseconds) / 1000.0)
        }
    }
    
    public var artworkURL: NSURL? {
        get {
            return .None
        }
    }
    
    public var streamURL: NSURL? {
        get {
            guard let fileMessageData = self.fileMessageData,
                let fileURL = fileMessageData.fileURL else { return .None }
            
            return fileURL
        }
    }
    
    public var previewStreamURL: NSURL? {
        get {
            return .None
        }
    }
    
    public var externalURL: NSURL? {
        get {
            return .None
        }
    }
    
    public var failedToLoad: Bool {
        get {
            return false
        }
        set {
            // no-op
        }
    }
    
    public func fetchArtwork() {
        // no-op
    }
    
}
