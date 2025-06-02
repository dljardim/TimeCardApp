//
//  AttendanceListView.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI
import SwiftData

struct AttendanceListView: View {
    @Environment(\.modelContext) private var context
    
    @ObservedObject var employee: Employee
    
    @State private var showAddAttendance = false
    
    var body: some View {
        List {
            ForEach(employee.attendance.sorted(by: { $0.date < $1.date })) { entry in
                NavigationLink(destination: AttendanceDetailView(attendanceEntry: entry)) {
                    VStack(alignment: .leading) {
                        Text(entry.date, style: .date)
                        if let clockIn = entry.clockIn {
                            Text("Clock In: \(clockIn, style: .time)")
                        }
                        if let clockOut = entry.clockOut {
                            Text("Clock Out: \(clockOut, style: .time)")
                        }
                        Text("Status: \(entry.status.rawValue)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: deleteAttendance)
        }
        .navigationTitle("\(employee.name) Attendance")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddAttendance = true
                } label: {
                    Label("Add Entry", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddAttendance) {
            AddAttendanceView(employee: employee)
        }
    }
    
    private func deleteAttendance(at offsets: IndexSet) {
        for index in offsets {
            let entry = employee.attendance.sorted(by: { $0.date < $1.date })[index]
            context.delete(entry)
        }
        try? context.save()
    }
}


#Preview {
//    AttendanceListView()
}
