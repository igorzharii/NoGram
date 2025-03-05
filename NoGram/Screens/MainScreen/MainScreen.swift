//
//  MainScreen.swift
//  NoGram
//


import SwiftUI

struct MainScreen: View {
    @StateObject var viewModel = MainScreenModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 16) {
                Text("No Gram. Just Imagine.")
                    .padding(.horizontal, 16)
                    .font(.title)
                    .bold()
                StoriesList(stories: viewModel.stories) { story in
                    viewModel.storyTapped(story)
                } onLastAppeared: {
                    viewModel.loadMore()
                }
                Divider()

                dummyContent
                    .padding(.horizontal, 16)
            }
            .padding(.top, 54)
        }
        .frame(maxWidth: .infinity)
        .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
        .fullScreenCover(item: $viewModel.browserModel) { browserModel in
            StoryBrowserScreen(viewModel: browserModel)
        }
    }

    var dummyContent: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.onPrimaryBackground)
                .frame(height: 1000)
            Text("Dummy Content")
                .foregroundStyle(.primaryBackground)
        }
    }
}

#Preview {
    MainScreen()
}
