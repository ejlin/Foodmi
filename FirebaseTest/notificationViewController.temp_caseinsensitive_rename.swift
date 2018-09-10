//
//  NotificationViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 9/5/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit

class notificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar(withIdentifier: "notification")
        createNotificationView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNotificationView() {
        let backImage = UIImage(named: "notification_red")
        let backButton = UIButton(frame: CGRect(x: 25, y: 50, width: 36, height: 36))
        backButton.setImage(backImage, for: UIControlState.normal)
        //backButton.addTarget(self, action:#selector(buttonPressed), for:.touchUpInside)
        
        let notificationsLabel = self.createUILabel(backgroundColor: .clear,
                                               textColor: UIViewController.SCRN_BLACK,
                                               labelText: "Notifications",
                                               fontSize: 24,
                                               fontName: UIViewController.SCRN_FONT_BOLD,
                                               cornerRadius: 18,
                                               frame: CGRect(x: 80, y: 50, width: 130, height: 36))
        notificationsLabel.textAlignment = .left
        
        _ = self.createUILabel(backgroundColor: UIViewController.SCRN_GREY_LIGHT, textColor: .clear, labelText: "", fontSize: 0, fontName: UIViewController.SCRN_FONT_MEDIUM, cornerRadius: 0, frame: CGRect(x: 0, y: 102, width: Int(UIViewController.SCRN_WIDTH), height: 1))
        
        self.view.addSubview(backButton)
        self.view.addSubview(notificationsLabel)
    }
    
    
    @objc func buttonPressed(sender: UIButton!) {
        
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
