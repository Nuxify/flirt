//
//  FlirtAppWidgetLiveActivity.swift
//  FlirtAppWidget
//
//  Created by Joseph Cedeno on 7/9/26.
//

import ActivityKit
import WidgetKit
import SwiftUI


let sharedDefault = UserDefaults(suiteName: "group.com.nuxify.flirttemplate")!

// Use the same attributes type name as the plugin's LiveActivitiesAppAttributes
// so ActivityKit can associate activities created by the plugin with this widget.
struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public struct ContentState: Codable, Hashable {
        // The plugin stores the appGroupId in the content state.
        var appGroupId: String
        // Optional preview fields for Xcode previews
        var bookTitle: String?
        var author: String?
        var coverUrl: String?
        var page: Int?
    }

    // Fixed non-changing properties about your activity go here!
    var id = UUID()
}

struct FlirtAppWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            // Lock screen/banner UI — read details from shared App Group UserDefaults
            let prefix = context.attributes.id.uuidString
            let bookTitle = sharedDefault.string(forKey: "\(prefix)_bookTitle") ?? "Untitled"
            let author = sharedDefault.string(forKey: "\(prefix)_author") ?? "Unknown"
            let pageValue = sharedDefault.object(forKey: "\(prefix)_page")
            let page: Int = {
                if let p = pageValue as? Int { return p }
                if let s = pageValue as? String, let pi = Int(s) { return pi }
                return 1
            }()
            let coverUrl = sharedDefault.string(forKey: "\(prefix)_coverUrl")

            HStack(alignment: .center, spacing: 12) {
                // Use a static book image (SF Symbol) for Live Activity
                Image(systemName: "book.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 50)
                    .padding(.leading, 4)
                    .clipped()
                    .foregroundColor(.primary)
                    

                VStack(alignment: .leading, spacing: 4) {
                    Text(bookTitle)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    Text("by \(author)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Page \(page)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 6)

                Spacer()
            }
            .padding(8)

        } dynamicIsland: { context in
            // Compute the same shared values here — dynamicIsland closure has its own scope
            let prefix = context.attributes.id.uuidString
            let bookTitle = sharedDefault.string(forKey: "\(prefix)_bookTitle") ?? "Untitled"
            let author = sharedDefault.string(forKey: "\(prefix)_author") ?? "Unknown"
            let pageValue = sharedDefault.object(forKey: "\(prefix)_page")
            let page: Int = {
                if let p = pageValue as? Int { return p }
                if let s = pageValue as? String, let pi = Int(s) { return pi }
                return 1
            }()
            let coverUrl = sharedDefault.string(forKey: "\(prefix)_coverUrl")

            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {

                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 56)
                        .padding(.leading, 4)
                        .clipped()
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment: .leading) {
                        Text(bookTitle).font(.headline)
                        Text("by \(author)").font(.subheadline)
                        Text("Page \(page)").font(.caption)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Reading: \(bookTitle) — Page \(page)")
                }
            } compactLeading: {
                Text(String(bookTitle.prefix(1)))
            } compactTrailing: {
                Text("Pg \(page)")
            } minimal: {
                Text(String(bookTitle.prefix(1)))
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LiveActivitiesAppAttributes {
    fileprivate static var preview: LiveActivitiesAppAttributes {
        LiveActivitiesAppAttributes()
    }
}

extension LiveActivitiesAppAttributes.ContentState {
    fileprivate static var sampleOne: LiveActivitiesAppAttributes.ContentState {
        LiveActivitiesAppAttributes.ContentState(appGroupId: "group.com.nuxify.flirttemplate", bookTitle: "The Great Gatsby", author: "F. Scott Fitzgerald", coverUrl: "https://picsum.photos/seed/gatsby/200/300", page: 12)
    }

    fileprivate static var sampleTwo: LiveActivitiesAppAttributes.ContentState {
        LiveActivitiesAppAttributes.ContentState(appGroupId: "group.com.nuxify.flirttemplate", bookTitle: "1984", author: "George Orwell", coverUrl: "https://picsum.photos/seed/1984/200/300", page: 42)
    }
}

#Preview("Notification", as: .content, using: LiveActivitiesAppAttributes.preview) {
   FlirtAppWidgetLiveActivity()
} contentStates: {
    LiveActivitiesAppAttributes.ContentState.sampleOne
    LiveActivitiesAppAttributes.ContentState.sampleTwo
}


extension LiveActivitiesAppAttributes {
  func prefixedKey(_ key: String) -> String {
    return "\(id)_\(key)"
  }
}