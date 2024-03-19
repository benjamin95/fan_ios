//
//  Logged.swift
//  fanv3
//
//  Created by Benjamin Truillet on 26/12/2023.
//

import SwiftUI
import PhotosUI

struct Logged: View {
    
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    
    func sendImageToAPI(clientId:Int) {
        
       
        
        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.1) else {
                print("Failed to convert image to data")
                return
            }
            
            // Créez votre URL d'API ici
        guard let url = URL(string: "\(getAPiUrl())images/") else {
            
            print("URL invalide")
            return
        }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(JWT.shared.getAccessToken() ?? "")", forHTTPHeaderField: "Authorization")
            
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let body = NSMutableData()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"client\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(clientId )\r\n".data(using: .utf8)!)
            
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"fichier\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            
            // Convertir la chaîne en données binaires
            if let stringData = "--\(boundary)\r\nContent-Disposition: form-data; name=\"fichier\"; filename=\"image.jpg\"\r\nContent-Type: image/jpeg\r\n\r\n".data(using: .utf8) {
                body.append(stringData)
            } else {
                print("Failed to convert string to data")
                return
            }
            
            // Ajoutez les données binaires de l'image
            body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
            
            // Ajoutez la clôture de la requête multipart
            if let stringData = "--\(boundary)--\r\n".data(using: .utf8) {
                body.append(stringData)
            } else {
                print("Failed to convert string to data")
                return
            }
            
            request.httpBody = body as Data
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Gérer la réponse de l'API
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    // Traiter la réponse de l'API (si nécessaire)
                    print("Response: \(String(data: data, encoding: .utf8) ?? "")")
                }
            }.resume()
        }
    
    
    
    
    var body: some View {
        VStack {
                    if let selectedImage{
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button("Importer Bon Intervention") {
                        self.showCamera.toggle()
                    }.buttonStyle(.bordered)
                    .fullScreenCover(isPresented: self.$showCamera) {
                        accessCameraView(selectedImage: self.$selectedImage)
                    }
            
                }
    }
}
struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

#Preview {
    Logged()
}
