//////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Cache.swift
//
//  Created by Dalton Cherry on 9/24/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////////////////////////

import Foundation

//This protocol can be implemented for custom image caching.
public protocol CacheProtocol {
    
    ///the directory to be used for saving images to disk
    var diskDirectory: String { get set }
    
    ///return a data blob from memory. Do NOT do long blocking calls IO calls in this method, only intend for fast hash lookups.
    func fromMemory(hash: String) -> Data?
    
    ///add an item to the cache
    func add(hash: String, data: Data)
    
    ///add an item to the cache
    func add(hash: String, url: URL)
    
    ///remove all the items from memory. This can be used to relieve memory pressue.
    func clearCache()

}

///The default image cache implemention. This uses a combo of a Dictionary and custom LinkedList to cache.
///This allows constant time lookups, inserts, deletes, and maintains a LRU so the eviction can happen easily and quickly

///our linked list to find the LRU(Least Recently Used) image to evict from the cache when the time comes
class ImageNode {
    let hash: String!
    var prev: ImageNode?
    var next: ImageNode?
    var data: Data!
    
    init(_ hash: String) {
        self.hash = hash
    }
}

///This makes the == work for ImageNode objects
extension ImageNode: Equatable {}

func ==(lhs: ImageNode, rhs: ImageNode) -> Bool {
    return lhs.hash == rhs.hash
}

///The default implementation of the CacheProtocol
///ImageManager uses this by default.
public class CacheManager: CacheProtocol {
    
    ///the amount of images to store in memory before pruning
    public var imageCount = 50
    
    ///the length of time a image is saved to disk before it expires (int seconds).
    public var diskAge = 60 * 60 * 24 //24 hours
    
    ///the directory to be used for saving images to disk
    public var diskDirectory: String
    
    ///images keeps a mapping from url hashes to imageNodes, this way nodes can be found in constant time
    private var nodeMap = Dictionary<String,ImageNode>()
    
    ///keeps a track of the start point of the list
    private var head: ImageNode?
    
    ///keeps a track of the end point of the list
    private var tail: ImageNode?
    
    /**
     Initializes a new ImageCache
     
     :param: cacheDirectory is the directory on disk to save cached images to.
     */
    init(_ cacheDirectory: String) {
        self.diskDirectory = cacheDirectory
    }
    
    /**
     Checks the nodeMap for an image
     
     :param: hash is the hashed url of the requested image url.
     
     :returns: A NSData blob of the image
     */
    public func fromMemory(hash: String) -> Data? {
        let node = nodeMap[hash]
        if let n = node {
            addToFront(node: n)
            return n.data
        }
        return nil
    }
    
    
    /**
     Moves an image URL from the temp directory to the cacheDirectory. This is because HTTP download requests save images to the temp directory when being download.
     The image is then added to the in-memory cache.
     
     :param: hash is the hashed url of the requested image url.
     :param: url is the location to the image in the temp directory.
     
     */
    public func add(hash: String, url: URL) {
        let cachePath = "\(self.diskDirectory)/\(hash)"
        let moveUrl = NSURL(fileURLWithPath: cachePath)
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: moveUrl as URL)
        try?fileManager.moveItem(at: url, to: moveUrl as URL)
        let data = fileManager.contents(atPath: cachePath)
        if let d = data {
            add(hash: hash, data: d)
        }
    }
    
    /**
     Adds an image to the in-memory cache.
     
     :param: hash is the hashed url of the requested image url.
     :param: data is the image data to add.
     
     */
    public func add(hash: String, data: Data) {
        var node: ImageNode! = nodeMap[hash]
        if node == nil {
            node = ImageNode(hash)
        }
        node.data = data
        nodeMap.removeValue(forKey: hash)
        nodeMap[hash] = node
        addToFront(node: node)
        if nodeMap.count > self.imageCount {
            prune()
        }
    }
    
    /**
     Purges the in-memory cache.
     
     */
    public func clearCache() {
        head = nil
        tail = nil
        nodeMap.removeAll(keepingCapacity: true)
    }
    
    ///cleans the cache up by removing the LRU
    private func prune() {
        if let t = tail {
            let prev = t.prev
            t.prev = nil
            prev?.next = nil
            self.nodeMap.removeValue(forKey: t.hash)
            tail = prev
        }
    }
    
    ///create the diskDirectory folder if it does not exist
    private func createDiskDirectory() {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: self.diskDirectory) {
            try? fileManager.createDirectory(atPath: self.diskDirectory, withIntermediateDirectories: false, attributes: nil)
        }
    }
    
    ///adds the node to the front of the list (it is the most recently used!)
    private func addToFront(node: ImageNode) {
        
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
