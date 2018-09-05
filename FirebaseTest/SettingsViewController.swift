//
//  SettingsViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 8/27/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController, UIGestureRecognizerDelegate {

    private var tempView: UIView!
    private var reauthenticateView: UIView!
    private var tempBackgroundLabel: UILabel!

    @IBOutlet weak var settingsScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reauthenticateView?.isHidden = true
        settingsScrollView.contentSize = CGSize(width: UIViewController.SCRN_WIDTH, height: UIViewController.SCRN_HEIGHT - 32)
        settingsScrollView.bounces = (settingsScrollView.contentOffset.y > 100);
        createSettingsPage()
        
        self.hideKeyboardWhenTappedAround()
        self.createNavigationBar(withIdentifier: "settings")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Function Name: createSettingsView()
     * Return Type: None
     * Parameters: None
     * Description: This function creates the settings page for the user that allows them to edit certain properties of their account.
     */
    
    func createSettingsPage() {
        let backImage = UIImage(named: "back_2")
        let backButton = UIButton(frame: CGRect(x: 25, y: 50, width: 36, height: 36))
        backButton.setImage(backImage, for: UIControlState.normal)
        backButton.addTarget(self, action:#selector(buttonPressed), for:.touchUpInside)
        backButton.tag = 4
        //self.view.addSubview(backButton)
        
        
        let settingsLabel = self.createUILabel(backgroundColor: .clear,
                          textColor: UIViewController.SCRN_BLACK,
                          labelText: "Settings",
                          fontSize: 24,
                          fontName: UIViewController.SCRN_FONT_BOLD,
                          cornerRadius: 18,
                          frame: CGRect(x: 80, y: 50, width: 130, height: 36))
        settingsLabel.textAlignment = .left
        
        _ = self.createUILabel(backgroundColor: UIViewController.SCRN_GREY_LIGHT, textColor: .clear, labelText: "", fontSize: 0, fontName: UIViewController.SCRN_FONT_MEDIUM, cornerRadius: 0, frame: CGRect(x: 0, y: 102, width: Int(UIViewController.SCRN_WIDTH), height: 1))
        
//        let preferencesLabel = self.createUILabel(backgroundColor: UIViewController.SCRN_MAIN_COLOR,
//                                             textColor: UIViewController.SCRN_WHITE,
//                                             labelText: "Preferences Settings",
//                                             fontSize: 18,
//                                             fontName: UIViewController.SCRN_FONT_BOLD,
//                                             cornerRadius: 0,
//                                             frame: CGRect(x: 0, y: 0, width: UIViewController.SCRN_WIDTH , height: 35))
        
        for i in 0...12{
            let border = self.createUILabel(backgroundColor: UIViewController.SCRN_GREY_LIGHT, textColor: .clear, labelText: "", fontSize: 0, fontName: UIViewController.SCRN_FONT_MEDIUM, cornerRadius: 0, frame: CGRect(x: 0, y: i * 50, width: Int(UIViewController.SCRN_WIDTH), height: 1))
            self.settingsScrollView.addSubview(border)
        }
        
        let twentyOneLabel = self.createUILabel(backgroundColor: .clear,
                                                textColor: UIViewController.SCRN_GREY,
                                                labelText: "Display 21+ Establishments:",
                                                fontSize: 16,
                                                fontName: UIViewController.SCRN_FONT_BOLD,
                                                cornerRadius: 0,
                                                frame: CGRect(x: 20, y: 13, width: UIViewController.SCRN_WIDTH - 120, height: 30))
        twentyOneLabel.textAlignment = .left
        let twentyOneSwitch = UISwitch(frame: CGRect(x: UIViewController.SCRN_WIDTH - 70, y: 10, width: 50, height: 30))
        twentyOneSwitch.tintColor = UIViewController.SCRN_GREY
        twentyOneSwitch.onTintColor = UIViewController.SCRN_GREY
        twentyOneSwitch.isOn = true
        
        let creditCardButton = self.createUIButton(textColor: UIViewController.SCRN_GREY,
                                                   titleText: "Manage Cards",
                                                   fontName: UIViewController.SCRN_FONT_BOLD,
                                                   fontSize: 16,
                                                   alignment: .left,
                                                   backgroundColor: .clear,
                                                   cornerRadius: 0,
                                                   tag: -1,
                                                   frame: CGRect(x: 20, y: 60, width: UIViewController.SCRN_WIDTH, height: 30))
        
        let notificationsButton = self.createUIButton(textColor: UIViewController.SCRN_GREY,
                                                   titleText: "Notifications",
                                                   fontName: UIViewController.SCRN_FONT_BOLD,
                                                   fontSize: 16,
                                                   alignment: .left,
                                                   backgroundColor: .clear,
                                                   cornerRadius: 0,
                                                   tag: -1,
                                                   frame: CGRect(x: 20, y: 110, width: UIViewController.SCRN_WIDTH, height: 30))
    
        
        let changeFirstNameTextField = createUITextField(placeholder: "Change First Name",
                                                         textColor: UIViewController.SCRN_GREY,
                                                         bottomLineColor: .clear, //UIViewController.SCRN_GREY,
                                                         isSecureTextEntry: false,
                                                         frame: CGRect(x: 20, y: 160, width: UIViewController.SCRN_WIDTH - 90, height: 30))
        changeFirstNameTextField.font = UIFont(name: UIViewController.SCRN_FONT_MEDIUM, size: 16)
        
        let saveFirstNameImage = UIImage(named: "save")
        let saveFirstNameButton = DisplayNameUIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 50, y: 160, width: 30, height: 30))
        saveFirstNameButton.setImage(saveFirstNameImage, for: UIControlState.normal)
        saveFirstNameButton.firstName = changeFirstNameTextField
        saveFirstNameButton.lastName = nil
        saveFirstNameButton.addTarget(self, action:#selector(changeDisplayName), for:.touchUpInside)
        
        let changeLastNameTextField = createUITextField(placeholder: "Change Last Name",
                                                        textColor: UIViewController.SCRN_GREY,
                                                        bottomLineColor: .clear, //UIViewController.SCRN_GREY,
                                                        isSecureTextEntry: false,
                                                        frame: CGRect(x: 20, y: 210, width: UIViewController.SCRN_WIDTH - 90, height: 30))
        changeLastNameTextField.font = UIFont(name: UIViewController.SCRN_FONT_MEDIUM, size: 16)
        
        let saveLastNameImage = UIImage(named: "save")
        let saveLastNameButton = DisplayNameUIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 50, y: 210, width: 30, height: 30))
        saveLastNameButton.setImage(saveLastNameImage, for: UIControlState.normal)
        saveLastNameButton.firstName = nil
        saveLastNameButton.lastName = changeLastNameTextField
        saveLastNameButton.addTarget(self, action:#selector(changeDisplayName), for:.touchUpInside)
        
        let changeEmailTextField = createUITextField(placeholder: "Change Email",
                                                     textColor: UIViewController.SCRN_GREY,
                                                     bottomLineColor: .clear, //UIViewController.SCRN_GREY,
                                                     isSecureTextEntry: false,
                                                     frame: CGRect(x: 20, y: 260, width: UIViewController.SCRN_WIDTH - 90, height: 30))
        changeEmailTextField.font = UIFont(name: UIViewController.SCRN_FONT_MEDIUM, size: 16)
        
        let saveEmailImage = UIImage(named: "save")
        let saveEmailButton = AuthenticateRequiredUIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 50, y: 260, width: 30, height: 30))
        saveEmailButton.setImage(saveEmailImage, for: UIControlState.normal)
        saveEmailButton.addTarget(self, action:#selector(changeValueRequiringReauthentication), for:.touchUpInside)
        saveEmailButton.email = changeEmailTextField
        saveEmailButton.tag = 1
        
        let changePasswordTextField = createUITextField(placeholder: "Change Password",
                                                        textColor: UIViewController.SCRN_GREY,
                                                        bottomLineColor: .clear, //UIViewController.SCRN_GREY,
                                                        isSecureTextEntry: true,
                                                        frame: CGRect(x: 20, y: 310, width: UIViewController.SCRN_WIDTH - 90, height: 30))
        changePasswordTextField.font = UIFont(name: UIViewController.SCRN_FONT_MEDIUM, size: 16)
        
        let savePasswordImage = UIImage(named: "save")
        let savePasswordButton = AuthenticateRequiredUIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 50, y: 310, width: 30, height: 30))
        savePasswordButton.setImage(savePasswordImage, for: UIControlState.normal)
        savePasswordButton.addTarget(self, action:#selector(changeValueRequiringReauthentication), for:.touchUpInside)
        savePasswordButton.password = changePasswordTextField
        savePasswordButton.tag = 2
        
        let termsButton = self.createUIButton(textColor: UIViewController.SCRN_GREY,
                                              titleText: "Terms & Conditions",
                                              fontName: UIViewController.SCRN_FONT_BOLD,
                                              fontSize: 16,
                                              alignment: .left,
                                              backgroundColor: .clear,
                                              cornerRadius: 5,
                                              tag: -1,
                                              frame: CGRect(x: 20, y: 360, width: UIViewController.SCRN_WIDTH - 40, height: 30))
        
        let FAQButton = self.createUIButton(textColor: UIViewController.SCRN_GREY,
                                            titleText: "FAQ",
                                            fontName: UIViewController.SCRN_FONT_BOLD,
                                            fontSize: 16,
                                            alignment: .left,
                                            backgroundColor: .clear,
                                            cornerRadius: 5,
                                            tag: -1,
                                            frame: CGRect(x: 20, y: 410, width: UIViewController.SCRN_WIDTH - 40, height: 30))
        
        let aboutButton = self.createUIButton(textColor: UIViewController.SCRN_GREY,
                                              titleText: "About",
                                              fontName: UIViewController.SCRN_FONT_BOLD,
                                              fontSize: 16,
                                              alignment: .left,
                                              backgroundColor: .clear,
                                              cornerRadius: 5,
                                              tag: -1,
                                              frame: CGRect(x: 20, y: 460, width: UIViewController.SCRN_WIDTH - 40, height: 30))
        
        let reportBugButton = self.createUIButton(textColor: UIViewController.SCRN_GREY,
                                                titleText: "Report a Bug",
                                                fontName: UIViewController.SCRN_FONT_BOLD,
                                                fontSize: 16,
                                                alignment: .left,
                                                backgroundColor: .clear,
                                                cornerRadius: 5,
                                                tag: -1,
                                                frame: CGRect(x: 20, y: 510, width: UIViewController.SCRN_WIDTH - 40, height: 30))
        reportBugButton.addTarget(self, action: #selector(openReportBug), for: .touchUpInside)
        
        let signOutButton = self.createUIButton(textColor: UIViewController.SCRN_GREY,
                                                titleText: "Sign Out",
                                                fontName: UIViewController.SCRN_FONT_BOLD,
                                                fontSize: 16,
                                                alignment: .left,
                                                backgroundColor: .clear,
                                                cornerRadius: 5,
                                                tag: -1,
                                                frame: CGRect(x: 20, y: 560, width: UIViewController.SCRN_WIDTH - 40, height: 30))
        signOutButton.addTarget(self, action: #selector(self.signOutUser), for: .touchUpInside)
        
        let borderLabel = createUILabel(backgroundColor: UIViewController.SCRN_MAIN_COLOR,
                                        textColor: .white,
                                        labelText: "Version 1.0.0",
                                        fontSize: 12,
                                        fontName: UIViewController.SCRN_FONT_BOLD,
                                        cornerRadius: 0,
                                        frame: CGRect(x: 0, y: 600, width: UIViewController.SCRN_WIDTH, height: 35))
        
        self.view.addSubview(backButton)
        self.settingsScrollView.addSubview(twentyOneLabel)
        self.settingsScrollView.addSubview(twentyOneSwitch)
        self.settingsScrollView.addSubview(creditCardButton)
        self.settingsScrollView.addSubview(notificationsButton)
        self.settingsScrollView.addSubview(changeFirstNameTextField)
        self.settingsScrollView.addSubview(saveFirstNameButton)
        self.settingsScrollView.addSubview(changeLastNameTextField)
        self.settingsScrollView.addSubview(saveLastNameButton)
        self.settingsScrollView.addSubview(changeEmailTextField)
        self.settingsScrollView.addSubview(saveEmailButton)
        self.settingsScrollView.addSubview(changePasswordTextField)
        self.settingsScrollView.addSubview(savePasswordButton)
        self.settingsScrollView.addSubview(termsButton)
        self.settingsScrollView.addSubview(FAQButton)
        self.settingsScrollView.addSubview(reportBugButton)
        self.settingsScrollView.addSubview(aboutButton)
        self.settingsScrollView.addSubview(signOutButton)
        self.settingsScrollView.addSubview(borderLabel)
        
        let customViewFrame = CGRect(x: 5,
                                     y:UIViewController.SCRN_HEIGHT + 40,
                                     width: UIViewController.SCRN_WIDTH - 10,
                                     height: UIViewController.SCRN_HEIGHT + 200)
        tempView = UIView(frame: customViewFrame)
        tempView.backgroundColor = UIViewController.SCRN_WHITE
        tempView.layer.cornerRadius = 8
        tempView.layer.masksToBounds = true
        tempBackgroundLabel = self.createUILabel(backgroundColor: UIViewController.SCRN_GREY,
                                                       textColor: .clear,
                                                       labelText: "",
                                                       fontSize: 0,
                                                       fontName: UIViewController.SCRN_FONT_MEDIUM,
                                                       cornerRadius: 3,
                                                       frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 20, y: UIViewController.SCRN_HEIGHT, width: 40, height: 5))
        view.addSubview(tempView)
        self.view.addSubview(tempBackgroundLabel)
    }

    /* Function Name: hideReAuthenticatePopup()
     * Return Type: None
     * Parameters: None
     * Description: This function will hide our reauthentication popup anytime we successfully save or tap away from the pop up.
     */
    func hideReAuthenticatePopup() {
        for subview in self.view.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        reauthenticateView.isHidden = true
    }
    
    /* Function Name: touchesBegan()
     * Return Type: None
     * Parameters: This function takes in 2 parameters (overriding a function -> refer to official docs for parameter types)
     * Description: This function will listen for taps on our screen. As of now, we only care about this when we're listening for touches
     * while our reauthentication popup is showing.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (reauthenticateView != nil && reauthenticateView.isHidden == false) {
            let location = touches.first?.location(in: nil)
            if reauthenticateView.frame.contains(location!) {
            }
            else {
                hideReAuthenticatePopup()
            }
        }
        return
    }
    
    
    /* Function Name: signOutUser()
     * Return Type: None
     * Parameters: This function takes in 1 parameter
     *             _sender: UIButton -> The UIButton that sent this action
     * Description: This function handles signing out a user by calling Firebase's signOut method.
     */
    @objc func signOutUser(sender: UIButton!) {
        sender.backgroundColor = UIViewController.SCRN_MAIN_COLOR_DARK
        
        if let user = Auth.auth().currentUser {
            do {
            try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UIViewController.REGISTER_VC)
                self.show(vc, sender: self)

            }catch {
                print(":(")
            }
        } else {
            print("no user is logged in")
        }
        
//
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//            if (user != nil) {
//                print("here")
//                do {
//                    try Auth.auth().signOut()
//                    let registerView = RegisterViewController()
//                    self.present(registerView, animated: false, completion: nil)
//
//                    //self.goToPage(identifier: "registerViewController", direction: .forward, idx: 2)
//
//                } catch let signOutError as NSError {
//                    print ("Error signing out: %@", signOutError)
//                    return
//                }
//            }
//        }
//
//        let defaults = UserDefaults.standard
//        defaults.set(true, forKey: "hidePageControl")

        return
    }
    

    func goToPage(identifier: String, direction: UIPageViewControllerNavigationDirection, idx: Int) {
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

    @objc func changeDisplayName(sender:DisplayNameUIButton) {
        
        if (sender.firstName == nil && (sender.lastName?.text?.count)! == 0) {
            return
        }
        if (sender.lastName == nil && (sender.firstName?.text?.count)! == 0) {
            return
        }
        
        self.view.showActivityIndicator()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                let displayName = user.displayName!
                let displayNameArr = displayName.components(separatedBy: " ")
                
                var firstName = displayNameArr[0]
                var lastName = displayNameArr[1]
                
                if (sender.firstName == nil) {
                    lastName = (sender.lastName?.text)!.capitalizingFirstLetter()
                }
                if (sender.lastName == nil) {
                    firstName = (sender.firstName?.text)!.capitalizingFirstLetter()
                }
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = firstName + " " + lastName
                changeRequest.commitChanges { (error) in
                    if (sender.firstName == nil) {
                        sender.lastName?.text = ""
                        sender.lastName?.placeholder = "Saved!"
                    }
                    else if (sender.lastName == nil) {
                        sender.firstName?.text = ""
                        sender.firstName?.placeholder = "Saved!"
                    }
                    self.view.hideActivityIndicator()
                    return
                }
            }
            else {
                // POP UP MODAL TELLING THEM TO LOG IN AGAIN
            }
        }
    }
    
    @objc func changeValueRequiringReauthentication(sender: AuthenticateRequiredUIButton!) {
        
        if (sender.email == nil && sender.password?.text?.count == 0){
            return
        }
        if (sender.password == nil && sender.password?.text?.count == 0) {
            return
        }
        if (sender.password == nil && !isValidEmail(testStr: (sender.email?.text)!)) {
            sender.email?.text = ""
            sender.email?.attributedPlaceholder = NSAttributedString(string: "Invalid Email",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
            return
        }
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 1
        view.addSubview(blurEffectView)
        
        let customViewFrame = CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 150, y: UIViewController.SCRN_HEIGHT*0.5 - 120, width: 300, height: 240)
        reauthenticateView = UIView(frame: customViewFrame)
        
        reauthenticateView.backgroundColor = UIViewController.SCRN_GREY_LIGHT
        reauthenticateView.layer.cornerRadius = 5
        reauthenticateView.layer.masksToBounds = true
        view.addSubview(reauthenticateView)
        
        reauthenticateView.isHidden = false
        
        let reauthenticateLabel = createUILabel(backgroundColor: .clear,
                                                textColor: UIViewController.SCRN_MAIN_COLOR,
                                                labelText: "Confirm your current password to perform this action",
                                                fontSize: 18,
                                                fontName: UIViewController.SCRN_FONT_MEDIUM,
                                                cornerRadius: 0,
                                                frame: CGRect(x: 30, y: 15, width: reauthenticateView.frame.width - 60, height: 70))
        let reenterPasswordTextField = createUITextField(placeholder: "Current Password",
                                                         textColor: UIViewController.SCRN_MAIN_COLOR,
                                                         bottomLineColor: UIViewController.SCRN_MAIN_COLOR,
                                                         isSecureTextEntry: true,
                                                         frame: CGRect(x: 35, y: reauthenticateView.frame.height*0.5, width: reauthenticateView.frame.width - 70, height: 30))
        reenterPasswordTextField.font = UIFont(name: UIViewController.SCRN_FONT_MEDIUM, size: 16)
        
        let saveButton = AuthenticateRequiredUIButton(frame: CGRect(x: reauthenticateView.frame.width*0.5 - 50, y: reauthenticateView.frame.height - 60, width: 100, height: 35))
        saveButton.contentHorizontalAlignment = .center
        saveButton.setTitleColor(UIViewController.SCRN_WHITE, for: .normal)
        saveButton.titleLabel?.font = UIFont(name: UIViewController.SCRN_FONT_MEDIUM, size: 22)
        saveButton.backgroundColor = UIViewController.SCRN_MAIN_COLOR
        saveButton.layer.cornerRadius = 5
        saveButton.layer.masksToBounds = true
        saveButton.setTitle("Save", for: .normal)
        saveButton.email = sender.email
        saveButton.password = sender.password
        saveButton.confirmPassword = reenterPasswordTextField
        saveButton.tag = sender.tag
        saveButton.addTarget(self, action: #selector(reauthenticateAndChangeValue), for: .touchUpInside)
        
        reauthenticateView.layer.borderColor = UIViewController.SCRN_MAIN_COLOR.cgColor
        reauthenticateView.layer.borderWidth = 1.0
        
        reauthenticateView.addSubview(reauthenticateLabel)
        reauthenticateView.addSubview(reenterPasswordTextField)
        reauthenticateView.addSubview(saveButton)
        
        
        
        
        
        
        
    }
    
    @objc func reauthenticateAndChangeValue(sender: AuthenticateRequiredUIButton) {
        
        self.view.showActivityIndicator()
        let user = Auth.auth().currentUser
        
        let confirmedPassword = sender.confirmPassword?.text
        let credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: confirmedPassword!)
        
        user?.reauthenticate(with: credential){ error in
            if error != nil {
                sender.confirmPassword?.text = ""
                sender.confirmPassword?.attributedPlaceholder = NSAttributedString(string: "Incorrect Password",
                                                                                   attributes: [NSAttributedStringKey.foregroundColor: UIViewController.SCRN_INVALID_INPUT_RED])
            } else {
                if (sender.tag == 1){
                    Auth.auth().currentUser?.updateEmail(to: (sender.email?.text)!) { (error) in
                        sender.email?.text = ""
                        sender.email?.placeholder = "Saved!"
                        //Send confirmation email
                    }
                }
                else if (sender.tag == 2) {
                    Auth.auth().currentUser?.updatePassword(to: (sender.password?.text)!) { (error) in
                        sender.password?.text = ""
                        sender.password?.placeholder = "Saved!"
                        //Send confirmation email
                        
                    }
                }
                self.view.hideActivityIndicator()
                self.hideReAuthenticatePopup()
                return
            }
        }
    }
    
    @objc func buttonPressed(sender: UIButton!) {
        //sender.backgroundColor = UIColor(rgb: 0x2B7A78)
        switch sender.tag {
        case 1:
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "hidePageControl")
            let cur = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UIViewController.SIGN_UP_VC)
            self.show(cur, sender: self)
            break
        case 2:
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "hidePageControl")
            let cur = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UIViewController.LOGIN_VC)
            self.show(cur, sender: self)
            break
        case 3:
            let cur = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UIViewController.SETTINGS_VC)
            self.show(cur, sender: self)
            break
        case 4:
            var candidate: UIViewController = self
            while true {
                if let pageViewController = candidate as? MainPageController {
                    let mainVC = MainPageController()
                    pageViewController.setViewControllers([mainVC], direction: .reverse, animated: true, completion: nil)
                    break
                }
                guard let next = parent else { break }
                candidate = next
            }
            break
        case 5:
            let cur = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UIViewController.RESTAURANT_INFO_VC)
            self.show(cur, sender: self)
            break
        default: print("default")
            break
        }
    }
    
    @objc func openReportBug(sender: UIButton!) {
        
        let coverView = UIView(frame: CGRect(x: 0, y: 0, width: UIViewController.SCRN_WIDTH, height: UIViewController.SCRN_HEIGHT))
        coverView.backgroundColor = UIViewController.SCRN_GREY_LIGHT_LIGHT
        
        tempView.addSubview(coverView)
    
        let titleLabel = createUILabel(backgroundColor: .clear, textColor: UIViewController.SCRN_BLACK, labelText: "Report a Bug", fontSize: 24, fontName: UIViewController.SCRN_FONT_BOLD, cornerRadius: 0, frame: CGRect(x: 30, y: 40, width: UIViewController.SCRN_WIDTH - 60, height: 30))
        titleLabel.textAlignment = .left
        tempView.addSubview(titleLabel)
        
        let descriptionLabel = createUILabel(backgroundColor: .clear, textColor: UIViewController.SCRN_MAIN_COLOR, labelText: "Please describe the bug as accurately as possible with any steps taken that led to the bug!", fontSize: 16, fontName: UIViewController.SCRN_FONT_BOLD, cornerRadius: 0, frame: CGRect(x: 30, y: 80, width: UIViewController.SCRN_WIDTH - 60, height: 60))
        descriptionLabel.textAlignment = .left
        tempView.addSubview(descriptionLabel)
        
//        let responseField = UITextField(frame: CGRect(x: 30, y: 115, width: UIViewController.SCRN_WIDTH - 60, height: 200))
//        responseField.placeholder = "Description"
//        responseField.textAlignment = .left
//        responseField.textColor = UIViewController.SCRN_BLACK
//        responseField.layer.borderColor = UIViewController.SCRN_BLACK.cgColor
//        responseField.layer.borderWidth = 1.0
//        tempView.addSubview(responseField)
        
        UIView.animate(withDuration: 0.30, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.bringSubview(toFront: self.tempView)
            self.tempView.frame = CGRect(x: 0, y: 50, width: UIViewController.SCRN_WIDTH, height: UIViewController.SCRN_HEIGHT + 200)
            self.tempBackgroundLabel.frame = CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 20, y: 40, width: 40, height: 5)
        }, completion: { finished in
        })
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        tempView.addGestureRecognizer(swipeDown)
        
    }
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                UIView.animate(withDuration: 0.35, delay: 0.1, options: .curveEaseOut, animations: {
                    self.tempView.frame = CGRect(x: 0, y:UIViewController.SCRN_HEIGHT, width: UIViewController.SCRN_WIDTH - 10, height: UIViewController.SCRN_HEIGHT - 90)
                    self.tempBackgroundLabel.frame = CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 20, y: UIViewController.SCRN_HEIGHT, width: 40, height: 5)
                }, completion: { finished in
                })
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
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
