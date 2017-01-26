//
//  OverlayViewController.swift
//  MoTrack
//
//  Created by Arinjay Sharma on 1/26/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    var movieItem:Movie? {
        didSet {
            configureView()
        }
    }
    
    func configureView(){
        if let movie = self.movieItem{
            self.TitleLabel.text = movie.title
            self.descriptionText.text = movie.description
        }
    }
    
    
    @IBAction func closeVC(_ sender: Any) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()  // always
        
        self.view.bounds.size = CGSize(width: UIScreen.main.bounds.size.width - 20, height: 200)
        
        self.view.layer.cornerRadius = 5
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}
