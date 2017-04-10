//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Xiaoming Chen on 4/5/17.
//  Copyright © 2017 Xiaoming Chen. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.senderId = "1"
        self.senderDisplayName = "Xiaoming Chen "
        // Do any additional setup after loading the view.
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        print("didPressSend")
        print("\(text)")
        print(senderId)
        print(senderDisplayName)
        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName!, text: text))
        collectionView.reloadData()
        print(messages)
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        print("didPressAccessoryButton")
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        return bubbleFactory?.outgoingMessagesBubbleImage(with: .black)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(messages.count)
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutDidTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LogInVC = storyboard.instantiateViewController(withIdentifier: "LogInVC") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = LogInVC

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

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("did finish picking")
        // get the image
        print(info)
        let picture = info[UIImagePickerControllerOriginalImage] as? UIImage
        let photo = JSQPhotoMediaItem(image: picture!)
        messages.append(JSQMessage(senderId: senderId!, displayName: senderDisplayName!, media: photo))
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
        
    }
}


