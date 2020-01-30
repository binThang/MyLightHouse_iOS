//
//  Helpers.swift
//  LeanOnMe
//
//  Created by Justin Ji on 18/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIView {
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    
}
    
public func notoSansUIRegular(_ size: CGFloat) -> UIFont  {
    return UIFont(name: "NotoSansUI", size: size)!
}

public func notoSansUIBold(_ size: CGFloat) -> UIFont  {
    return UIFont(name: "NotoSansUI-Bold", size: size)!
}

public func komaconFont(_ size: CGFloat) -> UIFont  {
    return UIFont(name: "komacon", size: size)!
}

public func yacheFont(_ size: CGFloat) -> UIFont  {
    print("--------- Available Font names ----------")
    for name in UIFont.familyNames {
        print(name)
        print(UIFont.fontNames(forFamilyName: name))
    }
    return UIFont(name: "Yanolja Yache", size: size)!
}

public func showAlert(withTitle title: String, withMessage message: String, withActionTitle actionTitle: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
    alert.addAction(action)
    return alert
}




public func generateRandomDigits(_ digitNumber: Int) -> String {
    var number = ""
    for i in 0..<digitNumber {
        var randomNumber = arc4random_uniform(10)
        while randomNumber == 0 && i == 0 {
            randomNumber = arc4random_uniform(10)
        }
        number += "\(randomNumber)"
    }
    return number
}


public func setupNavigationBar(navigationController: UINavigationController, navigationItem: UINavigationItem,  titile: String) {
    
    navigationController.navigationItem.title = titile
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "\(titile)", style: .plain, target: nil, action: nil)
    
    navigationController.interactivePopGestureRecognizer?.isEnabled = true
    navigationController.navigationBar.isHidden = false

    let backButton = UIBarButtonItem()
    backButton.title = titile
    navigationController.navigationBar.topItem?.backBarButtonItem = backButton
    navigationController.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
    navigationController.navigationBar.layer.shadowOpacity = 0.2
    navigationController.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
    navigationController.navigationBar.layer.shadowRadius = 5
    navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController.navigationBar.shadowImage = UIImage()
    navigationController.navigationBar.isTranslucent = false
    UIApplication.shared.statusBarStyle = .default
}

func setupBackButtonTitle(withNavigationController navigationController: UINavigationController, withTitle title: String) {
    let backButton = UIBarButtonItem()
    backButton.title = title
    navigationController.navigationBar.topItem?.backBarButtonItem = backButton
}

public func estimateFrameForText(text: String) -> CGRect {
    let size = CGSize(width: 200, height: 1000)
    let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], context: nil)

}

extension UIImage {
    static func animatedImage(data: Data) -> UIImage? {
        guard let source: CGImageSource = CGImageSourceCreateWithData(data as CFData, nil), CGImageSourceGetCount(source) > 1 else {
            return UIImage(data: data)
        }
        
        // Collect key frames and durations
        var frames: [(image: CGImage, delay: TimeInterval)] = []
        for i: Int in 0 ..< CGImageSourceGetCount(source) {
            guard let image = CGImageSourceCreateImageAtIndex(source, i, nil), let frame = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any], let gif = frame["{GIF}"] as? [String: Any] else {
                continue
            }
            
            // Mimic WebKit approach to determine frame delay
            if let delay = gif["UnclampedDelayTime"] as? TimeInterval, delay > 0.0 {
                frames.append((image, delay)) // Prefer "unclamped" delay time
            } else if let delay = gif["DelayTime"] as? TimeInterval, delay > 0.0 {
                frames.append((image, delay))
            } else {
                frames.append((image, 0.1)) // WebKit default
            }
        }
        
        // Convert key frames to animated image
        var images: [UIImage] = []
        var duration: TimeInterval = 0.0
        for frame in frames {
            let image = UIImage(cgImage: frame.image)
            for _ in 0 ..< Int(frame.delay * 100.0) {
                images.append(image) // Add fill frames
            }
            duration += frame.delay
        }
        return UIImage.animatedImage(with: images, duration: duration)
    }
}

public func showActionSheetForImageDownload(urlString: String, completion: @escaping(String, UIImage) -> Void) {
    
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            let image = UIImage.animatedImage(data: data!)
            
            DispatchQueue.main.async {
                //사진첩으로 다운로드
                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                completion("success", image!)
            }
        }).resume()
}

public func setNavitationItemTitle(navigationController: UINavigationController, navigationItem: UINavigationItem, title: String) {
    navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont(name: "Yanolja Yache", size: 18)!]
    navigationItem.title = title
}

public func displayShareSheet(withContent content: UIImage) -> UIActivityViewController {
    let acitvityViewController = UIActivityViewController(activityItems: [content as UIImage], applicationActivities: nil)
    return acitvityViewController
}

func isValidEmailAddress(emailAddressString: String) -> Bool {
    var returnValue = true
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    do {
        let regex = try NSRegularExpression(pattern: emailRegEx)
        let nsString = emailAddressString as NSString
        let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
        
        if results.count == 0
        {
            returnValue = false
        }
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }
    
    return  returnValue
}


public func frameForNormalText(text: String, textSize: CGFloat) -> CGRect {
    let size = CGSize(width: 200, height: 1000)
    let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: notoSansUIRegular(textSize)], context: nil)
}

public func frameForBoldText(text: String, textSize: CGFloat) -> CGRect {
    let size = CGSize(width: 200, height: 1000)
    let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: notoSansUIBold(textSize)], context: nil)
}

















