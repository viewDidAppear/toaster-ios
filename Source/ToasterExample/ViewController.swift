//
//  ViewController.swift
//  ToasterExample
//
//  Created by Ben Deckys on 7/02/2016.
//  Copyright © 2016 iicoco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let favError = Toast(withDuration: ToastDuration.Long,
            gravity: ToastGravity.Top,
            severity: ToastSeverity.Info,
            style: ToastStyle.Brief,
            message: "O' Romeo, O' Romeo.. Where for art thou Romeo?",
            code: 53,
            animated: true
        )
        let hisError = Toast(withDuration: .Long,
            gravity: .Bottom,
            severity: .Error,
            style: .Brief,
            message: "Everything that can go wrong, just did. Godspeed, dear sir!",
            code: 5301,
            animated: true
        )
        
        Toaster.sharedInstance.load(withToasts:
            [
                favError,
                hisError
            ]
        )
        
        Toaster.sharedInstance.pop(withErrorCode: 53)
        Toaster.sharedInstance.pop(withErrorCode: 5301)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

