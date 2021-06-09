//
//  LandingViewController.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var pageControl: UIPageControl!
    private var pageViewController: UIPageViewController!
    private var viewControllers = [UIViewController]()
    private let flightSource = FlightSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent()
    }

    private func loadContent() {
        flightSource.getFlights { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let models):
                let controllerBuilder = FlightControllerBuilder()
                self.viewControllers = models.map{controllerBuilder.flightController(model: $0)}
                self.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateUI() {
        guard let firstItem = viewControllers.first else {return}
        pageViewController.setViewControllers([firstItem],
                                              direction: .forward,
                                              animated: false,
                                              completion: nil)
        pageControl.isHidden = false
        pageControl.numberOfPages = viewControllers.count
        pageControl.currentPage = 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageDestination = segue.destination as? UIPageViewController {
            pageViewController = pageDestination
            pageDestination.delegate = self
            pageDestination.dataSource = self
        }
    }
}

extension LandingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController),
              currentIndex > 0 else {return nil}
        return viewControllers[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController),
              currentIndex < viewControllers.count - 1 else {return nil}
        return viewControllers[currentIndex + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let first = pendingViewControllers.first,
              let index = viewControllers.firstIndex(of: first) else {return}
        pageControl.currentPage = index
    }
}
