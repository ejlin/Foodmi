//
//  ProfileViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 8/31/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import FirebaseAuth
import FirebaseStorage
import UIKit
import AVKit
import PhotosUI
import MaterialComponents.MDCActivityIndicator
import Kingfisher

class ProfileViewController: UIViewController{

    @IBOutlet weak var profileScrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        profileScrollView.contentSize = CGSize(width: UIViewController.SCRN_WIDTH, height: UIViewController.SCRN_HEIGHT + 200)
        profileScrollView.bounces = (profileScrollView.contentOffset.y > 100);
        createProfileView()
        self.createNavigationBar(withIdentifier: "profile")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createProfileView() {
        
//        let coverView = UIView(frame: CGRect(x: 0, y: 0, width: UIViewController.SCRN_WIDTH, height: UIViewController.SCRN_HEIGHT))
//        coverView.backgroundColor = UIViewController.SCRN_WHITE
//
//        let activityIndicator = MDCActivityIndicator(frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 25, y: UIViewController.SCRN_HEIGHT*0.5 - 100, width: 50, height: 50))
//        activityIndicator.sizeToFit()
//        coverView.addSubview(activityIndicator)
//        activityIndicator.cycleColors = [UIViewController.SCRN_MAIN_COLOR]
//        activityIndicator.startAnimating()
        
        let backgroundImage = self.createUIButton(textColor: UIViewController.SCRN_GREY,
                                titleText: "Add a Cover Photo +",
                                fontName: UIViewController.SCRN_FONT_BOLD,
                                fontSize: 18,
                                alignment: .center,
                                backgroundColor: UIViewController.SCRN_GREY_LIGHT_LIGHT,
                                cornerRadius: 5,
                                tag: -1,
                                frame: CGRect(x: 0 , y: 0, width: UIViewController.SCRN_WIDTH, height: UIViewController.SCRN_HEIGHT*0.5 - 95))
        backgroundImage.addTarget(self, action: #selector(changeCoverPhoto), for: .touchUpInside)
        
        let profileImage = UIImage(named: "user")
        let profileButton = UIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 60, y: UIViewController.SCRN_HEIGHT*0.5 - 155, width: 120, height: 120))
        profileButton.layer.borderWidth = 2.0
        profileButton.layer.cornerRadius = 60
        profileButton.layer.borderColor = UIViewController.SCRN_WHITE.cgColor
        profileButton.setImage(profileImage!, for: UIControlState.normal)
        profileButton.addTarget(self, action: #selector(self.chooseProfilePicture), for: .touchUpInside)

        let profileImageOverlay = self.createUILabel(backgroundColor: UIViewController.SCRN_GREY_LIGHT, textColor: UIViewController.SCRN_MAIN_COLOR, labelText: "", fontSize: 0, fontName: UIViewController.SCRN_FONT_BOLD, cornerRadius: 0, frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 60, y: UIViewController.SCRN_HEIGHT*0.5 - 155, width: 120, height: 120))
        profileImageOverlay.layer.cornerRadius = 60
    
        let user = Auth.auth().currentUser
        if user != nil && user?.photoURL != nil{
            //let data = try? Data(contentsOf: (user?.photoURL!)!)
            profileButton.kf.setImage(with: user?.photoURL, for: UIControlState.normal)
            //profileButton.setImage(UIImage(data: data!)?.circle, for: UIControlState.normal)
            profileButton.layer.cornerRadius = min(profileButton.frame.height,profileButton.frame.width) / 2 //you can change the cornerRadius according to your need
            profileButton.layer.borderColor = UIColor.white.cgColor
            profileButton.layer.masksToBounds = true
        }
        
        
        let showMoreImage = UIImage(named: "show_more_button")
        let showMoreButton = UIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 40, y: 40, width: 25, height: 25))
        showMoreButton.setImage(showMoreImage, for: UIControlState.normal)
       // self.view.addSubview(showMoreButton)
        
        // self.view.addSubview(profileButton)
        
