//
//  FeedViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 9/3/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var feedScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedScrollView.contentSize = CGSize(width: UIViewController.SCRN_WIDTH, height: UIViewController.SCRN_HEIGHT - 82)
        feedScrollView.bounces = (feedScrollView.contentOffset.y > 100);
        
        createFeedView()
        self.hideKeyboardWhenTappedAround()
        
        self.createNavigationBar(withIdentifier: "feed")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createFeedView() {
        
//        let feedSearchBar = UISearchBar(frame: CGRect(x: 20, y: 50, width: UIViewController.SCRN_WIDTH - 80, height: 40))
//        feedSearchBar.placeholder = "Search Feed"
//        let textFieldInsideSearchBar = feedSearchBar.value(forKey: "searchField") as? UITextField
//        textFieldInsideSearchBar?.frame = CGRect(x: 0, y: 0, width: UIViewController.SCRN_WIDTH, height: 40)
//        feedSearchBar.searchBarStyle = .minimal
        
        let cameraImage = UIImage(named: "camera")
        let cameraButton = UIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 55, y: 50, width: 35, height: 35))
        cameraButton.setImage(cameraImage, for: UIControlState.normal)
        //inviteFriendsButton.addTarget(self, action:#selector(changeDisplayName), for:.touchUpInside)
        
        let newsFeedLabel = createUILabel(backgroundColor: .clear, textColor: UIViewController.SCRN_GREY_LIGHT, labelText: "No Posts to Show", fontSize: 24, fontName: UIViewController.SCRN_FONT_BOLD, cornerRadius: 0, frame: CGRect(x: 50, y: UIViewController.SCRN_HEIGHT*0.5, width: UIViewController.SCRN_WIDTH - 100, height: 30))
        
        //feedScrollView.addSubview(feedSearchBar)
        feedScrollView.addSubview(cameraButton)
        feedScrollView.addSubview(newsFeedLabel)
        
        
        
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
