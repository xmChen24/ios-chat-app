//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Xiaoming Chen on 4/5/17.
//  Copyright © 2017 Xiaoming Chen. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var anonymousButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        anonymousButton.layer.borderWidth = 3.0
        anonymousButton.layer.borderColor = UIColor.white.cgColor
        
        //let google who you are using the client id.
        GIDSignIn.sharedInstance().clientID = "1037138186783-knsv60gg80ct7mujbplllb9ttru587a3.apps.googleusercontent.com"
        //display the UI for the user to input their google accounts. Here we use the loginViewController itself. You can use other
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAnonymouslyDidTapped(_ sender: Any) {

        //use a helper class which use Firebase
        Helper.helper.loginAnonymously();
    }

    @IBAction func googleLoginDidTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        Helper.helper.loginWithGoogle(authentication: user.authentication)
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
