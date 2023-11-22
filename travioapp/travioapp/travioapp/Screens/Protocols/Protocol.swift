//
//  Protocol.swift
//  travioapp
//
//  Created by Büşra Erim on 15.11.2023.
//

import Foundation
import UIKit

protocol Permission:AnyObject{

    func checkPhotoLibraryPermission(view:UIViewController)
    func showAlertForPhotoLibraryPermission()
    func showSettingsAlert()
}


