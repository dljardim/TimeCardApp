//
//  EmployeeImageView.swift
//  TimeCardApp
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI

struct EmployeeImageView: View {
    let photoName: String
    
    var body: some View {
        if let image = loadImage(for: photoName) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        }
    }
    
    private func loadImage(for name: String) -> UIImage? {
        if let bundleImage = UIImage(named: name) {
            return bundleImage
        } else {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                .appendingPathComponent(name)
            return UIImage(contentsOfFile: path.path)
        }
    }
}


#Preview {
//    EmployeeImageView()
}
