//
//  OnboardingContrainerViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 24.10.2022.
//
import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {

    let pageViewController: UIPageViewController
    let closeButton = UIButton(type: .system)

    var pages = [UIViewController]()
    var currentVC: UIViewController

    weak var delegate: OnboardingContainerViewControllerDelegate?
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        let page1 = OnboardingViewController(topImage: "image11", titleText: "Find Movie or Serial", descriptionText: "Don't forget to take some yummy", color: .white)
        let page2 = OnboardingViewController(topImage: "image22", titleText: "Call friends", descriptionText: "The best way to spend time together is to watch a good movie", color: .white)
        let page3 = OnboardingViewController(topImage: "image33", titleText: "Enjoy", descriptionText: "We sync your preferences across all devices. Have a fun.", color: .white)
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        currentVC = pages.first!
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    private func setup() {
        addChild(pageViewController)
        pageViewController.view.backgroundColor = .white
        pageViewController.didMove(toParent: self)
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    private func style() {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .large
        config.background.backgroundColor = .systemRed
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Get started", for: [])
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.configuration = config
        closeButton.dropShadow()
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
    }
    private func layout() {
        view.addSubview(pageViewController.view)
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            closeButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 6)
        ])
    }
    private func changeIndicatorColor() {
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingContainerViewController.self])
        appearance.pageIndicatorTintColor = .lightGray
        appearance.currentPageIndicatorTintColor = .black
    }
}
// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        self.currentVC = pages[index - 1]
        return pages[index - 1]
    }
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        self.currentVC = pages[index + 1]
        return pages[index + 1]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        changeIndicatorColor()
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}
// MARK: - Close onboarding
extension OnboardingContainerViewController {
    @objc func closeTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
}
