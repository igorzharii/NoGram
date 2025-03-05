//
//  StoriesService.swift
//  NoGram
//

import Foundation

class StoriesService {
    let storageService: StorageService
    init(storageService: StorageService) {
        self.storageService = storageService
    }

    func fetchStories(page: Int, pageSize: Int) async -> [StoryUser] {
        // simulate like we're doing something
        try? await Task.sleep(for: .milliseconds(200))

        let viewedIds = storageService.getViewedStories()
        let likedIds = storageService.getLikedStories()

        return generateStories(page: page, pageSize: pageSize)
            .map { story in
                var updatedStory = story
                updatedStory.seen = viewedIds.contains(story.id)
                updatedStory.isLiked = likedIds.contains(story.id)
                return updatedStory
            }
    }

    // we generate stories and imitate backend
    private func generateStories(page: Int, pageSize: Int)  -> [StoryUser] {
        let start = (page * pageSize) + (1 * page)
        let end = start + pageSize
        return (start...end)
            .map {
                let stringId = String($0)
                let firstSymbol = String(stringId.first!)
                let lastSymbol = String(stringId.last!)
                return StoryUser(
                    id: String($0),
                    username: "agent_00\($0)",
                    seen: false,
                    avatar: $0 % 15 != 0 ? .image(URL(string: "https://i.pravatar.cc/300?u=1")!) : .initials(firstSymbol + lastSymbol),
                    isLiked: false
                )
            }
    }
}
