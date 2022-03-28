//
//  FirestoreMigrateApp.swift
//  FirestoreMigrate
//
//  Created by Данил Войдилов on 25.01.2022.
//

import SwiftUI
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
	
	override init() {
	}
	
	func applicationDidFinishLaunching(_ notification: Notification) {
	}
}

@main
struct FirestoreMigrateApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
