//
//  PageViewController.swift
//  FirebaseTest
//
//  Created by Eric Lin on 8/17/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class PageViewController: UIPageViewController, UIScrollViewDelegate
{
    //var welcomeLabel: UILabel!
    fileprivate var currentIndex = 0
    fileprivate var lastPosition: CGFloat = 0
    fileprivate var lastPage: Bool = false

    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: UIViewController.WELCOME_VC),
            self.getViewController(withIdentifier: UIViewController.GET_STARTED_VC),
            self.getViewController(withIdentifier: UIViewController.REGISTER_VC)
        ]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self

        if let firstVC = pages.first{
            setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
        
        for view in view.subviews {
            if view is UIScrollView {
                (view as! UIScrollView).delegate =  self
                break
            }
        }
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let _: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newPageViewController = MainPageController()
                //                    transitionStyle:
                //                    UIPageViewControllerTransitionStyle.scroll, navigationOrientation:
                //                    UIPageViewControllerNavigationOrientation.horizontal, options: nil)
                self.present(newPageViewController, animated: false, completion: nil)
                //                let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: UIViewController.MAIN_PAGE_VC)
                //                self.present(loggedInViewController, animated: false, completion: nil)
            } else {
            }
        }
    }
    
    /* Function Name: goSpecificPage()
     * Return Type: None
     * Parameters: Takes in two parameters -> A String identifier for the viewController we
     * are trying to access. A direction identifier for which direction we want our animation
     * to slide in.
     * Description: Allows us to jump to a specific view controller
     */
    
    func goSpecificPage(withIdentifier identifier: String, direction direct: UIPageViewControllerNavigationDirection, index ind: Int)
    {
        var cur: UIViewController!
        if (ind == -1 || ind >= pages.count){
            cur = self.getViewController(withIdentifier: identifier)
        }
        else {
            cur = pages[ind]
        }
        
        self.setViewControllers([cur], direction: direct, animated: true, completion: nil)
        currentIndex = 2
        lastPage = true
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if (lastPage) {
            return
        }
        if completed {
            let pageContentViewController = pageViewController.viewControllers![0]
            currentIndex = pages.index(of: pageContentViewController)!
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (lastPage){
            return
        }
        self.lastPosition = scrollView.contentOffset.x
        
        let totalViewControllersInPageController = pages.count

        if (currentIndex == totalViewControllersInPageController - 1) && (lastPosition > scrollView.frame.width) {
            scrollView.contentOffset.x = scrollView.frame.width
            return
            
        } else if currentIndex == 0 && lastPosition < scrollView.frame.width {
            scrollView.contentOffset.x = scrollView.frame.width
            return
        }    
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if (lastPage) {
            return
        }
        let totalViewControllersInPageController = pages.count

        self.lastPosition = scrollView.contentOffset.x

        if (currentIndex == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width) {
            scrollView.contentOffset.x = scrollView.frame.width
            return
        }
        else if (currentIndex == totalViewControllersInPageController - 1 && scrollView.contentOffset.x >= scrollView.bounds.size.width) {
            scrollView.contentOffset.x = scrollView.frame.width
            return
        }
    }
    
}

extension PageViewController: UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0          else { return nil }
        
        guard pages.count > previousIndex else { return nil }
        lastPage = false
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else { return nil }

        guard pages.count > nextIndex else { return nil }
        lastPage = false
        return pages[nextIndex]
    }
}

extension PageViewController: UIPageViewControllerDelegate { }

//extension FirstLaunch {
//
//    static func alwaysFirst() -> FirstLaunch {
//        return FirstLaunch(getWasLaunchedBefore: { return false }, setWasLaunchedBefore: { _ in })
//    }
//}
//
//let alwaysFirstLaunch = FirstLaunch.alwaysFirst()
//if alwaysFirstLaunch.isFirstLaunch {
//    // will always execute
//}

