//
//  MainPageViewController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 8/27/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import GooglePlaces
import CoreLocation
import MaterialComponents.MDCActivityIndicator

class MainPageViewController: UIViewController,  CLLocationManagerDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate{

    @IBOutlet weak var restaurantScrollView: UIScrollView!
    @IBOutlet weak var mainPageRestaurantsScrollView: UIScrollView!

    private var restaurantView: UIView!
    private var restaurantBackgroundLabel: UILabel!
    private var priceSymbol = ["", "$", "$$", "$$$", "$$$$", "$$$$$"]
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantScrollView?.isHidden = true
        restaurantView?.isHidden = true
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        else {
            //NEED TO STOP ALL USER INTERACTION UNTIL ALLOWED
            return
        }
        
        mainPageRestaurantsScrollView.contentSize = CGSize(width: UIViewController.SCRN_WIDTH, height: 530)
        mainPageRestaurantsScrollView.bounces = (mainPageRestaurantsScrollView.contentOffset.y > 100);
        restaurantScrollView.contentSize = CGSize(width: UIViewController.SCRN_WIDTH - 10, height: UIViewController.SCRN_HEIGHT + 200)
        restaurantScrollView.bounces = (restaurantScrollView.contentOffset.y > 100);
        restaurantScrollView.delegate = self
        self.hideKeyboardWhenTappedAround()
        createMainPageView()
        self.createNavigationBar(withIdentifier: "main_page")

    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y > 0 {
            if (restaurantScrollView.contentOffset.y <= 0){
                UIView.animate(withDuration: 0.35, delay: 0.1, options: .curveEaseOut, animations: {
                    self.restaurantView.frame = CGRect(x: 5, y:UIViewController.SCRN_HEIGHT + 10, width: UIViewController.SCRN_WIDTH - 10, height: UIViewController.SCRN_HEIGHT - 90)
                    self.restaurantBackgroundLabel.frame = CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 20, y: UIViewController.SCRN_HEIGHT, width: 40, height: 5)
                }, completion: { finished in
                })
            }
            // swipes from top to bottom of screen -> down
        } else {
            // swipes from bottom to top of screen -> up
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Function Name: createMainPageView()
     * Return Type: None
     * Parameters: None
     * Description: This function will create the main page view for the user when they successfully log in.
     */
    func createMainPageView() {

        let coverView = UIView(frame: CGRect(x: 0, y: 150, width: UIViewController.SCRN_WIDTH, height: UIViewController.SCRN_HEIGHT - 150))
        coverView.backgroundColor = UIViewController.SCRN_WHITE
        
        let activityIndicator = MDCActivityIndicator(frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 25, y: UIViewController.SCRN_HEIGHT*0.5 - 100, width: 50, height: 50))
        activityIndicator.sizeToFit()
        coverView.addSubview(activityIndicator)
        activityIndicator.cycleColors = [UIViewController.SCRN_MAIN_COLOR]
        activityIndicator.startAnimating()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                let displayName = "Arow" //user.displayName!
                let displayNameArr = displayName.components(separatedBy: " ")
                let firstName = displayNameArr[0]
                
                let welcomeNameLabel = self.createUILabel(backgroundColor: .clear,
                                       textColor: UIViewController.SCRN_BLACK,
                                       labelText: "Welcome " + firstName +  ",",
                                       fontSize: 24,
                                       fontName: UIViewController.SCRN_FONT_BOLD,
                                       cornerRadius: 0,
                                       frame: CGRect(x: 20, y: 70, width: 200, height: 24))
                welcomeNameLabel.textAlignment = .left
                
                let profileImage = UIImage(named: "notification")
                let settingsButton = UIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 65, y: 60, width: 35, height: 35))
                settingsButton.setImage(profileImage, for: UIControlState.normal)
                settingsButton.tag = 1
                //settingsButton.addTarget(self, action:#selector(self.buttonPressed), for:.touchUpInside)
                self.view.addSubview(settingsButton)
            } else {
                self.goToPage(identifier: "registerViewController", direction: .reverse, idx: 2)
                return
            }
        }
        
        let mainPageSearchBar = UISearchBar(frame: CGRect(x: 10, y: 110, width: UIViewController.SCRN_WIDTH - 22.5, height: 40))
        mainPageSearchBar.placeholder = "Search nearby restaurants"
        let textFieldInsideSearchBar = mainPageSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.frame = CGRect(x: 0, y: 0, width: UIViewController.SCRN_WIDTH, height: 40)
        mainPageSearchBar.searchBarStyle = .minimal
        self.view.addSubview(mainPageSearchBar)

        
        let topRecommendationLabel = self.createUILabel(backgroundColor: .clear,
                                                        textColor: UIViewController.SCRN_BLACK,
                                                        labelText: "Top Recommendation",
                                                        fontSize: 24,
                                                        fontName: UIViewController.SCRN_FONT_BOLD,
                                                        cornerRadius: 5,
                                                        frame: CGRect(x: 20, y: 0, width: UIViewController.SCRN_WIDTH - 40, height: 32))
        topRecommendationLabel.textAlignment = .left
        mainPageRestaurantsScrollView.addSubview(topRecommendationLabel)
        let restaurantBackground = self.createUIImage(imageName: "restaurant_background",
                                                      imageFrame: CGRect(x: 20, y: 45, width: UIViewController.SCRN_WIDTH - 40, height: 180))
        restaurantBackground.layer.cornerRadius = 5
        restaurantBackground.clipsToBounds = true
        mainPageRestaurantsScrollView.addSubview(restaurantBackground)
        
        let topRestaurantBackgroundImage = UIImage(named: "restaurant_background")
        let topRestaurantBackgroundButton = RestaurantUIButton(frame: CGRect(x: 20, y: 45, width: UIViewController.SCRN_WIDTH - 40, height: 180))
        topRestaurantBackgroundButton.layer.cornerRadius = 5
        topRestaurantBackgroundButton.layer.masksToBounds = true
        topRestaurantBackgroundButton.setImage(topRestaurantBackgroundImage, for: UIControlState.normal)
        topRestaurantBackgroundButton.tag = 2
        mainPageRestaurantsScrollView.addSubview(topRestaurantBackgroundButton)
        
        let topFiveRestaurantsLabel = self.createUILabel(backgroundColor: .clear,
                                                         textColor: UIViewController.SCRN_BLACK,
                                                         labelText: "Top 5 by Rating",
                                                         fontSize: 22,
                                                         fontName: UIViewController.SCRN_FONT_BOLD,
                                                         cornerRadius: 5,
                                                         frame: CGRect(x: 20, y: 275, width: UIViewController.SCRN_WIDTH - 40, height: 32))
        topFiveRestaurantsLabel.textAlignment = .left
        mainPageRestaurantsScrollView.addSubview(topFiveRestaurantsLabel)
        
        let topFiveRestaurantsOneImage = self.createUIImage(imageName: "graphic_1",
                                                            imageFrame: CGRect(x: 20, y: 320, width: UIViewController.SCRN_WIDTH - 40, height: 180))
        topFiveRestaurantsOneImage.layer.cornerRadius = 5
        topFiveRestaurantsOneImage.clipsToBounds = true
        mainPageRestaurantsScrollView.addSubview(topFiveRestaurantsOneImage)

        lookUpCurrentLocation { geoLoc in
            let currentLocationName = (geoLoc?.name)!
            let currentLocationCity = (geoLoc?.locality)!
            let addressLabelText = currentLocationName + ", \(currentLocationCity)"
            
            let addressLabel = self.createUILabel(backgroundColor: .clear,
                                                  textColor: UIViewController.SCRN_MAIN_COLOR,
                                                  labelText: addressLabelText,
                                                  fontSize: 14,
                                                  fontName: UIViewController.SCRN_FONT_BOLD,
                                                  cornerRadius: 4,
                                                  frame: CGRect(x: 25, y: 155, width: UIViewController.SCRN_WIDTH - 50, height: 15))
            addressLabel.textAlignment = .right
            
            if let latitude = geoLoc?.location?.coordinate.latitude {
                if  let longitude = geoLoc?.location?.coordinate.longitude{
                        let zomatoPlacesNearbyURL = "https://developers.zomato.com/api/v2.1/geocode?" +
                            "lat=\(String(describing: latitude))&lon=\(String(describing: longitude))&apikey=" + UIViewController.ZOMATO_KEY
                        
                        URLSession.shared.dataTask(with: NSURL(string: zomatoPlacesNearbyURL)! as URL) { data, response, error in
                            if error != nil {
                                print(error!)
                            } else {
                                do {
                                    var currRating = 0.0
                                    var currRestaurant = ""
                                    //var currRestaurantPhotoReference = ""
                                    var currPricePoint: Any!
                                    var currRestaurantID: Any!
                                    
                                    
                                    let dictionary = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                                    if let items = dictionary["nearby_restaurants"] as? [[String:Any]] {
                                        DispatchQueue.main.async{
                                            for item in items {
                                                if let restaurant = item["restaurant"] as? [String: Any] {
                                                    if let currRatingParent = restaurant["user_rating"]! as? [String:Any]{
                                                        if ((currRatingParent["aggregate_rating"] as! NSString).doubleValue > currRating){
                                                            currRating = (currRatingParent["aggregate_rating"] as! NSString).doubleValue
                                                            currRestaurant = restaurant["name"]! as! String
                                                            currPricePoint = restaurant["price_range"]
                                                            if let currRestaurantIDParent = restaurant["R"] as? [String:Any] {
                                                                currRestaurantID = currRestaurantIDParent["res_id"]
                                                                topRestaurantBackgroundButton.resId = "\(currRestaurantIDParent["res_id"]!)"
                                                                topRestaurantBackgroundButton.addTarget(self, action:#selector(self.displayRestaurant), for:.touchUpInside)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            //DispatchQueue.global().async {
                                            //  let zomatoRestaurantURL = "https://developers.zomato.com/api/v2.1/restaurant?res_id=\(currRestaurantID!)" +
                                            //                            "&apikey=" + ZOMATO_KEY
                                            //  URLSession.shared.dataTask(with: NSURL(string: zomatoRestaurantURL)! as URL) { data, response, error in
                                            //      if error != nil {
                                            //          print(error!)
                                            //      } else {
                                            //          do {
                                            //              let results = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                                            //              let photoImageURL = URL(string: results["thumb"] as! String)
                                            //              let data = try? Data(contentsOf: photoImageURL!)
                                            //              DispatchQueue.main.async {
                                            //                  let currRestaurantBackgroundImage = UIImage(data: data!)
                                            //                  let currRestaurantButton = UIButton(frame: CGRect(x: 20,
                                            //                                                      y: 185,
                                            //                                                      width: self.SCRN_WIDTH - 40,
                                            //                                                      height: 150))
                                            //                  currRestaurantButton.setImage(currRestaurantBackgroundImage, for: UIControlState.normal)
                                            //                  forwardButton.addTarget(self, action:#selector(loginButtonPressed), for:.touchUpInside)
                                            //                  self.view.addSubview(currRestaurantButton)
                                            //              }
                                            //          } catch {
                                            //              print(error)
                                            //          }
                                            //      }
                                            //  }.resume()
                                            //}
                                            
                                        let currPricePointString = self.priceSymbol[currPricePoint as! Int]
                                            
                                        let currRestaurantRatingLabel = self.createUILabel(backgroundColor: .clear,
                                                                                           textColor: UIViewController.SCRN_MAIN_COLOR,
                                                                                           labelText: String(currRating),
                                                                                           fontSize: 20,
                                                                                           fontName: UIViewController.SCRN_FONT_BOLD,
                                                                                           cornerRadius: 0,
                                                                                           frame: CGRect(x: 20, y: 230, width: 30, height: 24))
                                        self.mainPageRestaurantsScrollView.addSubview(currRestaurantRatingLabel)
                                        let currRestaurantLabel = self.createUILabel(backgroundColor: .clear,
                                                                                     textColor: UIViewController.SCRN_GREY,
                                                                                     labelText: currRestaurant,
                                                                                     fontSize: 20,
                                                                                     fontName: UIViewController.SCRN_FONT_BOLD,
                                                                                     cornerRadius: 0,
                                                                                     frame: CGRect(x: 60, y: 230, width: UIViewController.SCRN_WIDTH - 150, height: 24))
                                        currRestaurantLabel.textAlignment = .left
                                        self.mainPageRestaurantsScrollView.addSubview(currRestaurantLabel)
                                            
                                        let currPricePointLabel = self.createUILabel(backgroundColor: .clear,
                                                                                     textColor: UIViewController.SCRN_MAIN_COLOR_DARK,
                                                                                     labelText: currPricePointString,
                                                                                     fontSize: 20,
                                                                                     fontName: UIViewController.SCRN_FONT_BOLD,
                                                                                     cornerRadius: 0,
                                                                                     frame: CGRect(x: UIViewController.SCRN_WIDTH - 90, y: 230, width: 70, height: 24))
                                        currPricePointLabel.textAlignment = .right
                                        self.mainPageRestaurantsScrollView.addSubview(currPricePointLabel)
                                        activityIndicator.stopAnimating()
                                        coverView.removeFromSuperview()
                                    }
                                }
                            } catch {
                                print("error")
                            }
                        }
                    }.resume()
                }
            }
        }
        self.view.hideActivityIndicator()
        restaurantScrollView?.layer.cornerRadius = 5
        restaurantScrollView?.layer.masksToBounds = true
        
        let customViewFrame = CGRect(x: 5,
                                     y:UIViewController.SCRN_HEIGHT + 40,
                                     width: UIViewController.SCRN_WIDTH - 10,
                                     height: UIViewController.SCRN_HEIGHT + 200)
        restaurantView = UIView(frame: customViewFrame)
        restaurantView.backgroundColor = UIViewController.SCRN_WHITE
        restaurantView.layer.cornerRadius = 8
        restaurantView.layer.masksToBounds = true
        restaurantScrollView.addSubview(restaurantView)
        
        
        restaurantBackgroundLabel = self.createUILabel(backgroundColor: UIViewController.SCRN_GREY,
                                                       textColor: .clear,
                                                       labelText: "",
                                                       fontSize: 0,
                                                       fontName: UIViewController.SCRN_FONT_MEDIUM,
                                                       cornerRadius: 3,
                                                       frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 20, y: UIViewController.SCRN_HEIGHT, width: 40, height: 5))
        view.addSubview(restaurantView)
        restaurantView.addSubview(restaurantScrollView)
        self.view.addSubview(restaurantBackgroundLabel)
        self.view.addSubview(coverView)
        

    }
    
    @objc func displayRestaurant(sender: RestaurantUIButton!) {
        
        let coverView = UIView(frame: CGRect(x: 0, y: 0, width: UIViewController.SCRN_WIDTH, height: UIViewController.SCRN_HEIGHT))
        coverView.backgroundColor = UIViewController.SCRN_GREY_LIGHT_LIGHT
        
        let activityIndicator = MDCActivityIndicator(frame: CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 25, y: UIViewController.SCRN_HEIGHT*0.5 - 75, width: 50, height: 50))
        activityIndicator.sizeToFit()
        coverView.addSubview(activityIndicator)
        activityIndicator.cycleColors = [UIViewController.SCRN_MAIN_COLOR]
        activityIndicator.startAnimating()
        restaurantView.addSubview(coverView)
        
        restaurantScrollView?.isHidden = false
        let resID = sender.resId!
        print(resID)
        
        let restaurantBackgroundImage = self.createUIImage(imageName: "restaurant_background",
                                               imageFrame: CGRect(x: 0, y: 0, width: UIViewController.SCRN_WIDTH - 10, height: UIViewController.SCRN_HEIGHT*0.5 - 100))

        restaurantScrollView.addSubview(restaurantBackgroundImage)
        
        let reserveButton = createUIButton(textColor: UIViewController.SCRN_MAIN_COLOR,
                                           titleText: "Make a Reservation",
                                           fontName: UIViewController.SCRN_FONT_BOLD,
                                           fontSize: 18,
                                           alignment: .center,
                                           backgroundColor: .clear,
                                           cornerRadius: 5,
                                           tag: -1,
                                           frame: CGRect(x: 20, y: UIViewController.SCRN_HEIGHT*0.5 - 40, width: 220, height: 45))
        reserveButton.layer.borderColor = UIViewController.SCRN_MAIN_COLOR.cgColor
        reserveButton.layer.borderWidth = 1.0
        
        restaurantScrollView.addSubview(reserveButton)
        
        let callButton = createUIButton(textColor: UIViewController.SCRN_WHITE,
                                             titleText: "Call",
                                             fontName: UIViewController.SCRN_FONT_BOLD,
                                             fontSize: 18,
                                             alignment: .center,
                                             backgroundColor: UIViewController.SCRN_MAIN_COLOR,
                                             cornerRadius: 5,
                                             tag: -1,
                                             frame: CGRect(x: UIViewController.SCRN_WIDTH - 115, y: UIViewController.SCRN_HEIGHT*0.5 - 40, width: 85, height: 45))
        restaurantScrollView.addSubview(callButton)
        
        UIView.animate(withDuration: 0.30, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.bringSubview(toFront: self.restaurantView)
            self.restaurantView.frame = CGRect(x: 5, y: 50, width: UIViewController.SCRN_WIDTH - 10, height: UIViewController.SCRN_HEIGHT + 200)
            self.restaurantBackgroundLabel.frame = CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 20, y: 40, width: 40, height: 5)
        }, completion: { finished in
        })
        
        let zomatoRestaurantURL = "https://developers.zomato.com/api/v2.1/restaurant?res_id=" + resID + "&apikey=" + UIViewController.ZOMATO_KEY
        URLSession.shared.dataTask(with: NSURL(string: zomatoRestaurantURL)! as URL) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    print(error!)
                } else {
                    do {
                        let results = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        let restaurantNamelabel = self.createUILabel(backgroundColor: .clear,
                                           textColor: UIViewController.SCRN_BLACK,
                                           labelText: "\(results["name"]!)",
                                           fontSize: 22,
                                           fontName: UIViewController.SCRN_FONT_BOLD,
                                           cornerRadius: 0,
                                           frame: CGRect(x: 60, y: UIViewController.SCRN_HEIGHT*0.5 - 80, width: UIViewController.SCRN_WIDTH - 120, height: 25))
                        restaurantNamelabel.textAlignment = .left
                        self.restaurantScrollView.addSubview(restaurantNamelabel)
                        
                        if let ratingParent = results["user_rating"] as? [String: Any]{
                            let ratingsLabel = self.createUILabel(backgroundColor: .clear,
                                                                  textColor: UIViewController.SCRN_MAIN_COLOR,
                                                                  labelText: "\(ratingParent["aggregate_rating"]!)",
                                                                  fontSize: 22,
                                                                  fontName: UIViewController.SCRN_FONT_BOLD,
                                                                  cornerRadius: 0,
                                                                  frame: CGRect(x: 20, y: UIViewController.SCRN_HEIGHT*0.5 - 80, width: 30, height: 25))
                            ratingsLabel.textAlignment = .left
                            self.restaurantScrollView.addSubview(ratingsLabel)
                        }
                        let currPricePoint = results["price_range"]
                        let currPricePointString = self.priceSymbol[currPricePoint as! Int]

                        let priceLabel = self.createUILabel(backgroundColor: .clear,
                                                            textColor: UIViewController.SCRN_MAIN_COLOR_DARK,
                                                            labelText: currPricePointString,
                                                            fontSize: 22,
                                                            fontName: UIViewController.SCRN_FONT_BOLD,
                                                            cornerRadius: 0,
                                                            frame: CGRect(x: UIViewController.SCRN_WIDTH - 80, y: UIViewController.SCRN_HEIGHT*0.5 - 80, width: 50, height: 25))
                        priceLabel.textAlignment = .right
                        self.restaurantScrollView.addSubview(priceLabel)
                        
                        if let localityParent = results["location"] as? [String: Any] {
                            let addressString = localityParent["address"] as! String
                            let address_label = self.createUILabel(backgroundColor: .clear,
                                                                   textColor: UIViewController.SCRN_BLACK,
                                                                   labelText: "Address:",
                                                                   fontSize: 16,
                                                                   fontName: UIViewController.SCRN_FONT_BOLD,
                                                                   cornerRadius: 0,
                                                                   frame: CGRect(x: 20, y: UIViewController.SCRN_HEIGHT*0.5 + 25, width: 130, height: 24))
                            address_label.textAlignment = .left
                            self.restaurantScrollView.addSubview(address_label)
                            
                            let addressArr = addressString.components(separatedBy: ", ")
                            let addressFirst = addressArr[0]
                            let addressSecond = addressArr[1]
                            
                            let addressFirstLabel = self.createUILabel(backgroundColor: .clear,
                                                                       textColor: UIViewController.SCRN_BLACK,
                                                                       labelText: addressFirst,
                                                                       fontSize: 16,
                                                                       fontName: UIViewController.SCRN_FONT_MEDIUM,
                                                                       cornerRadius: 0,
                                                                       frame: CGRect(x: 20, y: UIViewController.SCRN_HEIGHT*0.5 + 50, width: 200, height: 25))
                            addressFirstLabel.textAlignment = .left
                            self.restaurantScrollView.addSubview(addressFirstLabel)
                            
                            let addressSecondLabel = self.createUILabel(backgroundColor: .clear,
                                                                        textColor: UIViewController.SCRN_BLACK,
                                                                        labelText: addressSecond,
                                                                        fontSize: 16,
                                                                        fontName: UIViewController.SCRN_FONT_MEDIUM,
                                                                        cornerRadius: 0,
                                                                        frame: CGRect(x: 20, y: UIViewController.SCRN_HEIGHT*0.5 + 75, width: 200, height: 25))
                            addressSecondLabel.textAlignment = .left
                            self.restaurantScrollView.addSubview(addressSecondLabel)
                            
                            let mapImage = UIImage(named: "map")
                            let mapButton = MapUIButton(frame: CGRect(x: UIViewController.SCRN_WIDTH - 85, y: UIViewController.SCRN_HEIGHT*0.5 + 40, width: 50, height: 50))
                            mapButton.name = "\(results["name"]!)"
                            mapButton.latitude = "\(localityParent["latitude"]!)"
                            mapButton.longitude = "\(localityParent["longitude"]!)"
                            mapButton.setImage(mapImage, for: UIControlState.normal)
                            //mapButton.tag = 1
                            mapButton.addTarget(self, action:#selector(self.openMaps), for:.touchUpInside)
                            self.restaurantScrollView.addSubview(mapButton)
                        }
                        if let cuisines = results["cuisines"] as? String{
                            let cuisinesArr = cuisines.components(separatedBy: ", ")
                            
                            var counter = 0
                            for descriptions in cuisinesArr {
                                if (counter < 3) {
                                    let cuisinesLabel = self.createUILabel(backgroundColor: .clear,
                                                                           textColor: UIViewController.SCRN_BLACK,
                                                                           labelText: descriptions,
                                                                           fontSize: 12,
                                                                           fontName: UIViewController.SCRN_FONT_BOLD,
                                                                           cornerRadius: 13,
                                                                           frame: CGRect(x: 20 + CGFloat(counter)*(((UIViewController.SCRN_WIDTH - 80) / 3) +  20), y: UIViewController.SCRN_HEIGHT*0.5 + 115, width: (UIViewController.SCRN_WIDTH - 80) / 3 , height: 25))
                                    cuisinesLabel.textAlignment = .center
                                    cuisinesLabel.layer.borderColor = UIViewController.SCRN_BLACK.cgColor
                                    cuisinesLabel.layer.borderWidth = 1.0
                                    self.restaurantScrollView.addSubview(cuisinesLabel)
                                    counter = counter + 1
                                }
                            }
                            while ( counter < 3) {
                                let cuisinesLabel = self.createUILabel(backgroundColor: .clear,
                                                                       textColor: UIViewController.SCRN_BLACK,
                                                                       labelText: "...",
                                                                       fontSize: 12,
                                                                       fontName: UIViewController.SCRN_FONT_BOLD,
                                                                       cornerRadius: 13,
                                                                       frame: CGRect(x: 20 + CGFloat(counter)*(((UIViewController.SCRN_WIDTH - 90) / 3) +  20), y: UIViewController.SCRN_HEIGHT*0.5 + 115, width: (UIViewController.SCRN_WIDTH - 90) / 3 , height: 25))
                                cuisinesLabel.textAlignment = .center
                                cuisinesLabel.layer.borderColor = UIViewController.SCRN_BLACK.cgColor
                                cuisinesLabel.layer.borderWidth = 1.0
                                self.restaurantScrollView.addSubview(cuisinesLabel)
                                counter = counter + 1
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
                activityIndicator.startAnimating()
                coverView.removeFromSuperview()
            }
        }.resume()
        
        
        let menuURL = "https://developers.zomato.com/api/v2.1/dailymenu?res_id=" + resID + "&apikey=" + UIViewController.ZOMATO_KEY
        
        URLSession.shared.dataTask(with: NSURL(string: menuURL)! as URL) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    print(error!)
                } else {
                    do {
                        let results = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        print(results)
                    } catch {
                        print(error)
                    }
                }
            }
        }.resume()
        let openTableLabel = self.createUIButton(textColor: UIViewController.SCRN_WHITE,
                                                 titleText: "Open a Table",
                                                 fontName: UIViewController.SCRN_FONT_BOLD,
                                                 fontSize: 18,
                                                 alignment: .center,
                                                 backgroundColor: UIViewController.SCRN_MAIN_COLOR,
                                                 cornerRadius: 5,
                                                 tag: -1,
                                                 frame: CGRect(x: 75, y: UIViewController.SCRN_HEIGHT*0.5 + 170, width: UIViewController.SCRN_WIDTH - 160, height: 50))
        self.restaurantScrollView.addSubview(openTableLabel)

    }
    
    

    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            //
            print("Swipe Right")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            print("Swipe Up")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
            print("Swipe Down")
        }
    }
    
    @objc func openMaps(sender: MapUIButton) {
        let placeLatitude = (sender.latitude! as NSString).doubleValue
        let placeLongitude = (sender.longitude! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2DMake(placeLatitude, placeLongitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = sender.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseOut, animations: {
                    self.restaurantView.frame = CGRect(x: 5, y:UIViewController.SCRN_HEIGHT - 10, width: UIViewController.SCRN_WIDTH - 10, height: UIViewController.SCRN_HEIGHT - 90)
                    self.restaurantBackgroundLabel.frame = CGRect(x: UIViewController.SCRN_WIDTH*0.5 - 20, y: UIViewController.SCRN_HEIGHT, width: 40, height: 5)
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
    
    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) -> CLLocationCoordinate2D {
        return (manager.location?.coordinate)!
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
    @objc func buttonPressed(sender: UIButton!) {
        //sender.backgroundColor = UIColor(rgb: 0x2B7A78)
        switch sender.tag {
        case 1:
            let cur = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UIViewController.SETTINGS_VC)
            self.show(cur, sender: self)
            break
        case 2:
            let cur = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UIViewController.RESTAURANT_INFO_VC)
            self.show(cur, sender: self)
            break
        default: print("default")
            break
        }
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
