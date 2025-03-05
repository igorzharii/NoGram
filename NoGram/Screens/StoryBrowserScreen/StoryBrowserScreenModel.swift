//
//  StoryBrowserScreenModel.swift
//  NoGram
//

import SwiftUI

class StoryBrowserScreenModel: ObservableObject, Identifiable {
    var id: Bool { true }
    @Published var stories: [StoryUser]
    @Published var currentIndex: Int
    var currentStory: StoryUser {
        get {
            stories[currentIndex]
        }
        set {
            stories[currentIndex] = newValue
        }
    }
    let closeHandler: () -> Void

    private let storageService: StorageService
    init(stories: [StoryUser], currentStory: StoryUser, storageService: StorageService, closeHandler: @escaping () -> Void) {
        self.stories = stories
        self.currentIndex = stories.firstIndex(of: currentStory) ?? 0
        self.closeHandler = closeHandler
        self.storageService = storageService

        self.currentStory.seen = true
        self.storageService.seeStory(currentStory.id)
    }

    func tappedForward() {
        let newIndex = currentIndex + 1
        guard isValidIndex(newIndex) else {
            closeHandler()
            return
        }
        currentIndex = newIndex
        currentStory.seen = true
        storageService.seeStory(currentStory.id)
    }

    func tappedBackward() {
        let newIndex = currentIndex - 1
        guard isValidIndex(newIndex) else {
            closeHandler()
            return
        }
        currentIndex = newIndex
        currentStory.seen = true
        storageService.seeStory(currentStory.id)
    }

    func tappedLike() {
        currentStory.isLiked.toggle()
        if currentStory.isLiked {
            storageService.likeStory(currentStory.id)
        } else {
            storageService.unlikeStory(currentStory.id)
        }
    }

    private func getIndex(of story: StoryUser) -> Int? {
        stories.firstIndex(of: story)
    }

    private func isValidIndex(_ index: Int) -> Bool {
        index >= 0 && index < stories.count
    }
}
