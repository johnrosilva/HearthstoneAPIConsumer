//
//  ImageHelper.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 31/05/23.
//

import UIKit

class ImageHelper {
    static let `default` = ImageHelper()

    func getImage(_ url: String!, forSize size: CGSize?) -> UIImage? {
        return nil
    }

    func getImage(_ url: String!, forSize size: CGSize?, success: @escaping (_ image: UIImage?) -> Void) {
        UIImage.from(url, sizeOfResize: size) { image in
            DispatchQueue.main.async {
                success(image)
            }
        }
    }
}

