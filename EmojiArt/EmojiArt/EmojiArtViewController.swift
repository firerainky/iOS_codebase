//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Zheng Kanyan on 2021/1/29.
//

import UIKit

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {

    @IBOutlet var dropZone: UIView!

    @IBOutlet var emojiArtView: EmojiArtView!
    
    override func viewDidLoad() {
        let dropInteraction = UIDropInteraction(delegate: self)
        dropZone.addInteraction(dropInteraction)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction,
                         canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) || session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction,
                         sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    var imageFetcher: ImageFetcher!
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        imageFetcher = ImageFetcher { (url, image) in
            DispatchQueue.main.async {
                self.emojiArtView.backgroundImage = image
            }
        }
        
        session.loadObjects(ofClass: UIImage.self) { images in
            if let image = images.first as? UIImage {
                self.imageFetcher.backup = image
            }
        }
        
        session.loadObjects(ofClass: NSURL.self) { nsurls in
            if let url = nsurls.first as? URL {
                self.imageFetcher.fetch(url)
//                if let data = try? Data(contentsOf: url) {
//                    self.emojiArtView.backgroundImage = UIImage(data: data)
//                }
            }
        }
    }
}
