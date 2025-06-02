//
//  Enums.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import Foundation

enum Status: String, CaseIterable, Codable {
    case onTime = "On Time"
    case late = "Late"
    case absent = "Absent"
}
