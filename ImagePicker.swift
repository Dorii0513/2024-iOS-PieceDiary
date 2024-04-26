//
//  Image.swift
//  Piece
//
//  Created by 김예림 on 4/18/24.
//
import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: [UIImage?]
    @State var buttonActive: Bool = false

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 3
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard !results.isEmpty else { return }
//            if results.isEmpty { return }
            
//            // url 뽑아내는 코드
//            guard let result = results.first else { return }
//            result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { (url, error) in
//                if let url = url {
//                    DispatchQueue.main.async {
//                        self.parent.selectedImageURL = url
//                        print("imageURL", url)
//                    }
//                }
//            }
            
            let providers = results.map { $0.itemProvider }
            for provider in providers {
                if provider.canLoadObject(ofClass: UIImage.self) {
                    provider.loadObject(ofClass: UIImage.self) { image, _ in
                        self.parent.image.append(image as? UIImage)
                    }
                }
            }
        }
    }
}