//        let openTable = self.createUIButton(textColor: UIViewController.SCRN_WHITE,
//                                            titleText: "Open a Table",
//                                            fontName: UIViewController.SCRN_FONT_BOLD,
//                                            fontSize: 15,
//                                            alignment: .center,
//                                            backgroundColor: UIViewController.SCRN_MAIN_COLOR,
//                                            cornerRadius: 15,
//                                            tag: -1,
//                                            frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 + 70,
//                                                          y: UIViewController.SCRN_HEIGHT*0.5 - 80,
//                                                          width: 100,
//                                                          height: 30))
//
//        let inviteFriends = self.createUIButton(textColor: UIViewController.SCRN_WHITE,
//                                                titleText: "Invite Friends",
//                                                fontName: UIViewController.SCRN_FONT_BOLD,
//                                                fontSize: 15,
//                                                alignment: .center,
//                                                backgroundColor: UIViewController.SCRN_MAIN_COLOR,
//                                                cornerRadius: 15,
//                                                tag: -1,
//                                                frame: CGRect(x: 20, y: UIViewController.SCRN_HEIGHT*0.5 - 80, width: 100, height: 30))
        
        
        let inviteFriendsImage = UIImage(named: "add_friend")
        let inviteFriendsButton = UIButton(frame: CGRect(x: 30, y: UIViewController.SCRN_HEIGHT*0.5 - 10, width: 40, height: 40))
        inviteFriendsButton.setImage(inviteFriendsImage, for: UIControlState.normal)
        //inviteFriendsButton.addTarget(self, action:#selector(changeDisplayName), for:.touchUpInside)
        
        let inviteFriendsLabel = createUILabel(backgroundColor: .clear, textColor: UIViewController.SCRN_MAIN_COLOR, labelText: "Add Friends", fontSize: 11, fontName: UIViewController.SCRN_FONT_BOLD, cornerRadius: 0, frame: CGRect(x: 20, y: UIViewController.SCRN_HEIGHT*0.5 + 35, width: 60, height: 12))

        
        let favoritesImage = UIImage(named: "favorites")
        let favoritesButton = UIButton(frame: CGRect(x: (UIViewController.SCRN_WIDTH - 220)/3 + 70, y: UIViewController.SCRN_HEIGHT*0.5 - 10, width: 40, height: 40))
        favoritesButton.setImage(favoritesImage, for: UIControlState.normal)
        //inviteFriendsButton.addTarget(self, action:#selector(changeDisplayName), for:.touchUpInside)
        
        let favoritesLabel = createUILabel(backgroundColor: .clear, textColor: UIViewController.SCRN_MAIN_COLOR, labelText: "Favorites", fontSize: 11, fontName: UIViewController.SCRN_FONT_BOLD, cornerRadius: 0, frame: CGRect(x: (UIViewController.SCRN_WIDTH - 220)/3 + 60, y: UIViewController.SCRN_HEIGHT*0.5 + 35, width: 60, height: 12))
        
        let historyImage = UIImage(named: "history")
        let historyButton = UIButton(frame: CGRect(x: 2*(UIViewController.SCRN_WIDTH - 220)/3 + 110, y: UIViewController.SCRN_HEIGHT*0.5 - 10, width: 40, height: 40))
        historyButton.setImage(historyImage, for: UIControlState.normal)
        //inviteFriendsButton.addTarget(self, action:#selector(changeDisplayName), for:.touchUpInside)
        
        let historyLabel = createUILabel(backgroundColor: .clear, textColor: UIViewController.SCRN_MAIN_COLOR, labelText: "History", fontSize: 11, fontName: UIViewController.SCRN_FONT_BOLD, cornerRadius: 0, frame: CGRect(x: 2*(UIViewController.SCRN_WIDTH - 220)/3 + 100, y: UIViewController.SCRN_HEIGHT*0.5 + 35, width: 60, height: 12))
        
        
        let openTableImage = UIImage(named: "open_table")
        let openTableButton = UIButton(frame: CGRect(x: 3*(UIViewController.SCRN_WIDTH - 220)/3 + 150, y: UIViewController.SCRN_HEIGHT*0.5 - 10, width: 40, height: 40))
        openTableButton.setImage(openTableImage, for: UIControlState.normal)
        //inviteFriendsButton.addTarget(self, action:#selector(changeDisplayName), for:.touchUpInside)
        
        let openTableLabel = createUILabel(backgroundColor: .clear, textColor: UIViewController.SCRN_MAIN_COLOR, labelText: "Open Table", fontSize: 11, fontName: UIViewController.SCRN_FONT_BOLD, cornerRadius: 0, frame: CGRect(x: 3*(UIViewController.SCRN_WIDTH - 220)/3 + 140, y: UIViewController.SCRN_HEIGHT*0.5 + 35, width: 60, height: 12))
        
        
        let addRecommendationsImage = UIImage(named: "add")
        let addRecommendationsButton = UIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 40, y: UIViewController.SCRN_HEIGHT*0.5 + 80, width: 20, height: 20))
        addRecommendationsButton.setImage(addRecommendationsImage, for: UIControlState.normal)
        //self.view.addSubview(addRecommendationsButton)
        
        let addRecentImage = UIImage(named: "add")
        let addRecentButton = UIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 40, y: UIViewController.SCRN_HEIGHT*0.5 + 380, width: 20, height: 20))
        addRecentButton.setImage(addRecentImage, for: UIControlState.normal)
        //self.view.addSubview(addRecentButton)
        
        let profilePicturesPlaceholderOne = self.createUILabel(backgroundColor: UIViewController.SCRN_GREY_LIGHT,
                                                               textColor: UIViewController.SCRN_GREY,
                                                               labelText: "Add +",
                                                               fontSize: 12,
                                                               fontName: UIViewController.SCRN_FONT_MEDIUM,
                                                               cornerRadius: 5,
                                                               frame: CGRect(x: 20,
                                                                             y: UIViewController.SCRN_HEIGHT*0.5 + 120,
                                                                             width: ((UIViewController.SCRN_WIDTH - 44) / 2),
                                                                             height: 240))
        
        let profilePicturesPlaceholderTwo = self.createUILabel(backgroundColor: UIViewController.SCRN_GREY_LIGHT,
                                                               textColor: UIViewController.SCRN_GREY,
                                                               labelText: "Add +",
                                                               fontSize: 12,
                                                               fontName: UIViewController.SCRN_FONT_MEDIUM,
                                                               cornerRadius: 5,
                                                               frame: CGRect(x: 26 + ((UIViewController.SCRN_WIDTH - 44) / 2),
                                                                             y: UIViewController.SCRN_HEIGHT*0.5 + 120,
                                                                             width: ((UIViewController.SCRN_WIDTH - 44) / 2),
                                                                             height: 117))
        
        let profilePicturesPlaceholderThree = self.createUILabel(backgroundColor: UIViewController.SCRN_GREY_LIGHT,
                                                                 textColor: UIViewController.SCRN_GREY,
                                                                 labelText: "Add +",
                                                                 fontSize: 12,
                                                                 fontName: UIViewController.SCRN_FONT_MEDIUM,
                                                                 cornerRadius: 5,
                                                                 frame: CGRect(x: 26 + ((UIViewController.SCRN_WIDTH - 44) / 2),
                                                                               y: UIViewController.SCRN_HEIGHT*0.5 + 243,
                                                                               width: ((UIViewController.SCRN_WIDTH - 44) / 2),
                                                                               height: 117))
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                let displayName = user.displayName!
                let displayNameArr = displayName.components(separatedBy: " ")
                let firstName = displayNameArr[0]
                
                let welcomeNameLabel = self.createUILabel(backgroundColor: .clear,
                                                          textColor: UIViewController.SCRN_BLACK,
                                                          labelText: firstName +  "'s Photos",
                                                          fontSize: 20,
                                                          fontName: UIViewController.SCRN_FONT_BOLD,
                                                          cornerRadius: 0,
                                                          frame: CGRect(x: 20, y: UIViewController.SCRN_HEIGHT*0.5 + 80, width: UIViewController.SCRN_WIDTH - 20, height: 20))
                welcomeNameLabel.textAlignment = .left
                self.profileScrollView.addSubview(welcomeNameLabel)
                
                let recommendationsLabel = self.createUILabel(backgroundColor: .clear,
                                                          textColor: UIViewController.SCRN_BLACK,
                                                          labelText: firstName +  "'s Recommendations",
                                                          fontSize: 20,
                                                          fontName: UIViewController.SCRN_FONT_BOLD,
                                                          cornerRadius: 0,
                                                          frame: CGRect(x: 20, y: UIViewController.SCRN_HEIGHT*0.5 + 380, width: UIViewController.SCRN_WIDTH - 20, height: 20))
                recommendationsLabel.textAlignment = .left
                self.profileScrollView.addSubview(recommendationsLabel)
            } else {
//                self.goToPage(identifier: "registerViewController", direction: .reverse, idx: 2)
//                return
            }
        }
        
        profileScrollView.addSubview(backgroundImage)
        profileScrollView.addSubview(profileImageOverlay)
        profileScrollView.addSubview(profileButton)
        profileScrollView.addSubview(showMoreButton)
        profileScrollView.addSubview(addRecommendationsButton)
        profileScrollView.addSubview(addRecentButton)
        profileScrollView.addSubview(inviteFriendsButton)
        profileScrollView.addSubview(inviteFriendsLabel)
        profileScrollView.addSubview(favoritesButton)
        profileScrollView.addSubview(favoritesLabel)
        profileScrollView.addSubview(historyButton)
        profileScrollView.addSubview(historyLabel)
        profileScrollView.addSubview(openTableButton)
        profileScrollView.addSubview(openTableLabel)
        profileScrollView.addSubview(profilePicturesPlaceholderOne)
        profileScrollView.addSubview(profilePicturesPlaceholderTwo)
        profileScrollView.addSubview(profilePicturesPlaceholderThree)
        
