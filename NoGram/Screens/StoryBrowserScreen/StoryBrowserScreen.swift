//
//  StoryBrowserScreen.swift
//  NoGram
//

import SwiftUI

struct StoryBrowserScreen: View {
    @StateObject var viewModel: StoryBrowserScreenModel

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black.ignoresSafeArea()

                VStack {
                    HStack {
                        Rectangle()
                            .frame(height: 2)

                        Button(action: viewModel.closeHandler) {
                            Image(systemName: "xmark")
                                .imageScale(.large)
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    VStack {
                        HStack {
                            avatarView(for: viewModel.currentStory.avatar)
                                .frame(width: 38, height: 38)
                            Text(viewModel.currentStory.username)
                                .foregroundColor(.white)
                                .font(.headline)
                            Spacer()
                        }
                        .padding()

                        Spacer()

                        Text("Imagine!")
                            .foregroundColor(.white)
                            .font(.largeTitle)

                        Spacer()

                    }
                    .contentShape(Rectangle())
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { value in
                                if value.location.x < geo.size.width / 2 {
                                    viewModel.tappedBackward()
                                } else {
                                    viewModel.tappedForward()
                                }
                            }
                    )
                    HStack {
                        Button(action: {
                            viewModel.tappedLike()
                        }) {
                            Image(systemName: viewModel.currentStory.isLiked ? "heart.fill" : "heart")
                                .foregroundColor(viewModel.currentStory.isLiked ? .red : .white)
                                .font(.largeTitle)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }

    @ViewBuilder
    private func avatarView(for avatar: ProfileAvatar) -> some View {
        switch avatar {
        case let .initials(initials):
            ZStack {
                Circle()
                    .foregroundStyle(.secondaryBackground)
                Text(initials)
                    .foregroundStyle(.onSecondaryBackground)
                    .font(.system(size: 14, weight: .bold))
            }
        case let .image(url):
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            } placeholder: {
                ShimmerCircleView()
            }
        }
    }
}

#Preview {
    let sampleStories = [
        StoryUser(id: "1", username: "alice", seen: false, avatar: .initials("A"), isLiked: false),
        StoryUser(id: "2", username: "bob", seen: false, avatar: .image(URL(string: "https://i.pravatar.cc/300?u=1")!), isLiked: false),
        StoryUser(id: "3", username: "carol", seen: false, avatar: .initials("C"), isLiked: false)
    ]
    let model = StoryBrowserScreenModel(
        stories: sampleStories,
        currentStory: sampleStories[0],
        storageService: StorageService(),
        closeHandler: {}
    )
    StoryBrowserScreen(viewModel: model)
}
