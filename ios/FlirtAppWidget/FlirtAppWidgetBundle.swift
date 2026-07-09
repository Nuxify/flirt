//
//  FlirtAppWidgetBundle.swift
//  FlirtAppWidget
//
//  Created by Joseph Cedeno on 7/9/26.
//

import WidgetKit
import SwiftUI

@main
struct FlirtAppWidgetBundle: WidgetBundle {
    var body: some Widget {
        FlirtAppWidget()
        FlirtAppWidgetLiveActivity()
    }
}
