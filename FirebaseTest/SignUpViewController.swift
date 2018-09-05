//
//  SignUpViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 8/27/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    fileprivate var signUpTextFields: [UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        createSignUpView()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Function Name: createSignUpView()
     * Return Type: None
     * Parameters: None
     * Description: This function will create the Sign Up view for when the user does not have an account
     */
    
    func createSignUpView() {
        
        let backImage = UIImage(named: "back")
        let backButton = UIButton(frame: CGRect(x: 50, y: 75, width: 25, height: 25))
        backButton.setImage(backImage, for: UIControlState.normal)
        backButton.addTarget(self, action:#selector(backButtonPressed), for:.touchUpInside)
        self.view.addSubview(backButton)
        
        _ = createUILabel(backgroundColor: UIViewController.SCRN_MAIN_COLOR,
                          textColor: .white,
                          labelText: "Sign Up",
                          fontSize: 24.0,
                          fontName: UIViewController.SCRN_FONT_BOLD,
                          cornerRadius: 20,
                          frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 65, y: 70, width: 130, height: 40))
        _ = createUILabel(backgroundColor: .clear,
                          textColor: UIViewController.SCRN_MAIN_COLOR,
                          labelText: "By submitting this form, you agree to the Terms & Conditions",
                          fontSize: 14.0,
                          fontName: UIViewController.SCRN_FONT_BOLD,
                          cornerRadius: 20,
                          frame: CGRect(x: 50, y: 505, width: UIViewController.SCRN_WIDTH - 100, height: 35))
        
        let firstNameTextField = createUITextField(placeholder: "First Name",
                                                   textColor: UIViewController.SCRN_MAIN_COLOR,
                                                   bottomLineColor: UIViewController.SCRN_MAIN_COLOR,
                                                   isSecureTextEntry: false,
                                                   frame: CGRect(x: 50, y: 150, width: UIViewController.SCRN_WIDTH - 100, height: 35))
        let lastNameTextField = createUITextField(placeholder: "Last Name",
                                                  textColor: UIViewController.SCRN_MAIN_COLOR,
                                                  bottomLineColor: UIViewController.SCRN_MAIN_COLOR,
                                                  isSecureTextEntry: false,
                                                  frame: CGRect(x: 50, y: 225, width: UIViewController.SCRN_WIDTH - 100, height: 35))
        let emailTextField = createUITextField(placeholder: "Email",
                                               textColor: UIViewController.SCRN_MAIN_COLOR,
                                               bottomLineColor: UIViewController.SCRN_MAIN_COLOR,
                                               isSecureTextEntry: false,
                                               frame: CGRect(x: 50, y: 300, width: UIViewController.SCRN_WIDTH - 100, height: 35))
        let passwordTextField = createUITextField(placeholder: "Password",
                                                  textColor: UIViewController.SCRN_MAIN_COLOR,
                                                  bottomLineColor: UIViewController.SCRN_MAIN_COLOR,
                                                  isSecureTextEntry: true,
                                                  frame: CGRect(x: 50, y: 375, width: UIViewController.SCRN_WIDTH - 100, height: 35))
        let confirmPasswordTextField = createUITextField(placeholder: "Confirm Password",
                                                         textColor: UIViewController.SCRN_MAIN_COLOR,
                                                         bottomLineColor: UIViewController.SCRN_MAIN_COLOR,
                                                         isSecureTextEntry: true,
                                                         frame: CGRect(x: 50, y: 450, width: UIViewController.SCRN_WIDTH - 100, height: 35))
        
        let forwardImage = UIImage(named: "forward")
        let forwardButton = SignUpUIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 100, y: UIViewController.SCRN_HEIGHT - 100, width: 50, height: 50))
        forwardButton.firstName = firstNameTextField
        forwardButton.lastName = lastNameTextField
        forwardButton.email = emailTextField
        forwardButton.password = passwordTextField
        forwardButton.confirmPassword = confirmPasswordTextField
        forwardButton.setImage(forwardImage, for: UIControlState.normal)
        forwardButton.addTarget(self, action:#selector(signUpButtonPressed), for:.touchUpInside)
        self.view.addSubview(forwardButton)
        
        signUpTextFields.append(firstNameTextField)
        signUpTextFields.append(lastNameTextField)
        signUpTextFields.append(emailTextField)
        signUpTextFields.append(passwordTextField)
        signUpTextFields.append(confirmPasswordTextField)
        
        for textField in signUpTextFields {
            textField.delegate = self
        }
        return
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
        if ((textField.text?.count)! > 0){
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
            } else if textField == signUpTextFields[4] {
                textField.resignFirstResponder()
                view.endEditing(true)
            }
        }
        return true
    }
    
    /* Function Name: signUpButtonPressed()
     * Return Type: None
     * Parameters: This function takes in 1 parameter
     *             _sender: SignUpUIButton -> The SignUpUIButton that sent this action
     * Description: This function will execute after the user presses sign up in the RegisterViewController. This function will handle errors in the
     * sign up form when clicked by the user. If the form passes all the tests, this function will create a new account for the user in our Firebase.
     */
    
    @objc func signUpButtonPressed(sender: SignUpUIButton!) {
        
        var errorOccurred = false
        
        /* Retrieve our different values from our Sign Up form */
        let firstName = sender.firstName?.text
        let lastName = sender.lastName?.text
        let email = sender.email?.text
        let password = sender.password?.text
        let confirmPassword = sender.confirmPassword?.text
        
        /* Makes sure that the user's first name is not empty string. Error if it is. */
        if (firstName?.count == 0){
            sender.firstName?.attributedPlaceholder = NSAttributedString(string: "Required",
                                                                         attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
            errorOccurred = true
        }
        
        /* Makes sure that the user's last name is not empty string. Error if it is. */
        if (lastName?.count == 0){
            sender.lastName?.attributedPlaceholder = NSAttributedString(string: "Required",
                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
            errorOccurred = true
        }
        
        /* Makes sure that the user's email is not empty string. Error if it is. */
        if (email?.count == 0){
            sender.email?.attributedPlaceholder = NSAttributedString(string: "Required",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
            errorOccurred = true
        }
        
        /* Makes sure that the user's password is not empty string. Error if it is. */
        if (password?.count == 0){
            sender.password?.attributedPlaceholder = NSAttributedString(string: "Required",
                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
            errorOccurred = true
        }
        
        /* Makes sure that the user's confirm password is not empty string. Error if it is. */
        if (confirmPassword?.count == 0){
            sender.confirmPassword?.attributedPlaceholder = NSAttributedString(string: "Required",
                                                                               attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
            errorOccurred = true
        }
        
        /* Makes sure that the user's password and confirmation password match. Error if they do not. */
        if (password != confirmPassword) {
            sender.password?.text = ""
            sender.confirmPassword?.text = ""
            sender.password?.attributedPlaceholder = NSAttributedString(string: "Passwords do not Match",
                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
            sender.confirmPassword?.attributedPlaceholder = NSAttributedString(string: "Passwords do not Match",
                                                                               attributes: [NSAttributedStringKey.foregroundColor : UIViewController.SCRN_INVALID_INPUT_RED])
            errorOccurred = true
        }
        
        /* Makes sure that the user's email is valid. Error if it does not. */
        if (!self.isValidEmail(testStr: email!) && email!.count > 0) {
            sender.email?.text = ""
            sender.email?.attributedPlaceholder = NSAttributedString(string: "Invalid Email",
                                                                     attributes: [NSAttributedStringKey.foregroundColor : UIViewController.SCRN_INVALID_INPUT_RED])
            errorOccurred = true
        }
        
        /* Return from this function if an error occurred at any point. */
        if (errorOccurred){
            
            return
        }
        
        /* Display loading activity indicator */
        self.view.showActivityIndicator()
        
        /* Call Firebase's createUserWithEmail to create a new user */
        Auth.auth().createUser(withEmail: email!, password: password!) { (authResult, error) in
            if (error != nil){
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .emailAlreadyInUse:
                        sender.email?.text = ""
                        sender.email?.attributedPlaceholder = NSAttributedString(string: "Email already exists",
                                                                                 attributes: [NSAttributedStringKey.foregroundColor : UIViewController.SCRN_INVALID_INPUT_RED])
                        self.view.hideActivityIndicator()
                        return
                    case .weakPassword:
                        sender.password?.text = ""
                        sender.confirmPassword?.text = ""
                        sender.password?.attributedPlaceholder = NSAttributedString(string: "Weak Password",
                                                                                    attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
                        sender.confirmPassword?.attributedPlaceholder = NSAttributedString(string: "Weak Password",
                                                                                           attributes: [NSAttributedStringKey.foregroundColor : UIViewController.SCRN_INVALID_INPUT_RED])
                        self.view.hideActivityIndicator()
                        return
                    default:
                        return
                    }
                }
                return
            }
            /* Update our user's display name in Firebase */
            let user = Auth.auth().currentUser
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = firstName! + " " + lastName!
            changeRequest?.commitChanges { (error) in
                let ref = Database.database().reference()
                //print((user?.uid)!)
                ref.child("users/\((user?.uid)!)/email").setValue(["email" : email!])
                ref.child("users/\((user?.uid)!)/name").setValue(["name" : firstName! + " " + lastName!])
                //ref.child("usersID/\((user?.uid)!)").setValue(["email": email!])
                let newPageViewController = MainPageController()
                self.present(newPageViewController, animated: false, completion: nil)
            }
            ///ref.child("usersEmail/\(email!)").setValue(["uid": (user?.uid)!])
            
        }
        return
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
