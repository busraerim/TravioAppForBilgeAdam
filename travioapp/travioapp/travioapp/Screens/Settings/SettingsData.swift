//
//  SettingsData.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 14.11.2023.
//

import Foundation


enum SettingsCellType: Int {
    case securitySettings
    case appDefaults
    case myAddedPlaces
    case helpAndSupport
    case about
    case termsOfUse
}

struct SettingsData {
    
    static let cellModelArray: [SettingsCellModel] = [
        SettingsCellModel(type: .securitySettings, iconImage: "user-alt", label: "Security Settings"),
        SettingsCellModel(type: .appDefaults, iconImage: "app-icon", label: "App Defaults"),
        SettingsCellModel(type: .myAddedPlaces, iconImage: "map-icon", label: "My Added Places"),
        SettingsCellModel(type: .helpAndSupport, iconImage: "help-icon", label: "Help & Supports"),
        SettingsCellModel(type: .about, iconImage: "about-icon", label: "About"),
        SettingsCellModel(type: .termsOfUse, iconImage: "term-icon", label: "Terms of Use")
    ]
}
