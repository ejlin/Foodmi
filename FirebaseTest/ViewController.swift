//
//  ViewController.swift
//  FirebaseTest
//
//  Created by Eric Lin on 8/16/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import QuartzCore
import UIKit
import FirebaseAuth
import MapKit
import GooglePlaces
import CoreLocation
import MaterialComponents.MaterialActivityIndicator

class ViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate{

//    var placesClient: GMSPlacesClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hideKeyboardWhenTappedAround()
    }
}

class SignUpUIButton: UIButton {
    var firstName: UITextField?
    var lastName: UITextField?
    var email: UITextField?
    var password: UITextField?
    var confirmPassword: UITextField?
}

class LoginUIButton: UIButton {
    var email: UITextField?
    var password: UITextField?
}

class DisplayNameUIButton: UIButton {
    var firstName: UITextField?
    var lastName: UITextField?
}

class AuthenticateRequiredUIButton:UIButton {
    var email: UITextField?
    var password: UITextField?
    var confirmPassword: UITextField?
}

class RestaurantUIButton:UIButton {
    var resId: String?
}

class MapUIButton:UIButton {
    var name: String?
    var latitude: String?
    var longitude: String?
}

extension UIColor {
    convenience init(rgb: Int) {
        self.init(red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
                  green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
                  blue: CGFloat((rgb & 0xFF)) / 255.0, alpha: 1.0)
    }
}

extension UIImage {
    var circle: UIImage {
        let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
}  

extension UITextField {

