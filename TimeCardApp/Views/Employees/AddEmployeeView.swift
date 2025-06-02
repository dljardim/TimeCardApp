//
//  AddEmployeeView.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI
import SwiftData

struct AddEmployeeView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var name: String = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Info") {
                    TextField("Name", text: $name)
                    
                    HStack {
                        if let selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        
                        Button("Choose Photo") {
                            showImagePicker = true
                        }
                    }
                }
                
                Section {
                    Button("Save") {
                        saveEmployee()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationTitle("Add Employee")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
    
    private func saveEmployee() {
        var photoName: String?
        
        if let image = selectedImage {
            let id = UUID().uuidString
            let filename = "\(id).jpg"
            if let data = image.jpegData(compressionQuality: 0.8) {
                let url = getDocumentsDirectory().appendingPathComponent(filename)
                try? data.write(to: url)
                photoName = filename
            }
        }
        
        let newEmployee = Employee(name: name, photoName: photoName)
        context.insert(newEmployee)
        
        try? context.save()
        dismiss()
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
