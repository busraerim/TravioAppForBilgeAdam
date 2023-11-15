//
//  SettingsData.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 14.11.2023.
//

import Foundation

struct SettingsData {
    
    static let cellModelArray: [SettingsCellModel] = [
        SettingsCellModel(iconImage: "user-alt", label: "Security Settings"),
        SettingsCellModel(iconImage: "app-icon", label: "App Defaults"),
        SettingsCellModel(iconImage: "map-icon", label: "My Added Places"),
        SettingsCellModel(iconImage: "help-icon", label: "Help & Supports"),
        SettingsCellModel(iconImage: "about-icon", label: "About"),
        SettingsCellModel(iconImage: "term-icon", label: "Terms of Use")]
}
