//
//  UIImageViewExtensions.swift
//  CarFax
//
//  Created by Vincent Vuong on 9/30/20.
//  Copyright © 2020 Vincent Vuong. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
     func loadURL(url: URL?){
        guard let url = url else {
            return
        }
        if let imagedata = NSData(contentsOf: url) as Data? {
            image = UIImage(data: imagedata)
        }
    }
}
