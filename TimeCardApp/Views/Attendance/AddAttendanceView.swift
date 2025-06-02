//
//  AddAttendanceView.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI
import SwiftData

struct AddAttendanceView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var employee: Employee
    
    @State private var date = Date()
    @State private var clockIn: Date? = nil
    @State private var clockOut: Date? = nil
    @State private var status: Status = .onTime
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("Add Attendance")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addAttendanceEntry()
                        dismiss()
                    }
                    .disabled(date > Date())
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
 
    }
   
        
    
    private func addAttendanceEntry() {
        let newEntry = AttendanceEntry(date: date, clockIn: clockIn, clockOut: clockOut, status: status)
        newEntry.employee = employee
        context.insert(newEntry)
        
        // Also update the employee’s attendance list (optional, depends on SwiftData behavior)
        employee.attendance.append(newEntry)
        
        try? context.save()
    }
    
    
}

extension Binding where Value == Date? {
    init(_ source: Binding<Date?>, _ defaultValue: Date) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { source.wrappedValue = $0 }
        )
    }
    
    func testExtension() {
        print("Binding extension active")
    }
}





#Preview {
//    AddAttendanceView()
}
