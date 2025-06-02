//
//  EmployeeDetailView.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI
import SwiftData

struct EmployeeDetailView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var employee: Employee
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    
    init(employee: Employee) {
        self.employee = employee
        _name = State(initialValue: employee.name)
        
        if let photoName = employee.photoName {
            if let bundleImage = UIImage(named: photoName) {
                _selectedImage = State(initialValue: bundleImage)
            } else {
                let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(photoName)
                _selectedImage = State(initialValue: UIImage(contentsOfFile: path.path))
            }
        } else {
            _selectedImage = State(initialValue: nil)
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Employee Name", text: $name)
            }
            
            Section {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .foregroundColor(.gray)
                }
                Button("Change Photo") {
                    showImagePicker = true
                }
            }
            
            Section {
                Button("Save Changes") {
                    saveChanges()
                }
            }
        }
        .navigationTitle("Edit Employee")
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
    
    private func saveChanges() {
        employee.name = name
        
        // Save image to documents directory if a new image was selected
        if let selectedImage {
            if let data = selectedImage.jpegData(compressionQuality: 0.8) {
                let filename = employee.id.uuidString + ".jpg"
                let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
                try? data.write(to: url)
                employee.photoName = filename
            }
        }
        
        do {
            try context.save()
            dismiss()
        } catch {
            print("Failed to save employee: \(error)")
        }
    }
}
