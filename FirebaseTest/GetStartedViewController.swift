//
//  GetStartedViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 8/27/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        createGetStartedView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Function Name: createGetStartedView()
     * Return Type: None
     * Parameters: None
     * Description: Create the view for our tutorial screen. This is the second screen that
     * users see after launching the app if they have never opened the app before. This screen
     * will display to the users how to use the app.
     */
    
    func createGetStartedView() {
        _ = createUIImage(imageName: "restaurant",
                          imageFrame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 + 60, y: UIViewController.SCRN_HEIGHT*0.5 - 190, width: 60, height: 60))
        _ = createUIImage(imageName: "arrowPointBottom",
                          imageFrame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 + 10, y: UIViewController.SCRN_HEIGHT*0.5 - 110, width: 75, height: 75))
        _ = createUIImage(imageName: "ratings",
                          imageFrame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 85, y: UIViewController.SCRN_HEIGHT*0.5 - 10, width: 170, height: 30))
        _ = createUIImage(imageName: "arrowPointRight",
                          imageFrame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 80, y: UIViewController.SCRN_HEIGHT*0.5 + 90, width: 75, height: 75))
        _ = createUIImage(imageName: "recommendation",
                          imageFrame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 140, y: UIViewController.SCRN_HEIGHT*0.5 + 190, width: 60, height: 60))
        
        _ = createUILabel(backgroundColor: .clear,
                          textColor: UIViewController.SCRN_MAIN_COLOR,
                          labelText: "How It Works:",
                          fontSize: 30.0,
                          fontName: UIViewController.SCRN_FONT_BOLD,
                          cornerRadius: 0,
                          frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 100, y: UIViewController.SCRN_HEIGHT*0.5 - 275, width: 200, height: 50))
        _ = createUILabel(backgroundColor: UIViewController.SCRN_MAIN_COLOR,
                          textColor: UIViewController.SCRN_WHITE,
                          labelText: "Mark restaurants you've visited",
                          fontSize: 18.0,
                          fontName: UIViewController.SCRN_FONT_MEDIUM,
                          cornerRadius: 5,
                          frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 130, y: UIViewController.SCRN_HEIGHT*0.5 - 190, width: 160, height: 60))
        _ = createUILabel(backgroundColor: UIViewController.SCRN_MAIN_COLOR,
                          textColor: UIViewController.SCRN_WHITE,
                          labelText: "Rate them!",
                          fontSize: 18.0,
                          fontName: UIViewController.SCRN_FONT_MEDIUM,
                          cornerRadius: 5,
                          frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 85, y: UIViewController.SCRN_HEIGHT*0.5 + 30, width: 170, height: 40))
        _ = createUILabel(backgroundColor: UIViewController.SCRN_MAIN_COLOR,
                          textColor: UIViewController.SCRN_WHITE,
                          labelText: "Get restaurant recommendations",
                          fontSize: 18.0,
                          fontName: UIViewController.SCRN_FONT_MEDIUM,
                          cornerRadius: 5,
                          frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 60, y: UIViewController.SCRN_HEIGHT*0.5 + 190, width: 180, height: 60))
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
