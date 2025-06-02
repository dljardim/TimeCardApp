//
//  AttendanceEntry.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import Foundation
import SwiftData

@Model
class AttendanceEntry:ObservableObject {
    var id: UUID = UUID()
    var date: Date
    var clockIn: Date?
    var clockOut: Date?
    var status: Status
    
    // Relationship back to employee (optional)
    @Relationship(inverse: \Employee.attendance) var employee: Employee?
    
    init(date: Date = Date(), clockIn: Date? = nil, clockOut: Date? = nil, status: Status = .onTime) {
        self.date = date
        self.clockIn = clockIn
        self.clockOut = clockOut
        self.status = status
    }
}

