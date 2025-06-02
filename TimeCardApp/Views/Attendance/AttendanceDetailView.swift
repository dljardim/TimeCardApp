//
//  AttendanceDetailView.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI
import SwiftData

struct AttendanceDetailView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var attendanceEntry: AttendanceEntry
    
    @State private var date: Date
    @State private var clockIn: Date?
    @State private var clockOut: Date?
    @State private var status: Status
    
    @Environment(\.dismiss) private var dismiss
    
    init(attendanceEntry: AttendanceEntry) {
        self.attendanceEntry = attendanceEntry
        _date = State(initialValue: attendanceEntry.date)
        _clockIn = State(initialValue: attendanceEntry.clockIn)
        _clockOut = State(initialValue: attendanceEntry.clockOut)
        _status = State(initialValue: attendanceEntry.status)
    }
    
    var body: some View {
        Form {
            DatePicker("Date", selection: $date, displayedComponents: .date)
            DatePicker("Clock In", selection: Binding<Date>(
                get: { clockIn ?? Date() },
                set: { clockIn = $0 }
            ), displayedComponents: .hourAndMinute)
            .labelsHidden()
            DatePicker("Clock Out", selection: Binding<Date>(
                get: { clockOut ?? Date() },
                set: { clockOut = $0 }
            ), displayedComponents: .hourAndMinute)
            .labelsHidden()
            
            
            Picker("Status", selection: $status) {
                ForEach(Status.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
        }
        .navigationTitle("Edit Attendance")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveChanges()
                    dismiss()
                }
            }
        }
    }
    
    private func saveChanges() {
        attendanceEntry.date = date
        attendanceEntry.clockIn = clockIn
        attendanceEntry.clockOut = clockOut
        attendanceEntry.status = status
        
        try? context.save()
    }
}


#Preview {
//    AttendanceDetailView()
}
