//
//  ViewController.swift
//  FirebaseTest
//
//  Created by Eric Lin on 8/16/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import QuartzCore
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    /* Define our MACROS */
    let SCRN_WIDTH = UIScreen.main.bounds.size.width
    let SCRN_HEIGHT = UIScreen.main.bounds.size.height
    let SCRN_FONT_BOLD = "AppleSDGothicNeo-Bold"
    let SCRN_FONT_MEDIUM = "AppleSDGothicNeo-Medium"
    let SCRN_MAIN_COLOR = UIColor(rgb: 0x3AAFA9)
    let SCRN_MAIN_COLOR_DARK = UIColor(rgb: 0x2B7A78)
    let INVALID_IDX = -1
    
    /* Define our various viewControllers */
    @IBOutlet var welcomeView: UIView!
    @IBOutlet var getStartedView: UIView!
    @IBOutlet var registerView: UIView!
    @IBOutlet var signUpView: UIView!
    @IBOutlet var loginView: UIView!
    
    fileprivate var loginTextFields: [UITextField] = []
    fileprivate var signUpTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if (self.view === welcomeView){
            createWelcomeView()
        }
        else if (self.view === getStartedView ){
            createGetStartedView()
        }
        else if (self.view === registerView){
            createRegisterView()
        }
        else if (self.view === signUpView) {
            createSignUpView()
        }
        else if (self.view === loginView) {
            createLoginView()
        }
        self.hideKeyboardWhenTappedAround()
    }

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
                       frame: CGRect){
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
    }
    
    /* Function Name: createUIImage()
     * Return Type: None
     * Parameters: This function takes in 2 parameters
     *             imageName: String - This is the name of our image file
     *             frame: CGRect - This specifies the x & y position of the UIImage as well as the width and height
     * Description: This function will create a UIImage according to the specified parameters and then add
     * it to the current viewController's view.
     */
    
    func createUIImage(imageName: String, imageFrame: CGRect){
        let myImage = UIImage(named: imageName)
        let myImageView = UIImageView(image: myImage!)
        myImageView.frame = imageFrame
        self.view.addSubview(myImageView)
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
    
    /* Function Name: textFieldShouldReturn()
     * Return Type: Bool
     * Parameters: This function takes in 1 parameter
     *             textField: UITextField - This is the current UITextField
     * Description: This function controls which action to execute when the "return" key is
     * pressed for a specific text field.
     */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        /* Handle when we are on the sign up page */
        if (self.view === signUpView && (textField.text?.count)! > 0){
            if textField == signUpTextFields[0] {
                textField.resignFirstResponder()
                signUpTextFields[1].becomeFirstResponder()
            } else if textField == signUpTextFields[1] {
                textField.resignFirstResponder()
                signUpTextFields[2].becomeFirstResponder()
            } else if textField == signUpTextFields[2] {
                textField.resignFirstResponder()
                signUpTextFields[3].becomeFirstResponder()
            } else if textField == signUpTextFields[3] {
                textField.resignFirstResponder()
                signUpTextFields[4].becomeFirstResponder()
            }
        }
        
        /* Handle when we are on the login page */
        if (self.view === loginView && (textField.text?.count)! > 0) {
            if textField == loginTextFields[0] {
                textField.resignFirstResponder()
                loginTextFields[1].becomeFirstResponder()
            }
        }
        return true
    }
    
    /* Function Name: createWelcomeView()
     * Return Type: None
     * Parameters: None
     * Description: Create the view for our welcome screen. This is the first screen that
     * users see after launching the app if they have never opened the app before
     */
    
    func createWelcomeView() {
        createUILabel(backgroundColor: .clear,
                      textColor: .white,
                      labelText: "Welcome",
                      fontSize: 30.0,
                      fontName: SCRN_FONT_BOLD,
                      cornerRadius: 0,
                      frame: CGRect(x: SCRN_WIDTH*0.5 - 100, y: SCRN_HEIGHT*0.5 - 225, width: 200, height: 50))
    }
    
    /* Function Name: createGetStartedView()
     * Return Type: None
     * Parameters: None
     * Description: Create the view for our tutorial screen. This is the second screen that
     * users see after launching the app if they have never opened the app before. This screen
     * will display to the users how to use the app.
     */
    
    func createGetStartedView() {
        
        createUIImage(imageName: "restaurant",
                      imageFrame: CGRect(x: SCRN_WIDTH*0.5 + 60, y: SCRN_HEIGHT*0.5 - 190, width: 60, height: 60))
        createUIImage(imageName: "arrowPointBottom",
                      imageFrame: CGRect(x: SCRN_WIDTH*0.5 + 10, y: SCRN_HEIGHT*0.5 - 110, width: 75, height: 75))
        createUIImage(imageName: "ratings",
                      imageFrame: CGRect(x: SCRN_WIDTH*0.5 - 85, y: SCRN_HEIGHT*0.5 - 10, width: 170, height: 30))
        createUIImage(imageName: "arrowPointRight",
                      imageFrame: CGRect(x: SCRN_WIDTH*0.5 - 80, y: SCRN_HEIGHT*0.5 + 90, width: 75, height: 75))
        createUIImage(imageName: "recommendation",
                      imageFrame: CGRect(x: SCRN_WIDTH*0.5 - 140, y: SCRN_HEIGHT*0.5 + 190, width: 60, height: 60))

        createUILabel(backgroundColor: .clear,
                      textColor: .white,
                      labelText: "How It Works:",
                      fontSize: 30.0,
                      fontName: SCRN_FONT_BOLD,
                      cornerRadius: 0,
                      frame: CGRect(x: SCRN_WIDTH*0.5 - 100, y: SCRN_HEIGHT*0.5 - 275, width: 200, height: 50))
        createUILabel(backgroundColor: SCRN_MAIN_COLOR_DARK,
                      textColor: .white,
                      labelText: "Mark restaurants you've visited",
                      fontSize: 18.0,
                      fontName: SCRN_FONT_MEDIUM,
                      cornerRadius: 5,
                      frame: CGRect(x: SCRN_WIDTH*0.5 - 130, y: SCRN_HEIGHT*0.5 - 190, width: 160, height: 60))
        createUILabel(backgroundColor: SCRN_MAIN_COLOR_DARK,
                      textColor: .white,
                      labelText: "Rate them!",
                      fontSize: 18.0,
                      fontName: SCRN_FONT_MEDIUM,
                      cornerRadius: 5,
                      frame: CGRect(x: SCRN_WIDTH*0.5 - 85, y: SCRN_HEIGHT*0.5 + 30, width: 170, height: 40))
        createUILabel(backgroundColor: SCRN_MAIN_COLOR_DARK,
                      textColor: .white,
                      labelText: "Get restaurant recommendations",
                      fontSize: 18.0,
                      fontName: SCRN_FONT_MEDIUM,
                      cornerRadius: 5,
                      frame: CGRect(x: SCRN_WIDTH*0.5 - 60, y: SCRN_HEIGHT*0.5 + 190, width: 180, height: 60))
    }
    
    /* Function Name: createRegisterView()
     * Return Type: None
     * Parameters: None
     * Description: Create the view for our login/signup screen. This is the third screen that
     * users see after launching the app if they have never opened the app before. This screen
     * will display to the users options to either login to an existing account or sign up for
     * a new account.
     */
    
    func createRegisterView() {
        let signUpButton = UIButton(frame: CGRect(x: SCRN_WIDTH*0.5 - 112.5, y: SCRN_HEIGHT*0.5 + 175, width: 225, height: 50))
        signUpButton.contentHorizontalAlignment = .center
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.titleLabel?.font =  UIFont(name: SCRN_FONT_MEDIUM, size: 20)
        signUpButton.backgroundColor = SCRN_MAIN_COLOR_DARK
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.masksToBounds = true
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.tag = 1
        signUpButton.addTarget(self,action:#selector(buttonPressed),
                          for:.touchUpInside)
        //signUpButton.addTarget(self, action: #selector(buttonHoldDown), for: UIControlEvents.touchDown)
        self.view.addSubview(signUpButton)
        
        let loginButton = UIButton(frame: CGRect(x: SCRN_WIDTH*0.5 - 112.5, y: SCRN_HEIGHT*0.5 + 105, width: 225, height: 50))
        loginButton.contentHorizontalAlignment = .center
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font =  UIFont(name: SCRN_FONT_MEDIUM, size: 20)
        loginButton.backgroundColor = SCRN_MAIN_COLOR_DARK
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.tag = 2
        loginButton.addTarget(self,action:#selector(buttonPressed),
                              for:.touchUpInside)
        self.view.addSubview(loginButton)
    }
    
    func createLoginView() {

        let backImage = UIImage(named: "back")
        let backButton = UIButton(frame: CGRect(x: 50, y: 75, width: 25, height: 25))
        backButton.setImage(backImage, for: UIControlState.normal)
        backButton.addTarget(self, action:#selector(backButtonPressed), for:.touchUpInside)
        self.view.addSubview(backButton)
        
        createUILabel(backgroundColor: SCRN_MAIN_COLOR,
                      textColor: .white,
                      labelText: "Login",
                      fontSize: 24.0,
                      fontName: SCRN_FONT_MEDIUM,
                      cornerRadius: 20,
                      frame: CGRect(x: SCRN_WIDTH*0.5 - 65, y: 70, width: 130, height: 40))
        
        let emailTextField = createUITextField(placeholder: "Email",
                                               textColor: SCRN_MAIN_COLOR,
                                               bottomLineColor: SCRN_MAIN_COLOR,
                                               isSecureTextEntry: false,
                                               frame: CGRect(x: 50, y: 150, width: SCRN_WIDTH - 100, height: 35))
        
        let passwordTextField = createUITextField(placeholder: "Password",
                                                  textColor: SCRN_MAIN_COLOR,
                                                  bottomLineColor: SCRN_MAIN_COLOR,
                                                  isSecureTextEntry: true,
                                                  frame: CGRect(x: 50, y: 225, width: SCRN_WIDTH - 100, height: 35))

        
        let forgotPasswordButton = UIButton(frame: CGRect(x: 50, y: 270, width: SCRN_WIDTH - 100, height: 35))
        forgotPasswordButton.contentHorizontalAlignment = .right
        forgotPasswordButton.setTitleColor(SCRN_MAIN_COLOR, for: .normal)
        forgotPasswordButton.titleLabel?.font =  UIFont(name: SCRN_FONT_MEDIUM, size: 14)
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        //loginButton.tag = 3
        //loginButton.addTarget(self,action:#selector(buttonPressed), for:.touchUpInside)
        self.view.addSubview(forgotPasswordButton)
        
        let forwardImage = UIImage(named: "forward")
        let forwardButton = UIButton(frame: CGRect(x: SCRN_WIDTH - 100, y: SCRN_HEIGHT*0.5 - 10	, width: 50, height: 50))
        forwardButton.setImage(forwardImage, for: UIControlState.normal)
        //forwardButton.addTarget(self, action:#selector(backButtonPressed), for:.touchUpInside)
        self.view.addSubview(forwardButton)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginTextFields.append(emailTextField)
        loginTextFields.append(passwordTextField)
        
    }
    
    func createSignUpView() {
        
        let backImage = UIImage(named: "back")
        let backButton = UIButton(frame: CGRect(x: 50, y: 75, width: 25, height: 25))
        backButton.setImage(backImage, for: UIControlState.normal)
        backButton.addTarget(self, action:#selector(backButtonPressed), for:.touchUpInside)
        self.view.addSubview(backButton)
        
        createUILabel(backgroundColor: SCRN_MAIN_COLOR,
                      textColor: .white,
                      labelText: "Sign Up",
                      fontSize: 24.0,
                      fontName: SCRN_FONT_MEDIUM,
                      cornerRadius: 20,
                      frame: CGRect(x: SCRN_WIDTH*0.5 - 65, y: 70, width: 130, height: 40))
        createUILabel(backgroundColor: .clear,
                      textColor: SCRN_MAIN_COLOR,
                      labelText: "By submitting this form, you agree to the Terms & Conditions",
                      fontSize: 14.0,
                      fontName: SCRN_FONT_MEDIUM,
                      cornerRadius: 20,
                      frame: CGRect(x: 50, y: 505, width: SCRN_WIDTH - 100, height: 35))
        
        let firstNameTextField = createUITextField(placeholder: "First Name",
                                                   textColor: SCRN_MAIN_COLOR,
                                                   bottomLineColor: SCRN_MAIN_COLOR,
                                                   isSecureTextEntry: false,
                                                   frame: CGRect(x: 50, y: 150, width: SCRN_WIDTH - 100, height: 35))
        let lastNameTextField = createUITextField(placeholder: "Last Name",
                                                  textColor: SCRN_MAIN_COLOR,
                                                  bottomLineColor: SCRN_MAIN_COLOR,
                                                  isSecureTextEntry: false,
                                                  frame: CGRect(x: 50, y: 225, width: SCRN_WIDTH - 100, height: 35))
        let emailTextField = createUITextField(placeholder: "Email",
                                               textColor: SCRN_MAIN_COLOR,
                                               bottomLineColor: SCRN_MAIN_COLOR,
                                               isSecureTextEntry: false,
                                               frame: CGRect(x: 50, y: 300, width: SCRN_WIDTH - 100, height: 35))
        let passwordTextField = createUITextField(placeholder: "Password",
                                                  textColor: SCRN_MAIN_COLOR,
                                                  bottomLineColor: SCRN_MAIN_COLOR,
                                                  isSecureTextEntry: true,
                                                  frame: CGRect(x: 50, y: 375, width: SCRN_WIDTH - 100, height: 35))
        let confirmPasswordTextField = createUITextField(placeholder: "Confirm Password",
                                                         textColor: SCRN_MAIN_COLOR,
                                                         bottomLineColor: SCRN_MAIN_COLOR,
                                                         isSecureTextEntry: true,
                                                         frame: CGRect(x: 50, y: 450, width: SCRN_WIDTH - 100, height: 35))
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        signUpTextFields.append(firstNameTextField)
        signUpTextFields.append(lastNameTextField)
        signUpTextFields.append(emailTextField)
        signUpTextFields.append(passwordTextField)
        signUpTextFields.append(confirmPasswordTextField)
        
        let forwardImage = UIImage(named: "forward")
        let forwardButton = UIButton(frame: CGRect(x: SCRN_WIDTH - 100, y: SCRN_HEIGHT - 100, width: 50, height: 50))
        forwardButton.setImage(forwardImage, for: UIControlState.normal)
        //forwardButton.addTarget(self, action:#selector(backButtonPressed), for:.touchUpInside)
        self.view.addSubview(forwardButton)
        
        
    }
    
    @IBAction func goToLastPage(_ sender: UIButton!) {
        goToPage(sender, identifier: "RegisterViewController", direction: .forward, idx: 2)
    }
    
    @objc func buttonHoldDown(sender:UIButton)
    {
        sender.backgroundColor = UIColor(rgb: 0xDEF2F1)
    }
    
    @objc func buttonPressed(sender: UIButton!) {
        sender.backgroundColor = UIColor(rgb: 0x2B7A78)
        switch sender.tag {
        case 1: goToPage(sender, identifier: "signUpViewController", direction: .forward, idx: INVALID_IDX)
                break
        case 2: goToPage(sender, identifier: "loginViewController", direction: .forward, idx: INVALID_IDX)
                break
            default: print("default")
                break
        }
    }
    
    @objc func backButtonPressed(sender:UIButton) {
        goToPage(sender, identifier: "RegisterViewController", direction: .reverse, idx: 2)
    }
    
    func goToPage(_ sender: UIButton!, identifier: String, direction: UIPageViewControllerNavigationDirection, idx: Int) {
        var candidate: UIViewController = self
        while true {
            if let pageViewController = candidate as? PageViewController {
                pageViewController.goSpecificPage(withIdentifier: identifier, direction: direction, index: idx)
                break
            }
            guard let next = parent else { break }
            candidate = next
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIColor {    
    convenience init(rgb: Int) {
        self.init(red: CGFloat((rgb >> 16) & 0xFF) / 255.0, green: CGFloat((rgb >> 8) & 0xFF) / 255.0, blue: CGFloat((rgb & 0xFF)) / 255.0, alpha: 1.0)
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

