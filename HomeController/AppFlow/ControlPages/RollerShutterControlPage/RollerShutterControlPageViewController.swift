//
//  RollerShutterControlPageViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import UIKit

class RollerShutterControlPageViewController: UIViewController {
    var rollerShutterControlPageViewModel: RollerShutterControlPageViewModel
    
    private let rollerShutterImageView = UIImageView()
    
    private let positionSlider = UISlider()
    
    private let positionTextView = UITextView()
    
    init(with viewModel: RollerShutterControlPageViewModel) {
        self.rollerShutterControlPageViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        rollerShutterControlPageViewModel.updateInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        stylizeElements()
        view.addSubview(rollerShutterImageView)
        view.addSubview(positionSlider)
        view.addSubview(positionTextView)
        addConstraints()
    }
    
    private func stylizeElements() {
        self.title = rollerShutterControlPageViewModel.getDeviceName()
        
        view.backgroundColor = .lightGray
        
        positionSlider.addTarget(self, action: #selector(sliderValueChanged(_slider:)), for: .valueChanged)
        
        rollerShutterImageView.styleImageViewWithImage(imageName: "DeviceRollerShutterIcon")
        
        positionSlider.styleSlider()
        
        positionTextView.styleTextView(texts: "position.Word".localized() + ": ")
        
        positionSlider.value =  rollerShutterControlPageViewModel.getDevicePositionInFloat()/100
        
        positionTextView.text = "position.Word".localized() + ": " + rollerShutterControlPageViewModel.getDevicePositionInString()
                
    }
    
    private func addConstraints() {
        addConstraintsForRollerShutterImageView()
        addConstraintsForPositionTextView()
        addConstraintsForPositionSlider()
    }
    
    private func addConstraintsForRollerShutterImageView() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(rollerShutterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        
        constraints.append(rollerShutterImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 160))
        
        constraints.append(rollerShutterImageView.widthAnchor.constraint(equalToConstant: 100))
        
        constraints.append(rollerShutterImageView.heightAnchor.constraint(equalToConstant: 100))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addConstraintsForPositionTextView() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(positionTextView.topAnchor.constraint(equalTo: rollerShutterImageView.bottomAnchor,constant: 38))
        
        constraints.append(positionTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30))
        
        constraints.append(positionTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30))
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func addConstraintsForPositionSlider() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(positionSlider.topAnchor.constraint(equalTo: positionTextView.bottomAnchor,constant: 16))
        
        constraints.append(positionSlider.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30))
        
        constraints.append(positionSlider.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    @objc func sliderValueChanged(_slider: UISlider) {
        
        positionTextView.text = "position.Word".localized() + ": " + String(Int( (_slider.value * 100).rounded(.up)))
        
        let value = (_slider.value * 100).rounded(.up)
        
        rollerShutterControlPageViewModel.updateData(with: value)
    }

}
