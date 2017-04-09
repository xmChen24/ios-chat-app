//
//  Helper.swift
//  ChatApp
//
//  Created by Xiaoming Chen on 4/7/17.
//  Copyright © 2017 Xiaoming Chen. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit
import GoogleSignIn

//We don't want to login twice, so we create a sigleton class
class Helper {
    
    static let helper = Helper();

    func loginAnonymously() {
        
        //login anonymously using FirebaseAuth anonymous users
        FIRAuth.auth()?.signInAnonymously(completion: { (anonymousUser: FIRUser?, error: Error?) in
            if error == nil {
                print("UserId: \(anonymousUser!.uid)")
                
                self.switchToNavigationViewController()
                
            } else {
                print(error!.localizedDescription)
                return
            }
        })
    }
    
    func loginWithGoogle(authentication: GIDAuthentication) {

        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            } else {
               print(user?.email!)
               print(user?.displayName!)
               
               self.switchToNavigationViewController()
            }
      }
    }
    
    private func switchToNavigationViewController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = naviVC

    }
}

