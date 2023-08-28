//
//  ViewController.swift
//  lesson301
//
//  Created by Garib Agaev on 28.08.2023.
//

import UIKit
import SpringAnimation

class MainViewController: UIViewController {
    
    //MARK: - Private property
    private let button = UIButton(type: .system)
    private var randomAnimation = ""
    private let label = UILabel()
    private let animationView = SpringView()
    // Знаю, что не следует данные хранить во Вью,
    // но в данном случае это так лего делается,
    // что просто лень создавать отдельные файлы для этого
    private let animationPresets = AnimationPreset.allCases.map { $0.rawValue }
    private let animationCurves = AnimationCurve.allCases.map { $0.rawValue }

    //MARK: - Override UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc private func buttonAction() {
        animationView.animation = randomAnimation
        animationView.curve = animationCurves.randomElement() ?? ""
        animationView.force = CGFloat.random(in: 1...2)
        animationView.delay = CGFloat.random(in: 0...1)
        animationView.duration = CGFloat.random(in: 0...1)
        animationView.animate()
        
        setTextForLabel(
            animation: animationView.animation,
            curve: animationView.curve,
            force: getString(animationView.force),
            delay: getString(animationView.delay),
            duration: getString(animationView.duration)
        )
        
        randomAnimation = animationPresets.randomElement() ?? ""
        button.setTitle("Ran \(randomAnimation)", for: .normal)
    }
}

//MARK: - Setting View
private extension MainViewController {
    func setupView() {
        view.backgroundColor = .systemRed
        
        setupAnimationView()
        setConstraintsAnimationView()
        
        setupButton()
        setConstraintsButton()
        
        setupLable()
        setConstraintsLable()
    }
}

//MARK: - Setting
private extension MainViewController {
    func setupAnimationView() {
        view.addSubview(animationView)
        animationView.backgroundColor = .white
        animationView.layer.cornerRadius = 10
    }
    
    func setupButton() {
        view.addSubview(button)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        randomAnimation = animationPresets.randomElement() ?? ""
        button.setTitle("Ran \(randomAnimation)", for: .normal)
    }
    
    func setupLable() {
        animationView.addSubview(label)
        label.numberOfLines = 0
        setTextForLabel()
    }
    
    func setTextForLabel(animation: String? = nil, curve: String? = nil, force: String? = nil, delay: String? = nil, duration: String? = nil) {
        label.text = "animation: \(animation ?? "")\ncurve: \(curve ?? "")\nforce: \(force ?? "")\ndelay: \(delay ?? "")\nduration: \(duration ?? "")"
    }
    
    func getString(_ nums: CGFloat) -> String {
        String(format: "%.2f", Float(nums))
    }
}

// MARK: - Layot
private extension MainViewController {
    func setConstraintsAnimationView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: animationView, attribute: .centerX,
                relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .centerX,
                multiplier: 1, constant: 0
            ),
            NSLayoutConstraint(
                item: animationView, attribute: .leading,
                relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .leading,
                multiplier: 1, constant: 16
            ),
            NSLayoutConstraint(
                item: animationView, attribute: .top,
                relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .top,
                multiplier: 1, constant: 20
            ),
            NSLayoutConstraint(
                item: animationView, attribute: .height,
                relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .height,
                multiplier: 0.3, constant: 0
            ),
        ])
    }
    
    func setConstraintsButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: button, attribute: .centerX,
                relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .centerX,
                multiplier: 1, constant: 0
            ),
            NSLayoutConstraint(
                item: button, attribute: .width,
                relatedBy: .greaterThanOrEqual,
                toItem: animationView, attribute: .width,
                multiplier: 0.5, constant: 0
            ),
            NSLayoutConstraint(
                item: button, attribute: .bottom,
                relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .bottom,
                multiplier: 1, constant: -20
            )
        ])
    }
    
    func setConstraintsLable() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: label, attribute: .centerX,
                relatedBy: .equal,
                toItem: animationView, attribute: .centerX,
                multiplier: 1, constant: 0
            ),
            NSLayoutConstraint(
                item: label, attribute: .centerY,
                relatedBy: .equal,
                toItem: animationView, attribute: .centerY,
                multiplier: 1, constant: 0
            ),
            NSLayoutConstraint(
                item: label, attribute: .leading,
                relatedBy: .lessThanOrEqual,
                toItem: animationView, attribute: .leading,
                multiplier: 1, constant: 16
            )
        ])
    }
}
