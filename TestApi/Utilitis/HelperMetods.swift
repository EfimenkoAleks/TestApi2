//
//  HelperMetods.swift
//  TestApi
//
//  Created by mac on 28.02.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import Alamofire

class HelperMetods {
 
    static let shared = HelperMetods()

    func urlWithSearchText(searchText: String) -> String {
        let escapedSearchText = searchText.replacingOccurrences(of: " ", with: "")
        return escapedSearchText
    }
    
    func applyFilters(image: UIImage, filterEffectName: String, filterEffectValue: Any?, filterEffectValueName: String?) -> UIImage? {
        
        guard let cgImage = image.cgImage ,
            let openGLContect = EAGLContext(api: .openGLES3) else {
                return nil
        }
        let context = CIContext(eaglContext: openGLContect)
        let ciImage = CIImage(cgImage: cgImage)
        let filter = CIFilter(name: filterEffectName)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        if let filterEffectValue = filterEffectValue ,
            let filterEffectValueName = filterEffectValueName {
            filter?.setValue(filterEffectValue, forKey: filterEffectValueName)
        }
        var filtredImage: UIImage?
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage,
            let cgiImageRezult = context.createCGImage(output, from: output.extent) {
            filtredImage = UIImage(cgImage: cgiImageRezult)
        }
        
        return filtredImage
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

extension UIImageView {
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, pading: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: pading.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: pading.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: pading.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: pading.right).isActive = true
        }
    }
    
}

