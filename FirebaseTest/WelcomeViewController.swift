//
//  WelcomeViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 8/27/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit
import QuartzCore

class WelcomeViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        createWelcomeView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Function Name: createWelcomeView()
     * Return Type: None
     * Parameters: None
     * Description: Create the view for our welcome screen. This is the first screen that
     * users see after launching the app if they have never opened the app before
     */
    
    func createWelcomeView() {
       // let defaults = UserDefaults.standard
       // defaults.set(false, forKey: "hidePageControl")
        
        _ = self.createUILabel(backgroundColor: .clear,
                               textColor: UIViewController.SCRN_MAIN_COLOR,
                               labelText: "foodMi",
                               fontSize: 86.0,
                               fontName: "DINCondensed-Bold",
                               cornerRadius: 0,
                               frame: CGRect(x: 0, y: UIViewController.SCRN_HEIGHT*0.5 - 150, width: UIViewController.SCRN_WIDTH, height: 86))
        _ = self.createUIImage(imageName: "logo",
                               imageFrame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 / 2, y: UIViewController.SCRN_HEIGHT*0.5 - 80, width: UIViewController.SCRN_WIDTH*0.5, height: UIViewController.SCRN_WIDTH*0.5 - 50))
    }

    /* Function Name: goToLastPage()
     * Return Type: None
     * Parameters: This function takes in 1 parameter
     *             _sender: UIButton -> The UIButton that sent this action
     * Description: DO NOT DELETE THIS
     */
    @IBAction func goToLastPage(_ sender: UIButton) {
        goToPage(identifier: "registerViewController", direction: .forward, idx: 2)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
