//
//  AttendanceView.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI
import SwiftData

struct AttendanceView: View {
    @Query var employees: [Employee]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
//            Text(employee.name)
//                .font(.largeTitle)
//                .bold()
//            
//            Text("Records: \(employee.attendance.count)")
//                .foregroundColor(.gray)
//            
            // More UI to come later
            Spacer()
            Text("attendanceview")
        }
        .padding()
        .navigationTitle("Attendance")
    }
}


#Preview {
    AttendanceView()
}
