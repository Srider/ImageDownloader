//
//  CacheService.swift
//  MoviesApp
//
//  Created by Srikar on 19/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import Foundation


public protocol CacheDelegate{
    
    func fromMemory(_ keyUrl: String) -> DownloadDetail?
    
    func add(_ keyUrl: String, withDownloadDetail objDownloadDetail: DownloadDetail!)
    
    func add(_ objDownloadDetail: DownloadDetail!)
    
    func clearCache()
    
}

class ImageDetailNode {
    let keyUrl: String!
    let objDownloadDetail:DownloadDetail
    var prev: ImageDetailNode?
    var next: ImageDetailNode?
    
    init(_ keyUrl: String, withDownloadDetail objDownloadDetail: DownloadDetail) {
        self.keyUrl = keyUrl
        self.objDownloadDetail = objDownloadDetail
    }
}

extension ImageDetailNode: Equatable {
   
}

func ==(lhs: ImageDetailNode, rhs: ImageDetailNode) -> Bool {
    return lhs.keyUrl == rhs.keyUrl
}


class CacheService:CacheDelegate {
    
    static let sharedManager = CacheService()

    public var imageCount = 50
    
    public var diskAge = 60 //24 hours
    
    public var diskDirectory: String?
    
    private var nodeMap = Dictionary<String,ImageDetailNode>()
    
    private var head: ImageDetailNode?
    
    private var tail: ImageDetailNode?
    
    
    private init() {}
    
    func setCacheFolderName(_ cacheDirectory:String) {
        var dir = cacheDirectory
        if dir == "" {
            #if os(iOS)
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            dir = "\(paths[0])" //use default documents folder, not ideal but better than the cache not working
            #elseif os(OSX)
            let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
            if let name = NSBundle.mainBundle().bundleIdentifier {
                dir = "\(paths[0])/\(name)"
            }
            #endif
        }
        
        self.diskDirectory = cacheDirectory
    }

    /**
     Checks the nodeMap for an image
     
     :param: hash is the hashed url of the requested image url.
     
     :returns: A NSData blob of the image
     */
    public func fromMemory(_ keyUrl: String) -> DownloadDetail? {
        let node = nodeMap[keyUrl]
        if let n = node {
            addToFront(node: n)
            return n.objDownloadDetail
        }
        return nil
    }
    
    public func clearCache() {
        head = nil
        tail = nil
        nodeMap.removeAll(keepingCapacity: true)
    }
    
    func add(_ keyUrl: String, withDownloadDetail objDownloadDetail: DownloadDetail!) {
        var node: ImageDetailNode! = nodeMap[keyUrl]
        if node == nil {
            node = ImageDetailNode(keyUrl, withDownloadDetail: objDownloadDetail)
        }
        nodeMap.removeValue(forKey: keyUrl)
        nodeMap[keyUrl] = node
        addToFront(node: node)
        if nodeMap.count > self.imageCount {
            prune()
        }
    }
    
    func add(_ objDownloadDetail: DownloadDetail!) {
        add(objDownloadDetail!.strDownloadURL, withDownloadDetail: objDownloadDetail)
    }
    
    ///cleans the cache up by removing the LRU
    private func prune() {
        if let t = tail {
            let prev = t.prev
            t.prev = nil
            prev?.next = nil
            self.nodeMap.removeValue(forKey: t.keyUrl)
            tail = prev
        }
    }
    
    ///adds the node to the front of the list (it is the most recently used!)
    private func addToFront(node: ImageDetailNode) {
        
        //if this node is the tail, reassign tail to the prev node of the tail
        if let t = tail {
            if t == node && t.prev != nil {
                tail = t.prev
            }
        }
        //if this node was already in the list, we need to update its connections
        if let next = node.next {
            next.prev = node.prev
        }
        if let prev = node.prev {
            prev.next = node.next
        }
        //now append it to the head
        if let h = head {
            node.next = h
            h.prev = node
        } else {
            tail = node
        }
        head = node
    }
}