    func setBottomLine(borderColor: UIColor) {

        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear

        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)

        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {

    struct Holder {
        static var myActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    }

    func showActivityIndicator(){
        Holder.myActivityIndicator.color = UIViewController.SCRN_MAIN_COLOR
        Holder.myActivityIndicator.center = CGPoint(x: UIViewController.SCRN_WIDTH*0.5, y: UIViewController.SCRN_HEIGHT*0.5)
        Holder.myActivityIndicator.hidesWhenStopped = true
        Holder.myActivityIndicator.startAnimating()
        Holder.myActivityIndicator.backgroundColor = UIViewController.SCRN_GREY_LIGHT
        Holder.myActivityIndicator.layer.cornerRadius = 5
        self.isUserInteractionEnabled = false
        Holder.myActivityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.addSubview(Holder.myActivityIndicator)
    }

    func hideActivityIndicator() {
        self.isUserInteractionEnabled = true
        Holder.myActivityIndicator.stopAnimating()
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}

extension UIViewController{

    /* Define our Macros for View Controllers */
    static let SCRN_WIDTH = UIScreen.main.bounds.size.width
    static let SCRN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCRN_FONT_BOLD = "DINAlternate-Bold" //"AppleSDGothicNeo-Bold"
    static let SCRN_FONT_MEDIUM = "DINAlternate-Medium"  //"AppleSDGothicNeo-Medium"
    static let SCRN_MAIN_COLOR = UIColor(rgb: 0xff0000) //0x3AAFA9)
    static let SCRN_MAIN_COLOR_DARK = UIColor(rgb: 0xA70000) //0x2B7A78)
    static let SCRN_MAIN_COLOR_LIGHT = UIColor(rgb: 0xff5252)//0xD3D3D3) //0xDEF2F1)
    static let SCRN_GREY = UIColor(rgb: 0x696969)
    static let SCRN_GREY_LIGHT = UIColor(rgb: 0xdcdee2)
    static let SCRN_GREY_LIGHT_LIGHT = UIColor(rgb: 0xe9ebee)
    static let SCRN_BLACK = UIColor(rgb: 0x000000)
    static let SCRN_WHITE = UIColor(rgb: 0xFFFFFF)
    static let SCRN_INVALID_INPUT_RED = UIColor(rgb: 0xE75050)
    static let INVALID_IDX = -1
    
    static let googleAPIKey = "AIzaSyDakn3wICSQZRJcVnoqqYOB6r1T1uABank"
    static let ZOMATO_KEY = "68943b6fd24be6f3409756e1a22d80d7"
    
    static let WELCOME_VC = "welcomeViewController"
    static let GET_STARTED_VC = "getStartedViewController"
    static let REGISTER_VC = "registerViewController"
    static let LOGIN_VC = "loginViewController"
    static let SIGN_UP_VC = "signUpViewController"
    static let MAIN_PAGE_VC = "mainPageViewController"
    static let SETTINGS_VC = "settingsViewController"
    static let RESTAURANT_INFO_VC = "restaurantInfoViewController"
    static let PROFILE_VC = "profileViewController"
    
    /* Function Name: createUILabel()
     * Return Type: None
     * Parameters: This function takes in 7 parameters
     *             backgroundColor: UIColor - This is the color to make the background of this label
     *             textColor: UIColor - This is the color of the text to display in the UILabel
     *             labelText: String - This is the text to display in the UILabel
     *             fontSize: CGFloat - This is the size of the text in the UILabel
     *             fontName: String - This is the font family of the text in the UILabel
     *             cornerRadius: CGFloat - This is how far to round the corners of the label
     *             frame: CGRect - This specifies the x & y position of the UILabel as well as the width and height
     * Description: This function will create a UILabel according to the specified parameters and then add
     * it to the current viewController's view. Default settings for this UILabel include:
     *             .textAlignment - .center by default
     *             .layer.masksToBounds - true by default
     *             .numberOfLines - 0 by default
     */

    func createUILabel(backgroundColor: UIColor, textColor: UIColor, labelText: String,
                       fontSize: CGFloat, fontName: String, cornerRadius: CGFloat,
                       frame: CGRect) -> UILabel{
        let myLabel = UILabel(frame: frame)
        myLabel.text = labelText
        myLabel.textColor = textColor
        myLabel.backgroundColor = backgroundColor
        myLabel.textAlignment = .center
        myLabel.font = UIFont(name: fontName, size: fontSize)
        myLabel.layer.cornerRadius = cornerRadius
        myLabel.layer.masksToBounds = true
        myLabel.numberOfLines = 0
        self.view.addSubview(myLabel)
        return myLabel
    }

    /* Function Name: createUIImage()
     * Return Type: None
     * Parameters: This function takes in 2 parameters
     *             imageName: String - This is the name of our image file
     *             frame: CGRect - This specifies the x & y position of the UIImage as well as the width and height
     * Description: This function will create a UIImage according to the specified parameters and then add
     * it to the current viewController's view.
     */

    func createUIImage(imageName: String, imageFrame: CGRect) -> UIImageView{
        let myImage = UIImage(named: imageName)
        let myImageView = UIImageView(image: myImage!)
        myImageView.frame = imageFrame
        self.view.addSubview(myImageView)
        return myImageView
    }

    /* Function Name: createUITextField()
     * Return Type: None
     * Parameters: This function takes in 5 parameters
     *             placeholder: String - This is the text to display when user input is empty
     *             textColor: UIColor - This is the color of the text to display in the UITextField
     *             bottomLineColor: String - This is the color of the bottom border in the UITextField
     *             isSecureTextEntry: Bool - This is whether to hide our input (for password inputs)
     *             frame: CGRect - This specifies the x & y position of the UITextField as well as the width and height
     * Description: This function will create a UITextField according to the specified parameters and then add
     * it to the current viewController's view.
     */

    func createUITextField(placeholder: String, textColor: UIColor, bottomLineColor: UIColor, isSecureTextEntry: Bool, frame: CGRect) -> UITextField{
        let myTextField = UITextField(frame: frame)
        myTextField.placeholder = placeholder
        myTextField.textColor = textColor
        myTextField.setBottomLine(borderColor: bottomLineColor)
        myTextField.isSecureTextEntry = isSecureTextEntry
        self.view.addSubview(myTextField)
        return myTextField
    }

    func createUIButton(textColor: UIColor, titleText: String, fontName: String, fontSize: CGFloat, alignment: UIControlContentHorizontalAlignment, backgroundColor: UIColor, cornerRadius: CGFloat, tag: Int, frame: CGRect) -> UIButton {
        let myButton = UIButton(frame: frame)
        myButton.contentHorizontalAlignment = alignment
        myButton.setTitleColor(textColor, for: .normal)
        myButton.titleLabel?.font = UIFont(name: fontName, size: fontSize)
        myButton.backgroundColor = backgroundColor
        myButton.layer.cornerRadius = cornerRadius
        myButton.layer.masksToBounds = true
        myButton.setTitle(titleText, for: .normal)
        myButton.tag = tag
        self.view.addSubview(myButton)
        return myButton
    }

    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func createNavigationBar(withIdentifier identifier: String) {
        
        let navigationBarLabelBorder = UILabel(frame: CGRect(x: 0, y: UIViewController.SCRN_HEIGHT - 50, width: UIViewController.SCRN_WIDTH, height: 1))
        navigationBarLabelBorder.backgroundColor = UIViewController.SCRN_GREY_LIGHT
        
        let navigationBarLabel = UILabel(frame: CGRect(x: 0, y: UIViewController.SCRN_HEIGHT - 49, width: UIViewController.SCRN_WIDTH, height: 49))
        navigationBarLabel.backgroundColor = UIViewController.SCRN_WHITE
        
        let navigationBarHome = UIImage(named: "home_grey")
        let navigationBarHomeButton = UIButton(frame: CGRect(x: (UIViewController.SCRN_WIDTH - 160) / 5, y: UIViewController.SCRN_HEIGHT - 40, width: 30, height: 30))
        navigationBarHomeButton.setImage(navigationBarHome, for: UIControlState.normal)
        navigationBarHomeButton.tag = 1
        navigationBarHomeButton.addTarget(self, action: #selector(self.navigatePages), for: .touchUpInside)
        
        
        let navigationBarProfile = UIImage(named: "profile_bar_grey")
        let navigationBarProfileButton = UIButton(frame: CGRect(x: 3*(UIViewController.SCRN_WIDTH - 160) / 5 + 2*(UIViewController.SCRN_WIDTH - 160)/5, y: UIViewController.SCRN_HEIGHT - 40, width: 30, height: 30))
        navigationBarProfileButton.setImage(navigationBarProfile, for: UIControlState.normal)
        navigationBarProfileButton.tag = 2
        navigationBarProfileButton.addTarget(self, action: #selector(self.navigatePages), for: .touchUpInside)
        
        
        let navigationBarFeed = UIImage(named: "feed_grey")
        let navigationBarFeedButton = UIButton(frame: CGRect(x: 2*(UIViewController.SCRN_WIDTH - 160) / 5 + (UIViewController.SCRN_WIDTH - 160)/5, y: UIViewController.SCRN_HEIGHT - 40, width: 30, height: 30))
        navigationBarFeedButton.setImage(navigationBarFeed, for: UIControlState.normal)
        navigationBarFeedButton.tag = 3
        navigationBarFeedButton.addTarget(self, action: #selector(self.navigatePages), for: .touchUpInside)
        
        
        let navigationBarSettings = UIImage(named: "settings_grey")
        let navigationBarSettingsButton = UIButton(frame: CGRect(x: 4*(UIViewController.SCRN_WIDTH - 160) / 5 + 3*(UIViewController.SCRN_WIDTH - 160)/5, y: UIViewController.SCRN_HEIGHT - 40, width: 30, height: 30))
        navigationBarSettingsButton.setImage(navigationBarSettings, for: UIControlState.normal)
        navigationBarSettingsButton.tag = 4
        navigationBarSettingsButton.addTarget(self, action: #selector(self.navigatePages), for: .touchUpInside)
        
        
        switch identifier {
            case "main_page":
                navigationBarHomeButton.setImage(UIImage(named: "home_red"), for: UIControlState.normal)
                break;
            case "feed":
                navigationBarFeedButton.setImage(UIImage(named: "feed_red"), for: UIControlState.normal)
                break;
            case "profile":
                navigationBarProfileButton.setImage(UIImage(named: "profile_bar_red"), for: UIControlState.normal)
                break;
            case "settings":
                navigationBarSettingsButton.setImage(UIImage(named: "settings_red"), for: UIControlState.normal)
                break;
            default:
                break;
        }
        
        self.view.addSubview((navigationBarLabelBorder))
        self.view.addSubview(navigationBarLabel)
        self.view.addSubview(navigationBarHomeButton)
        self.view.addSubview(navigationBarFeedButton)
        self.view.addSubview(navigationBarProfileButton)
        self.view.addSubview(navigationBarSettingsButton)
        
    }
    
    @objc func navigatePages(sender: UIButton) {
        
        var identifier: String?
        var direction: UIPageViewControllerNavigationDirection?
        var idx: Int?
        
        switch sender.tag {
            case 1:
                identifier = UIViewController.MAIN_PAGE_VC
                direction = .forward
                idx = 1
                break;
            case 2:
                identifier = UIViewController.PROFILE_VC
                direction = .forward
                idx = 0
                break;
            case 3:
                identifier = UIViewController.MAIN_PAGE_VC
                direction = .forward
                idx = 1
                break;
            case 4:
                identifier = UIViewController.SETTINGS_VC
                direction = .forward
                idx = 2
                break;
            default:
                identifier = UIViewController.MAIN_PAGE_VC
                direction = .forward
                idx = 1
                break;
        }
        
        var candidate: UIViewController = self
        while true {
            if let pageViewController = candidate as? MainPageController {
                pageViewController.goSpecificPageNoAnimate(withIdentifier: identifier!, direction: direction!, index: idx!)
                break
            }
            guard let next = parent else { break }
            candidate = next
        }
    }
}
