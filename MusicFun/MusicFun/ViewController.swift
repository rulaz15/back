//
//  ViewController.swift
//  MusicFun
//
//  Created by Raúl Torres on 08/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    var mediaPlayer = MPMusicPlayerController.systemMusicPlayer
    
    @IBOutlet var artImageView: UIImageView!
    @IBOutlet var songTitleLabel: UILabel!
    @IBOutlet var playPauseBtn: UIButton!
    
    @IBAction func chooseBtnAction(_ sender: Any) {
        let mediaPickerVC = MPMediaPickerController(mediaTypes: .music)
        mediaPickerVC.allowsPickingMultipleItems = false
        mediaPickerVC.popoverPresentationController?.sourceView = self.view
        mediaPickerVC.delegate = self
        self.present(mediaPickerVC, animated: true, completion: nil)
    }
    
    @IBAction func randomBtnAction(_ sender: Any) {
        if let songs = MPMediaQuery.songs().items {
            if let choosenSong = songs.randomElement() {
                playItem(item: choosenSong)
            }
        }
    }
    
    @IBAction func playPauseBtnAction(_ sender: Any) {
        if mediaPlayer.playbackState == .playing {
            mediaPlayer.pause()
            playPauseBtn.setTitle("Play", for: .normal)
        } else if mediaPlayer.playbackState == .paused {
            mediaPlayer.play()
            playPauseBtn.setTitle("Pause", for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let item = mediaPlayer.nowPlayingItem {
            let size = CGSize(width: artImageView.bounds.width, height: artImageView.bounds.height)
            if let albumImage = item.artwork?.image(at: size) {
                artImageView.image = albumImage
                if let title = item.title {
                    songTitleLabel.text = title
                }
            }
        }
        
        if mediaPlayer.playbackState == .playing {
            playPauseBtn.setTitle("Pause", for: .normal)
        } else if mediaPlayer.playbackState == .paused {
            playPauseBtn.setTitle("Play", for: .normal)
        }
    }
    
    func playItem(item: MPMediaItem) {
        let size = CGSize(width: artImageView.bounds.width, height: artImageView.bounds.height)
        if let albumImage = item.artwork?.image(at: size) {
            artImageView.image = albumImage
            if let title = item.title {
                songTitleLabel.text = title
            }
        }

        mediaPlayer.setQueue(with: MPMediaItemCollection(items: [item]))
        mediaPlayer.play()
        playPauseBtn.setTitle("Pause", for: .normal)
    }

}

extension ViewController : MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        for item in mediaItemCollection.items {
            playItem(item: item)
        }
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
}
