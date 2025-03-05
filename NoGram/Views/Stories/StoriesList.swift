//
//  StoriesList.swift
//  NoGram
//

import SwiftUI

struct StoriesList: View {
    let stories: [StoryUser]
    let onTap: (StoryUser) -> Void
    // this is for pagination purposes
    let onLastAppeared: () -> Void

    init(
        stories: [StoryUser],
        onTap: @escaping (StoryUser) -> Void = { _ in },
        onLastAppeared: @escaping () -> Void = {}
    ) {
        self.stories = stories
        self.onTap = onTap
        self.onLastAppeared = onLastAppeared
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(stories) { story in
                    StoryUserView(
                        seen: story.seen,
                        avatar: story.avatar,
                        username: story.username,
                        onTap: {
                            onTap(story)
                        }
                    )
                }
                // Dummy view that triggers pagination when it appears.
                Color.clear
                    .frame(width: 0.1, height: 0.1)
                    .onAppear {
                        onLastAppeared()
                    }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    StoriesList(
        stories: [
            StoryUser(id: "1", username: "foobar", seen: false, avatar: .initials("FB"), isLiked: false),
            StoryUser(id: "2", username: "username", seen: false, avatar: .initials("DJ"), isLiked: false),
            StoryUser(id: "3", username: "noname", seen: false, avatar: .initials("NO"), isLiked: false),
            StoryUser(id: "4", username: "tst", seen: false, avatar: .initials("BB"), isLiked: false),
            StoryUser(id: "5", username: "uname", seen: true, avatar: .initials("DJ"), isLiked: false),
            StoryUser(id: "6", username: "uname", seen: false, avatar: .initials("TS"), isLiked: false),
            StoryUser(id: "7", username: "fbi_official", seen: false, avatar: .initials("FO"), isLiked: false),
            StoryUser(id: "8", username: "uname", seen: false, avatar: .initials("NM"), isLiked: false),
            StoryUser(id: "9", username: "uname", seen: true, avatar: .initials("DJ"), isLiked: false),
        ],
        onLastAppeared: { print("page") })
}
