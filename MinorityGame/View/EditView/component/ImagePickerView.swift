//
//  ImagePickerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/28.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {

    @Binding var show:Bool
    @Binding var image:Data?
    var sourceType:UIImagePickerController.SourceType

    func makeCoordinator() -> ImagePickerView.Coodinator {

        return ImagePickerView.Coordinator(parent: self)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {

            let controller = UIImagePickerController()
            controller.sourceType = sourceType
            controller.delegate = context.coordinator

            return controller
        }

        func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        }

        class Coodinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

            var parent : ImagePickerView

            init(parent : ImagePickerView){
                self.parent = parent
            }

            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                self.parent.show.toggle()
            }
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

                        let image = info[.originalImage] as! UIImage
                        let data = image.pngData()
                        self.parent.image = data!
                        self.parent.show.toggle()
                    }
                }
}
