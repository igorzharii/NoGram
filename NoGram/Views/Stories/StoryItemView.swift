//
//  StoryItemView.swift
//  NoGram
//

import SwiftUI

struct StoryUserView: View {
    let seen: Bool
    let avatar: ProfileAvatar
    let username: String
    let onTap: () -> Void

    init(seen: Bool, avatar: ProfileAvatar, username: String, onTap: @escaping () -> Void = {}) {
        self.seen = seen
        self.avatar = avatar
        self.username = username
        self.onTap = onTap
    }

    var body: some View {
        Button(action: onTap) {
            VStack {
                profileImage(avatar)
                    .padding(4)
                    .overlay { ring }
                    .frame(height: 80)
                Text(username)
                    .foregroundStyle(.onPrimaryBackground)
                    .font(.system(size: 11, weight: .regular))
                    .lineLimit(1)
                    .truncationMode(.middle)
            }
            .frame(width: 80)
        }
    }

    var ring: some View {
        Circle()
            .stroke(ringStyle, lineWidth: 4)
    }

    var ringStyle: some ShapeStyle {
        if seen {
            AnyShapeStyle(Color.gray)
        } else {
            AnyShapeStyle(
                LinearGradient(
                    colors: [.unseenGradient1, .unseenGradient2],
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )
            )
        }
    }

    @ViewBuilder
    func profileImage(_ avatar: ProfileAvatar) -> some View {
        switch avatar {
        case let .initials(initials):
            ZStack {
                Circle()
                    .foregroundStyle(.secondaryBackground)
                Text(initials)
                    .foregroundStyle(.onSecondaryBackground)
                    .font(.system(size: 32, weight: .bold))
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

#Preview("Initials") {
    StoryUserView(seen: false, avatar: .initials("DJ"), username: "fbi_not_official")
}

#Preview("Initials (Seen)") {
    StoryUserView(seen: true, avatar: .initials("DJ"), username: "username")
}

#Preview("Image") {
    StoryUserView(seen: false, avatar: .image(URL(string: "https://i.pravatar.cc/300?u=1")!), username: "username")
}

#Preview("Image (Seen)") {
    StoryUserView(seen: true, avatar: .image(URL(string: "https://i.pravatar.cc/300?u=1")!), username: "username")
}