//        activityIndicator.stopAnimating()
//        coverView.removeFromSuperview()
    }
    
    
    @objc func chooseProfilePicture(sender: UIButton) {
            ImagePickerManager().pickImage(self){ image in
                let image = image.circle
                sender.setImage(image, for: UIControlState.normal) // = image
                sender.layer.opacity = 0.5
                
                DispatchQueue.main.async {
                    let activityIndicator = MDCActivityIndicator(frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 12, y: UIViewController.SCRN_HEIGHT*0.5 - 110, width: 50, height: 50))
                    activityIndicator.sizeToFit()
                    activityIndicator.cycleColors = [UIViewController.SCRN_MAIN_COLOR]
                    activityIndicator.startAnimating()
                    self.profileScrollView.addSubview(activityIndicator)
                    
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    let image = image.circle
                guard let imageData = UIImagePNGRepresentation(image) else {return}
                let profileImageReference = Storage.storage().reference().child("profile_image_url").child("\(uid).png")
                let uploadTask = profileImageReference.putData(imageData, metadata: nil) { (metadata, error) in
                    if let error = error {
                        print("here")
                        print(error.localizedDescription)
                    } else {
                        profileImageReference.downloadURL {url, error in
                            if let error = error {
                                //Handle any errors
                            } else {
                                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                    changeRequest?.photoURL = url
                                    changeRequest?.commitChanges { (error) in
                                        print("Worked")
                                        sender.layer.opacity = 1
                                        activityIndicator.stopAnimating()
                                }
                                // Get the download URL
                            }
                        }
                        //let downloadURL = metadata.downloadURL()?.absoluteString ?? ""
                        // Here you get the download url of the profile picture.
                    }
                }
                uploadTask.observe(.progress, handler: { (snapshot) in
                    print(snapshot.progress?.fractionCompleted ?? "")
                    // Here you can get the progress of the upload process.
                })
            }
        }
    }
    
    @objc func changeCoverPhoto(sender: UIButton) {
        ImagePickerManager().pickImage(self){ image in
            sender.setImage(image, for: UIControlState.normal) // = image
            //here is the image
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
