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
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
    var id = UUID()
}

struct FlirtAppWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlirtAppWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
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
    fileprivate static var smiley: FlirtAppWidgetAttributes.ContentState {
        FlirtAppWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: FlirtAppWidgetAttributes.ContentState {
         FlirtAppWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: FlirtAppWidgetAttributes.preview) {
   FlirtAppWidgetLiveActivity()
} contentStates: {
    FlirtAppWidgetAttributes.ContentState.smiley
    FlirtAppWidgetAttributes.ContentState.starEyes
}


extension FlirtAppWidgetAttributes {
  func prefixedKey(_ key: String) -> String {
    return "\(id)_\(key)"
  }
}