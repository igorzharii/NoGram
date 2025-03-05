//
//  StoriesModels.swift
//  NoGram
//

import Foundation

struct StoryUser: Identifiable, Equatable {
    static func == (lhs: StoryUser, rhs: StoryUser) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String
    var username: String
    var seen: Bool
    var avatar: ProfileAvatar
    var isLiked: Bool
}

enum ProfileAvatar: Equatable {
    case initials(String)
    case image(URL)
}
