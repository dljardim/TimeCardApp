//
//  EmployeeListView.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI

struct EmployeeListView: View {
    var body: some View {
        NavigationStack{
            Text("Employee List")
                .navigationTitle("Employees")
        }
        
    }
}

#Preview {
    EmployeeListView()
}
