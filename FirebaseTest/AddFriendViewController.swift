//
//  AddFriendViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 9/5/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddFriendViewController: UIViewController {

    private var coverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createAddFriendView()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createAddFriendView() {
        let friendSearchBar = UISearchBar(frame: CGRect(x: 20, y: 50, width: UIViewController.SCRN_WIDTH - 80, height: 40))
        friendSearchBar.placeholder = "Search for Friends"
        let textFieldInsideSearchBar = friendSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.frame = CGRect(x: 0, y: 0, width: UIViewController.SCRN_WIDTH, height: 40)
        friendSearchBar.searchBarStyle = .minimal
        textFieldInsideSearchBar?.addTarget(self, action: #selector(searchFriends), for: .editingChanged)
        
        let closeImage = UIImage(named: "close")
        let closeButton = UIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 55, y: 52, width: 35, height: 35))
        closeButton.setImage(closeImage, for: UIControlState.normal)
        closeButton.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        
        coverView = UIView(frame: CGRect(x: 0, y: 90, width: UIViewController.SCRN_WIDTH, height: UIViewController.SCRN_HEIGHT - 90))
        view.addSubview(coverView!)
        view.addSubview(friendSearchBar)
        view.addSubview(closeButton)
    }
    
    @objc func searchFriends(textField: UITextField) {
        
        for subview in coverView.subviews {
            subview.removeFromSuperview()
        }
        
        let searchEntry = textField.text!
        print(searchEntry)
        if (searchEntry == ""){
            return
        }
        
        let formattedSearchEntry = searchEntry.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let ref = Database.database().reference()
        ref.child("users_id").queryOrdered(byChild: "name/name").queryStarting(atValue: formattedSearchEntry , childKey: "name").queryEnding(atValue: formattedSearchEntry + "\u{f8ff}", childKey: "name").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let result = snapshot.value as? NSDictionary
            var count = 0
            if (result != nil) {
                for (key, value) in result! {
                    let valueResult = value as? [String: Any]
                    let valueResultDict = valueResult!["name"]! as? NSDictionary
                    print(valueResultDict!["name"]!)
                    
                    let nameLabel = self.createUILabel(backgroundColor: .clear, textColor: UIViewController.SCRN_BLACK, labelText: "\(valueResultDict!["name"]!)", fontSize: 18, fontName: UIViewController.SCRN_FONT_BOLD, cornerRadius: 0, frame: CGRect(x: 30, y: 40*count, width: Int(UIViewController.SCRN_WIDTH - 60), height: 40))
                    nameLabel.textAlignment = .left
                    count = count + 1
                    let nameLabelBorder = self.createUILabel(backgroundColor: UIViewController.SCRN_GREY_LIGHT, textColor: .clear, labelText: "", fontSize: 0, fontName: UIViewController.SCRN_FONT_BOLD, cornerRadius: 0, frame: CGRect(x: 20, y: 40*count, width: Int(UIViewController.SCRN_WIDTH - 40), height: 1))
                    self.coverView.addSubview(nameLabel)
                    self.coverView.addSubview(nameLabelBorder)
                }
            }
            
            //let result = snapshot.value as? NSDictionary //[String : Any] ?? [:]
            
        }) { (err) in
            print(err)
        }
        
    }
    
    @objc func closeViewController() {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
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
