//
//  Extensions.swift
//  presentation
//
//  Created by Nazim Asadov on 30.08.22.
//

import Foundation
import UIKit
import Kingfisher
import domain

extension UILabel {
    func getFont(name: String){
        let poppins = UIFont(name: name, size: UIFont.labelFontSize)
        self.font = UIFontMetrics.default.scaledFont(for: poppins ?? UIFont.systemFont(ofSize: UIFont.labelFontSize))
        self.adjustsFontForContentSizeCategory = true
    }
    
    func configureLabel(text:String? = nil, textColor: UIColor? = nil, textAlignment: NSTextAlignment? ) {
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment ?? .left
    }
}

extension UIColor {
    
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }
    
    static let appSplashScreen: UIColor = dynamicColor(light: UIColor(red: 222/255, green: 53/255, blue: 47/255, alpha: 1), dark: UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0))
    
    
    static let appBackGroundColor: UIColor = dynamicColor(light: UIColor(red: 255/255, green: 1, blue: 1, alpha: 1), dark: UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0))
    
    static let eventOrange: UIColor = #colorLiteral(red: 0.9893080592, green: 0.5366089344, blue: 0.212097615, alpha: 1)
}

extension UIImage {
    
    func withInset(_ insets: UIEdgeInsets) -> UIImage? {
        let cgSize = CGSize(width: self.size.width + insets.left * self.scale + insets.right * self.scale,
                            height: self.size.height + insets.top * self.scale + insets.bottom * self.scale)
        
        UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        
        let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
        self.draw(at: origin)
        
        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
    }
}

extension UIView {
    
    func addTapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        
        tap.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
    
    func hideKeyboard() {
        self.endEditing(true)
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}

extension UIImageView {
    func downloadedPng(with tintColor: UIColor, imgUrl: URL?) {
        if let imgUrl = imgUrl {
            self.kf.setImage(with: imgUrl, placeholder: UIImage()) { (result) in
                switch result {
                case .success(let imageResult):
                    self.image = imageResult.image.withRenderingMode(.alwaysTemplate)
                    //                    self.tintColor = tintColor
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
}

public extension String {
    func dateString(from fromFormat: String, to toFormat: String) -> Self {
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat
        
        guard let date = formatter.date(from: self) else { return "" }
        formatter.dateFormat = toFormat
        
        return formatter.string(from: date)
    }
}

public extension UIViewController {
    func getHighQuality(images: [EventResponse.Image]) -> String {
        let filtered = images.filter { image in
            image.ratio == "16_9" && image.width > 300
        }
        
        for img in filtered {
            return img.url
        }
        return images.first?.url ?? ""
    }
    
    func showAlert(title: String? = nil, with message: String, preferredStyle: UIAlertController.Style = .alert, actions: [(title: String,style: UIAlertAction.Style)] = [("OK", .default)], completion: ((_ at: Int, _ type: UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for (index, action) in actions.enumerated() {
            let newAction = UIAlertAction(title: action.title, style: action.style) { (action) in
                completion?(index, action)
            }
            alert.addAction(newAction)
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

public extension UICollectionViewCell {
    func getHighQuality(images: [EventResponse.Image]) -> String {
        let filtered = images.filter { image in
            image.ratio == "16_9" && image.width > 300
        }
        
        for i in filtered {
            return i.url
        }
        return images.first?.url ?? ""
    }
}

public extension UITableViewCell {
    func getHighQuality(images: [EventResponse.Image]) -> String {
        let filtered = images.filter { image in
            image.ratio == "16_9" && image.width > 300
        }
        
        for i in filtered {
            return i.url
        }
        return images.first?.url ?? ""
    }
}
