//
//  RegisterViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 8/27/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIScrollViewDelegate  {

    @IBOutlet weak var registerViewPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createRegisterView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
//        let defaults = UserDefaults.standard
//        let state = defaults.bool(forKey: "hidePageControl")
//        if (state && registerViewPageControl != nil) {
//            registerViewPageControl.removeFromSuperview()
//        }
        
        let signUpButton = createUIButton(textColor: .white,
                                          titleText: "Sign Up",
                                          fontName: UIViewController.SCRN_FONT_BOLD,
                                          fontSize: 20.0,
                                          alignment: .center,
                                          backgroundColor: UIViewController.SCRN_MAIN_COLOR,
                                          cornerRadius: 5,
                                          tag: 1,
                                          frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 150, y: UIViewController.SCRN_HEIGHT*0.5 + 185, width: 300, height: 50))
        signUpButton.addTarget(self,action:#selector(buttonPressed),
                               for:.touchUpInside)
        
        let loginButton = createUIButton(textColor: UIViewController.SCRN_MAIN_COLOR,
                                         titleText: "Login",
                                         fontName: UIViewController.SCRN_FONT_BOLD,
                                         fontSize: 20,
                                         alignment: .center,
                                         backgroundColor: .clear,
                                         cornerRadius: 5,
                                         tag: 2,
                                         frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 150, y: UIViewController.SCRN_HEIGHT*0.5 + 110, width: 300, height: 50))
        loginButton.addTarget(self,action:#selector(buttonPressed),
                              for:.touchUpInside)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIViewController.SCRN_MAIN_COLOR.cgColor
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
        default: print("default")
            break
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
