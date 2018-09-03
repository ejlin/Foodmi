//
//  LoginViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 8/27/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate{

    fileprivate var loginTextFields: [UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLoginView()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Function Name: createLoginView()
     * Return Type: None
     * Parameters: None
     * Description: This function will create the Login view for when the user already has an account
     */
    
    func createLoginView() {
        
        let backImage = UIImage(named: "back")
        let backButton = UIButton(frame: CGRect(x: 50, y: 75, width: 25, height: 25))
        backButton.setImage(backImage, for: UIControlState.normal)
        backButton.addTarget(self, action:#selector(backButtonPressed), for:.touchUpInside)
        self.view.addSubview(backButton)
        
        _ = createUILabel(backgroundColor: UIViewController.SCRN_MAIN_COLOR,
                          textColor: .white,
                          labelText: "Login",
                          fontSize: 24.0,
                          fontName: UIViewController.SCRN_FONT_BOLD,
                          cornerRadius: 20,
                          frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 65, y: 70, width: 130, height: 40))
        
        let emailTextField = createUITextField(placeholder: "Email",
                                               textColor: UIViewController.SCRN_MAIN_COLOR,
                                               bottomLineColor: UIViewController.SCRN_MAIN_COLOR,
                                               isSecureTextEntry: false,
                                               frame: CGRect(x: 50, y: 150, width: UIViewController.SCRN_WIDTH - 100, height: 35))
        
        let passwordTextField = createUITextField(placeholder: "Password",
                                                  textColor: UIViewController.SCRN_MAIN_COLOR,
                                                  bottomLineColor: UIViewController.SCRN_MAIN_COLOR,
                                                  isSecureTextEntry: true,
                                                  frame: CGRect(x: 50, y: 225, width: UIViewController.SCRN_WIDTH - 100, height: 35))
        
        _ = createUIButton(textColor: UIViewController.SCRN_MAIN_COLOR,
                           titleText: "Forgot Password?",
                           fontName: UIViewController.SCRN_FONT_MEDIUM,
                           fontSize: 14,
                           alignment: .right,
                           backgroundColor: .clear,
                           cornerRadius: 0,
                           tag: -1,
                           frame: CGRect(x:50, y: 270, width: UIViewController.SCRN_WIDTH - 100, height: 35))
        //loginButton.addTarget(self,action:#selector(buttonPressed), for:.touchUpInside)
        
        let forwardImage = UIImage(named: "forward")
        let forwardButton = LoginUIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 100, y: UIViewController.SCRN_HEIGHT*0.5 - 10, width: 50, height: 50))
        forwardButton.setImage(forwardImage, for: UIControlState.normal)
        forwardButton.email = emailTextField
        forwardButton.password = passwordTextField
        forwardButton.addTarget(self, action:#selector(loginButtonPressed), for:.touchUpInside)
        self.view.addSubview(forwardButton)
        
        loginTextFields.append(emailTextField)
        loginTextFields.append(passwordTextField)
        
        for textField in loginTextFields {
            textField.delegate = self
        }
    }
    
    @objc func loginButtonPressed(sender: LoginUIButton) {
        
        var errorOccurred = false
        let email = sender.email?.text
        let password = sender.password?.text
        
        if (email?.count == 0) {
            sender.email?.attributedPlaceholder = NSAttributedString(string: "Required",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
            errorOccurred = true
        }
        if (password?.count == 0) {
            sender.password?.attributedPlaceholder = NSAttributedString(string: "Required",
                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
            errorOccurred = true
        }
        if (!self.isValidEmail(testStr: email!) && email!.count > 0) {
            sender.email?.text = ""
            sender.email?.attributedPlaceholder = NSAttributedString(string: "Invalid Email",
                                                                     attributes: [NSAttributedStringKey.foregroundColor : UIViewController.SCRN_INVALID_INPUT_RED])
            errorOccurred = true
        }
        
        if (errorOccurred) {
            return
        }
        self.view.showActivityIndicator()
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            if (error != nil){
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .wrongPassword:
                        sender.password?.text = ""
                        sender.password?.attributedPlaceholder = NSAttributedString(string: "Wrong Password",
                                                                                    attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
                    default:
                        sender.email?.text = ""
                        sender.email?.attributedPlaceholder = NSAttributedString(string: "No account found with this email",
                                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
                        sender.password?.text = ""
                        sender.password?.placeholder = "Password"
                    }
                    self.view.hideActivityIndicator()
                }
                return
            }
            let newPageViewController = MainPageController()
            self.present(newPageViewController, animated: false, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /* Handle when we are on the login page */
        if ((textField.text?.count)! > 0) {
            if textField == loginTextFields[0] {
                textField.resignFirstResponder()
                loginTextFields[1].becomeFirstResponder()
            }
            else if textField == loginTextFields[1] {
                textField.resignFirstResponder()
                view.endEditing(true)
            }
        }
        return true
    }
    
    @objc func backButtonPressed(sender:UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "hidePageControl")
        let cur = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UIViewController.REGISTER_VC)
        self.show(cur, sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
