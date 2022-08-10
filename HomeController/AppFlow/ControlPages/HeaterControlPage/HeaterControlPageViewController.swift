//
//  HeaterControlPageViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import UIKit

class HeaterControlPageViewController: UIViewController {

    var heaterControlPageViewModel: HeaterControlPageViewModel
    
    private let heaterImageView = UIImageView()
    
    private let temperatureSlider = UISlider()
    
    private let temperatureTextView = UITextView()
    
    private let modeTextView = UITextView()
    
    private let segmentControl: UISegmentedControl = {
        let items = ["on.Word".localized(),"off.Word".localized()]
        let segControl = UISegmentedControl(items: items)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        return segControl
    }()
    
    init(with viewModel: HeaterControlPageViewModel) {
        self.heaterControlPageViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        heaterControlPageViewModel.updateInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        stylizeElements()
        view.addSubview(heaterImageView)
        view.addSubview(segmentControl)
        view.addSubview(temperatureSlider)
        view.addSubview(temperatureTextView)
        view.addSubview(modeTextView)
        addConstraints()
    }
    
    private func stylizeElements() {
        self.title = heaterControlPageViewModel.getDeviceName()
        
        view.backgroundColor = .lightGray
        
        segmentControl.addTarget(self, action: #selector(segmentControlChange(_segmentControl:)), for: .valueChanged)
        
        temperatureSlider.addTarget(self, action: #selector(sliderValueChanged(_slider:)), for: .valueChanged)
        
        if heaterControlPageViewModel.getDeviceMode() == 0 {
            segmentControl.selectedSegmentIndex = 0
            heaterImageView.image = UIImage(named: "DeviceHeaterOnIcon")
            
        } else {
            segmentControl.selectedSegmentIndex = 1
            heaterImageView.image = UIImage(named: "DeviceHeaterOffIcon")
        }
        
        heaterImageView.styleImageView()
        
        temperatureSlider.styleSlider()
        
        modeTextView.styleTextView(texts: "mode.Word".localized() + ": ")
        
        temperatureTextView.styleTextView(texts: "temperature.Word".localized() + ": ")
        
        temperatureSlider.minimumValue = 7.0/100
        
        temperatureSlider.maximumValue = 28.0/100
        
        temperatureSlider.value =  heaterControlPageViewModel.getDeviceTemperatureInFloat()/100
        
        temperatureTextView.text = "temperature.Word".localized() + ": " +  heaterControlPageViewModel.getDeviceTemperatureInString() + "°"
                
    }
    
    private func addConstraints() {
        addConstraintsForHeaterImageView()
        addConstraintsForTemperatureTextView()
        addConstraintsForTemperatureSlider()
        addConstraintsForModeTextView()
        addConstraintsForSegmentControl()
    }
    
    private func addConstraintsForHeaterImageView() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(heaterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        
        constraints.append(heaterImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 160))
        
        constraints.append(heaterImageView.widthAnchor.constraint(equalToConstant: 100))
        
        constraints.append(heaterImageView.heightAnchor.constraint(equalToConstant: 100))
         
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addConstraintsForTemperatureTextView() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(temperatureTextView.topAnchor.constraint(equalTo: heaterImageView.bottomAnchor,constant: 38))
        
        constraints.append(temperatureTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30))
        
        constraints.append(temperatureTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addConstraintsForTemperatureSlider() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(temperatureSlider.topAnchor.constraint(equalTo: temperatureTextView.bottomAnchor,constant: 16))
        
        constraints.append(temperatureSlider.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30))
        
        constraints.append(temperatureSlider.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30))

        NSLayoutConstraint.activate(constraints)
    }
    
    private func addConstraintsForModeTextView() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(modeTextView.topAnchor.constraint(equalTo: temperatureSlider.bottomAnchor, constant: 38))
        
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
            heaterImageView.image = UIImage(named: "DeviceHeaterOnIcon")
            heaterControlPageViewModel.updateMode(with: "on.Word".localized())
            
        case 1:
            heaterImageView.image = UIImage(named: "DeviceHeaterOffIcon")
            heaterControlPageViewModel.updateMode(with: "off.Word".localized())
            
        default:
            heaterImageView.image = UIImage(named: "DeviceHeaterOffIcon")
        }
    }
    
    @objc func sliderValueChanged(_slider: UISlider) {
        
        temperatureTextView.text = "temperature.Word".localized() + ": " + String(round(_slider.value * 100 * 2)/2) + "°"
        
        heaterControlPageViewModel.updateTemperature(with: Float(round(_slider.value * 100 * 2)/2))
    }
    
}
