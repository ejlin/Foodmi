//
//  MainPageController.swift
//  FirebaseTest
//
//  Created by Xinrui Zhou on 8/30/18.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit

class MainPageController: UIPageViewController, UIScrollViewDelegate
{
    init(transitionStyle style: UIPageViewControllerTransitionStyle) {
        super.init(transitionStyle: style, navigationOrientation: .horizontal, options: nil)
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //var welcomeLabel: UILabel!
    fileprivate var currentIndex = 0
    fileprivate var lastPosition: CGFloat = 0
    fileprivate var lastPage: Bool = false
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: UIViewController.MAIN_PAGE_VC),
            self.getViewController(withIdentifier: UIViewController.PROFILE_VC),
            self.getViewController(withIdentifier: UIViewController.SETTINGS_VC)
        ]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        
        let mainVC = pages.first
        setViewControllers([mainVC!], direction: .forward, animated: false, completion: nil)
        currentIndex = 0
        
        for view in view.subviews {
            if view is UIScrollView {
                (view as! UIScrollView).delegate =  self
                break
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
        //currentIndex = 2
    }
    
    func goSpecificPageNoAnimate(withIdentifier identifier: String, direction direct: UIPageViewControllerNavigationDirection, index ind: Int)
    {
        var cur: UIViewController!
        if (ind == -1 || ind >= pages.count){
            cur = self.getViewController(withIdentifier: identifier)
        }
        else {
            cur = pages[ind]
        }
        
        self.setViewControllers([cur], direction: direct, animated: false, completion: nil)
        currentIndex = ind
        lastPage = true
    }
    
    func pageViewController(_ mainPageController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
//        if (lastPage) {
//            return
//        }
        if completed {
            let pageContentViewController = mainPageController.viewControllers![0]
            currentIndex = pages.index(of: pageContentViewController)!
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        if (lastPage){
//            return
//        }
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

extension MainPageController: UIPageViewControllerDataSource
{
    func pageViewController(_ mainPageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0          else { return nil }
        
        guard pages.count > previousIndex else { return nil }
        //lastPage = false
        return pages[previousIndex]
    }
    
    func pageViewController(_ mainPageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return nil }
        
        guard pages.count > nextIndex else { return nil }
        //lastPage = false
        return pages[nextIndex]
    }
}

extension MainPageController: UIPageViewControllerDelegate { }

