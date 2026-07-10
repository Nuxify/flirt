//
//  FlirtAppWidgetLiveActivity.swift
//  FlirtAppWidget
//
//  Created by Joseph Cedeno on 7/9/26.
//

import ActivityKit
import WidgetKit
import SwiftUI


let sharedDefault = UserDefaults(suiteName: "YOUR_GROUP_ID")!

struct FlirtAppWidgetAttributes: ActivityAttributes, Identifiable  {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var bookTitle: String
        var author: String
        var coverUrl: String?
        var page: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
    var id = UUID()
}

struct FlirtAppWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlirtAppWidgetAttributes.self) { context in
            // Lock screen/banner UI — compact cover + metadata (no background image or dim)
            HStack(alignment: .center, spacing: 12) {
                if let cover = context.state.coverUrl, let url = URL(string: cover) {
                    AsyncImage(url: url) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 56, height: 80)
                    .clipped()
                } else {
                    Image(systemName: "book.fill")
                        .resizable()
                        .frame(width: 40, height: 56)
                        .foregroundColor(.primary)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(context.state.bookTitle)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    Text("by \(context.state.author)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Page \(context.state.page)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 6)

                Spacer()
            }
            .padding(8)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    if let cover = context.state.coverUrl, let url = URL(string: cover) {
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 48, height: 68)
                        .clipped()
                    } else {
                        Image(systemName: "book.fill")
                            .resizable()
                            .frame(width: 36, height: 48)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment: .leading) {
                        Text(context.state.bookTitle).font(.headline)
                        Text("by \(context.state.author)").font(.subheadline)
                        Text("Page \(context.state.page)").font(.caption)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Reading: \(context.state.bookTitle) — Page \(context.state.page)")
                }
            } compactLeading: {
                Text(context.state.bookTitle.prefix(1))
            } compactTrailing: {
                Text("Pg \(context.state.page)")
            } minimal: {
                Text(context.state.bookTitle.prefix(1))
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension FlirtAppWidgetAttributes {
    fileprivate static var preview: FlirtAppWidgetAttributes {
        FlirtAppWidgetAttributes(name: "World")
    }
}

extension FlirtAppWidgetAttributes.ContentState {
    fileprivate static var sampleOne: FlirtAppWidgetAttributes.ContentState {
        FlirtAppWidgetAttributes.ContentState(bookTitle: "The Great Gatsby", author: "F. Scott Fitzgerald", coverUrl: "https://picsum.photos/seed/gatsby/200/300", page: 12)
    }

    fileprivate static var sampleTwo: FlirtAppWidgetAttributes.ContentState {
        FlirtAppWidgetAttributes.ContentState(bookTitle: "1984", author: "George Orwell", coverUrl: "https://picsum.photos/seed/1984/200/300", page: 42)
    }
}

#Preview("Notification", as: .content, using: FlirtAppWidgetAttributes.preview) {
   FlirtAppWidgetLiveActivity()
} contentStates: {
    FlirtAppWidgetAttributes.ContentState.sampleOne
    FlirtAppWidgetAttributes.ContentState.sampleTwo
}


extension FlirtAppWidgetAttributes {
  func prefixedKey(_ key: String) -> String {
    return "\(id)_\(key)"
  }
}