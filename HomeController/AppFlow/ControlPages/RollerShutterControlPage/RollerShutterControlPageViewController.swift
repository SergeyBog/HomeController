//
//  RollerShutterControlPageViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import UIKit

class RollerShutterControlPageViewController: UIViewController {
    var rollerShutterControlPageViewModel: RollerShutterControlPageViewModel
    var rollerShutterView: RollerShutterView
    
    init(with viewModel: RollerShutterControlPageViewModel) {
        self.rollerShutterControlPageViewModel = viewModel
        self.rollerShutterView = RollerShutterView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        rollerShutterControlPageViewModel.updateInfo()
    }
    
    override func loadView() {
        configureView()
        view = rollerShutterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureView() {
        self.title = rollerShutterControlPageViewModel.getDeviceName()
        
        rollerShutterView.positionTextView.text = rollerShutterControlPageViewModel.getDevicePositionInString()
        
        rollerShutterView.positionSlider.value = rollerShutterControlPageViewModel.getDevicePositionInFloat()
        
        rollerShutterView.positionSlider.addTarget(self, action: #selector(sliderValueChanged(_slider:)), for: .valueChanged)
    }
    
    @objc func sliderValueChanged(_slider: UISlider) {
        rollerShutterView.positionTextView.text = rollerShutterControlPageViewModel.positionValueChanged(sliderValue: _slider.value)
    }
}
