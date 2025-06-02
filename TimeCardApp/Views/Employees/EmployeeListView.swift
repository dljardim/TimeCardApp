//
//  EmployeeListView.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI
import SwiftData

struct EmployeeListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Employee.name) private var employees: [Employee]
    
    @State private var showAddSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(employees) { employee in
                    NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                        HStack {
                            if let photoName = employee.photoName {
                                EmployeeImageView(photoName: photoName)
                            }
                            Text(employee.name)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteEmployee)
            }
            .sheet(isPresented: $showAddSheet) {
                AddEmployeeView()
            }
            .navigationTitle("Employees")
            .toolbar {
                SwiftUI.ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Label("Add Employee", systemImage: "plus")
                    }
                }
            }
        }

    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private func deleteEmployee(at offsets: IndexSet) {
        for index in offsets {
            let employee = employees[index]
            context.delete(employee)
        }
        try? context.save()
    }
    
    func loadImage(for photoName: String) -> UIImage? {
        if let bundleImage = UIImage(named: photoName) {
            return bundleImage
        } else {
            let path = getDocumentsDirectory().appendingPathComponent(photoName)
            return UIImage(contentsOfFile: path.path)
        }
    }

}




