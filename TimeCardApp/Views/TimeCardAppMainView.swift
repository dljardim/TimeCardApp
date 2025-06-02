//
//  TimeCardAppMainView.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI

struct TimeCardAppMainView: View {
    var body: some View {
        TabView {
            DailyActivityView()
                .tabItem{
                    Label("Daily", systemImage: "clock")
                }
            
            EmployeeListView()
                .tabItem{
                    Label("Employees", systemImage: "person.3")
                }
            
            AttendanceView()
                .tabItem{
                    Label("Attendance", systemImage: "calendar")
                }
            
        }
        
    }
}

#Preview {
    TimeCardAppMainView()
}
