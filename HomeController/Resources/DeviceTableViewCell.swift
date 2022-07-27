//
//  DeviceTableViewCell.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    static  let identifier = "DeviceTableViewCell"
    
    private let deviceNameLabel = UILabel()
  
    private let deviceFirstActivityLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        deviceNameLabel.styleLabel(sized: 15, weights: .semibold, amountOfLines: 0)
        
        deviceFirstActivityLabel.styleLabel(sized: 20, weights: .regular, amountOfLines: 0)
        
        contentView.addSubview(deviceNameLabel)
        contentView.addSubview(deviceFirstActivityLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        deviceNameLabel.frame = CGRect(x: 10,
                                     y: 10,
                                       width: contentView.frame.width-60,
                                       height: (contentView.frame.height-20)/2)
        
        deviceFirstActivityLabel.frame = CGRect(x: 10,
                                       y: deviceNameLabel.frame.size.height + deviceNameLabel.frame.origin.y + 10,
                                       width: contentView.frame.width-60,
                                       height: (contentView.frame.height-20)/2)
    }
    
    public func configure(with model: Device) {
        
        if model.productType == "RollerShutter" {
            
            deviceNameLabel.text = model.deviceName
            
            if model.mode == "OpenAt.Word".localized() || model.position ?? 0 > 0 {
                deviceFirstActivityLabel.text = "OpenAt.Word".localized() + ": " + String(model.position ?? 0) + "%"
                
            } else if model.mode == "Open.Word".localized() || model.position ?? 0 == 0 {
                deviceFirstActivityLabel.text = "Open.Word".localized()
                
            } else if model.mode == "Closed.Word".localized() || model.position == 100 {
                deviceFirstActivityLabel.text = "Closed.Word".localized()
            }
            
            
            
        } else if model.productType == "Light" {
            deviceNameLabel.text = model.deviceName
            
            if model.mode == "Off.Word".localized() || model.mode == "OFF" {
                deviceFirstActivityLabel.text = "Off.Word".localized()
            } else {
                deviceFirstActivityLabel.text = "Intensity.Word".localized() + ": " + String(model.intensity ?? 0)
            }
            
        } else {
            deviceNameLabel.text = model.deviceName
            if model.mode == "Off.Word".localized() || model.mode == "OFF" {
                deviceFirstActivityLabel.text = "Off.Word".localized()
            } else {
                deviceFirstActivityLabel.text = "Temperature.Word".localized() + ": " + String(model.temperature ?? 0) + "°"
            }
        
        }
    }

}
