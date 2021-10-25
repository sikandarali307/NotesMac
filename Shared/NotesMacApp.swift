//
//  NotesMacApp.swift
//  Shared
//
//  Created by Mac on 25/10/2021.
//

import SwiftUI

@main
struct NotesMacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        //this app is for macos 11 12 and ios 14 15
        /// using xcode 13
        /// hidding title bar
        #if os(macOS)
        .windowStyle(HiddenTitleBarWindowStyle())
        #endif
    }
}
