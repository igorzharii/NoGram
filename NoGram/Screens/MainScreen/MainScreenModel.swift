//
//  MainScreenModel.swift
//  NoGram
//

import Combine
import SwiftUI

class MainScreenModel: ObservableObject {
    @Published var browserModel: StoryBrowserScreenModel?
    @Published private(set) var stories: [StoryUser] = []

    private let storageService: StorageService
    private let storiesService: StoriesService

    private var currentPage = 0
    private let pageSize = 10

    private var cancellables = Set<AnyCancellable>()
    private var isLoading = false
    init() {
        self.storageService = StorageService()
        self.storiesService = StoriesService(storageService: storageService)

        loadMore()
    }

    func storyTapped(_ story: StoryUser) {
        browserModel = StoryBrowserScreenModel(stories: stories, currentStory: story, storageService: storageService) { [weak self] in
            self?.browserModel = nil
        }
        browserModel?.$stories.assign(to: &$stories)
    }

    func loadMore() {
        guard !isLoading else {
            return
        }
        isLoading = true
        Task {
            let stories = await storiesService.fetchStories(page: currentPage, pageSize: pageSize)
            currentPage += 1
            await MainActor.run {
                self.stories.append(contentsOf: stories)
            }
            isLoading = false
        }
    }
}
