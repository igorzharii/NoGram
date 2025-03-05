//
//  StorageService.swift
//  NoGram
//

import Foundation

class StorageService {
    private var defaults: UserDefaults { .standard }
    private let viewedStoriesKey = "viewedStories"
    private let likedStoriesKey = "likedStories"

    func seeStory(_ id: String) {
        var viewed = getViewedStories()
        if !viewed.contains(id) {
            viewed.append(id)
        }
        defaults.set(viewed, forKey: viewedStoriesKey)
    }

    func getViewedStories() -> [String] {
        defaults.stringArray(forKey: viewedStoriesKey) ?? []
    }

    func likeStory(_ id: String) {
        var liked = getLikedStories()
        if !liked.contains(id) {
            liked.append(id)
        }
        defaults.set(liked, forKey: likedStoriesKey)
    }

    func unlikeStory(_ id: String) {
        var likedStories = getLikedStories()
        likedStories.removeAll { $0 == id }
        defaults.set(likedStories, forKey: likedStoriesKey)
    }

    func getLikedStories() -> [String] {
        defaults.stringArray(forKey: likedStoriesKey) ?? []
    }
}
