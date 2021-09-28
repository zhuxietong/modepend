//
//  ViewController.swift
//  soapp-image
//
//  Created by zhuxietong@me.com on 09/28/2021.
//  Copyright (c) 2021 zhuxietong@me.com. All rights reserved.
//

import UIKit
import modepend
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let sizeL = UILabel()
        let img = UIImageView()
        ModependWebImage.share.setImage(imageView: img, with: "http://page.firstvar.com/media/img/0000000002.jpg", placeholder: nil) { img in
            
        }
        
        view.addSubview(img)
        img.frame = CGRect(x: 30, y: 80, width: 100, height: 200)
        img.backgroundColor = .systemRed
        view.addSubview(sizeL)
        sizeL.frame = CGRect(x: 30, y: 400, width: 100, height: 30)
        
        sizeL.backgroundColor = .systemRed
        ModependWebImage.share.calculateCacheSize { si in
            sizeL.text = "\(si)"
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

