//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Xiaoming Chen on 4/5/17.
//  Copyright © 2017 Xiaoming Chen. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices
import AVKit

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
        
        let sheet = UIAlertController(title: "Media Message", message: "Please select a media", preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction) in
            
        }
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default) { (alert: UIAlertAction) in
            self.getMediaFrom(type: kUTTypeImage)
        }
        
        let videoLibrary = UIAlertAction(title: "Video Library", style: UIAlertActionStyle.default) { (alert: UIAlertAction) in
            self.getMediaFrom(type: kUTTypeMovie)
        }
        
        sheet.addAction(photoLibrary)
        sheet.addAction(videoLibrary)
        sheet.addAction(cancel)
        self.present(sheet, animated: true, completion: nil)
        
   //     let imagePicker = UIImagePickerController()
   //     imagePicker.delegate = self
    //    self.present(imagePicker, animated: true, completion: nil)
    }
    
    func getMediaFrom(type: CFString) {
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = self
        mediaPicker.mediaTypes = [type as String]
        self.present(mediaPicker, animated: true, completion: nil)
    
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
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        print("didTapMessageBubbleAtIndexPath \(indexPath.item)")
        let message = messages[indexPath.item]
        if message.isMediaMessage {
            if let mediaItem = message.media as? JSQVideoMediaItem {
            let player = AVPlayer(url: mediaItem.fileURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion: nil)
            }
        }
        
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
        
        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage {
       
            let photo = JSQPhotoMediaItem(image: picture)
            messages.append(JSQMessage(senderId: senderId!, displayName: senderDisplayName!, media: photo))
        }
        else if let video = info[UIImagePickerControllerMediaURL] as? NSURL {
            let videoItem = JSQVideoMediaItem(fileURL: video as URL!, isReadyToPlay: true)
            messages.append(JSQMessage(senderId: senderId!, displayName: senderDisplayName!, media: videoItem))
        }
        
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
        
    }
}


