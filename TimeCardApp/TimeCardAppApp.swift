//
//  TimeCardAppApp.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI
import SwiftData

@main
struct TimeCardAppApp: App {
    var body: some Scene {
        WindowGroup {
            TimeCardAppMainView()
        }
        .modelContainer(for: [Employee.self, AttendanceEntry.self])
    }
}
