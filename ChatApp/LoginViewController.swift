//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Xiaoming Chen on 4/5/17.
//  Copyright © 2017 Xiaoming Chen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var anonymousButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        anonymousButton.layer.borderWidth = 3.0
        anonymousButton.layer.borderColor = UIColor.white.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAnonymouslyDidTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = naviVC
        
    }

    @IBAction func googleLoginDidTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = naviVC
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
