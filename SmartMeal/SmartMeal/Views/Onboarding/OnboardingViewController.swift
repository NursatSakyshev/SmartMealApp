//
//  OnboardingViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 27.03.2025.
//

import Foundation

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    var onFinish: (() -> Void)?

    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private let onboardingPages: [UIViewController] = [
        OnboardingPageViewController(
            imageName: "onboarding1",
            title: "Готовьте легко!",
            description: "Найдите идеальные рецепты, просто укажите продукты, которые у вас есть.",
            imageHeight: 200, imageWidth: 230, isFirstPage: true
        ),
        OnboardingPageViewController(
            imageName: "onboarding3",
            title: "Сохраняйте любимые блюда",
            description: "Добавляйте рецепты в избранное и возвращайтесь к ним в любое время.",
            imageHeight: 200, imageWidth: 230
        ),
        OnboardingPageViewController(
            imageName: "onboarding2",
            title: "Лучшие рецепты для вас",
            description: "Получайте подборки рецептов на основе ваших предпочтений.",
            imageHeight: 200, imageWidth: 230
        ),
    ]

    private let customPageControl = CustomPageControl()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Далее", for: .normal)
        button.backgroundColor = UIColor(red: 66/255, green: 200/255, blue: 60/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 8
        return button
    }()

    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Пропустить", for: .normal)
        button.setTitleColor(UIColor(red: 66/255, green: 200/255, blue: 60/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return button
    }()

    private var currentPage = 0 {
        didSet {
            customPageControl.setCurrentPage(currentPage)
            let isLastPage = currentPage == onboardingPages.count - 1
            nextButton.setTitle(isLastPage ? "Добро пожаловать!" : "Далее", for: .normal)
            skipButton.isHidden = isLastPage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupPageViewController()
        setupLayout()

        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }

    private func setupPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)

        pageViewController.dataSource = self
        pageViewController.delegate = self

        if let firstPage = onboardingPages.first {
            pageViewController.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func setupCustomPageControl() {
        view.addSubview(customPageControl)
        customPageControl.configure(totalPages: onboardingPages.count, currentPage: currentPage)
        customPageControl.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-80)
            make.centerX.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalToSuperview()
        }
    }


    private func setupLayout() {
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(nextButton)
        view.addSubview(skipButton)

        setupCustomPageControl()

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(skipButton.snp.top).offset(-16)
            make.left.equalToSuperview().offset(43)
            make.right.equalToSuperview().offset(-43)
            make.height.equalTo(40)
        }

        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-44)
            make.centerX.equalToSuperview()
        }
    }

    @objc private func nextButtonTapped() {
        let isLastPage = currentPage == onboardingPages.count - 1
        if isLastPage {
            onFinish?()
//            print("Онбординг завершён")
//            let signInVC = SignInViewController()
//            navigationController?.pushViewController(signInVC, animated: true)
        } else {
            currentPage += 1
            let nextVC = onboardingPages[currentPage]
            pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }

    @objc private func skipButtonTapped() {
        onFinish?()
//        print("Онбординг пропущен")
//        let signInVC = SignInViewController()
//        navigationController?.pushViewController(signInVC, animated: true)
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = onboardingPages.firstIndex(of: viewController), index > 0 else {
            return onboardingPages.last
        }
        return onboardingPages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = onboardingPages.firstIndex(of: viewController), index < onboardingPages.count - 1 else {
            return onboardingPages.first
        }
        return onboardingPages[index + 1]
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleVC = pageViewController.viewControllers?.first, let index = onboardingPages.firstIndex(of: visibleVC) {
            currentPage = index
        }
    }
}
