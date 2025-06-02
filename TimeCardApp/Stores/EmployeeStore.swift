//
//  EmployeeStore.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import Foundation

class EmployeeStore: ObservableObject {
    @Published var employees: [Employee] = [
        Employee(id: UUID(), name: "Alice Johnson", photo: nil, attendance: []),
        Employee(id: UUID(), name: "Alice Johnson", photo: nil, attendance: [])
    ]
}
