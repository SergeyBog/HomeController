//
//  ControlPageViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import UIKit

class LightControlPageViewController: UIViewController {

    var lightControlPageViewModel: LightControlPageViewModel
   
    private let lightImageView = UIImageView()
    
    private let intensitySlider = UISlider()
    
    private let intensityTextView = UITextView()
    
    private let modeTextView = UITextView()
    
    private let segmentControl: UISegmentedControl = {
        let items = ["on.Word".localized(),"off.Word".localized()]
        let segControl = UISegmentedControl(items: items)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        return segControl
    }()
    
    init(with viewModel: LightControlPageViewModel) {
        self.lightControlPageViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        lightControlPageViewModel.updateInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        stylizeElements()
        view.addSubview(lightImageView)
        view.addSubview(segmentControl)
        view.addSubview(intensitySlider)
        view.addSubview(intensityTextView)
        view.addSubview(modeTextView)
        addConstraints()
    }
    
    private func stylizeElements() {
        
        self.title = lightControlPageViewModel.getDeviceName()
        
        view.backgroundColor = .lightGray
        
        segmentControl.addTarget(self, action: #selector(segmentControlChange(_segmentControl:)), for: .valueChanged)
        
        intensitySlider.addTarget(self, action: #selector(sliderValueChanged(_slider:)), for: .valueChanged)
        
        if lightControlPageViewModel.getDeviceMode() == 0 {
            segmentControl.selectedSegmentIndex = 0
            lightImageView.image = UIImage(named: "DeviceLightOnIcon")
            
        } else {
            segmentControl.selectedSegmentIndex = 1
            lightImageView.image = UIImage(named: "DeviceLightOffIcon")
        }
        
        lightImageView.styleImageView()
        
        intensitySlider.styleSlider()
        
        modeTextView.styleTextView(texts: "mode.Word".localized() + ": ")
        
        intensityTextView.styleTextView(texts: "intensity.Word".localized() + ": ")
        
        intensitySlider.value =  lightControlPageViewModel.getDeviceIntensityInFloat()/100
        
        intensityTextView.text = "intensity.Word".localized() + ": " + lightControlPageViewModel.getDeviceIntensityInString()
                
    }
    
    private func addConstraints() {
        addConstraintsForLightImageView()
        addConstraintsForIntensityTextView()
        addConstraintsForIntensitySlider()
        addConstraintsForModeTextView()
        addConstraintsForSegmentControl()
    }
    
    private func addConstraintsForLightImageView() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(lightImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        
        constraints.append(lightImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 160))
        
        constraints.append( lightImageView.widthAnchor.constraint(equalToConstant: 100))
        
        constraints.append(lightImageView.heightAnchor.constraint(equalToConstant: 100))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addConstraintsForIntensityTextView() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append( intensityTextView.topAnchor.constraint(equalTo: lightImageView.bottomAnchor,constant: 38))
        
        constraints.append(intensityTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30))
        
        constraints.append(intensityTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30))
       
        NSLayoutConstraint.activate(constraints)
    }
    
   private func addConstraintsForIntensitySlider() {
       
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(intensitySlider.topAnchor.constraint(equalTo: intensityTextView.bottomAnchor,constant: 16))
        
        constraints.append(intensitySlider.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30))
        
        constraints.append(intensitySlider.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30))
       
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addConstraintsForModeTextView() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(modeTextView.topAnchor.constraint(equalTo: intensitySlider.bottomAnchor, constant: 38))
        
        constraints.append(modeTextView.heightAnchor.constraint(equalToConstant: 40))
        
        constraints.append(modeTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30))
        
        constraints.append(modeTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addConstraintsForSegmentControl() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(segmentControl.topAnchor.constraint(equalTo: modeTextView.bottomAnchor, constant: 16))
        
        constraints.append(segmentControl.heightAnchor.constraint(equalToConstant: 40))
        
        constraints.append(segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30))
        
        constraints.append(segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30))
    
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func segmentControlChange(_segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            lightImageView.image = UIImage(named: "DeviceLightOnIcon")
            lightControlPageViewModel.updateMode(with: "on.Word".localized())
            
        case 1:
            lightImageView.image = UIImage(named: "DeviceLightOffIcon")
            lightControlPageViewModel.updateMode(with: "off.Word".localized())
            
        default:
            lightImageView.image = UIImage(named: "DeviceLightOffIcon")
        }
    }
    
    @objc func sliderValueChanged(_slider: UISlider) {
        intensityTextView.text = "intensity.Word".localized() + ": " + String(Int((_slider.value * 100).rounded(.up)))
        
        lightControlPageViewModel.updateIntensity(with: Int((_slider.value * 100).rounded(.up)))
    }
    
}
