//
//  Employee.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Employee: ObservableObject {
    @Attribute(.unique) var id: UUID
    var name: String
    var photoName: String? // Store asset name or URL
    @Relationship(deleteRule: .cascade) var attendance: [AttendanceEntry]
    
    init(id: UUID = UUID(), name: String, photoName: String? = nil, attendance: [AttendanceEntry] = []) {
        self.id = id
        self.name = name
        self.photoName = photoName
        self.attendance = attendance
    }
}
