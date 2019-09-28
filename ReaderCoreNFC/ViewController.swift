//
//  ViewController.swift
//  ReaderCoreNFC
//
//  Created by EugenKGD on 25/02/2019.
//  Copyright © 2019 EugenKGD. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController {
    
    // MARK: - Private Variables
    
    fileprivate var nfcManager: NFCReaderManagerAbstract?
    
    // MARK: - Outlets
    
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
    }

    // MARK: - Actions
    
    @IBAction func scanPressed(_ sender: Any) {
        // this is our newly created IBAction
        nfcManager?.start()
    }
}

// MARK: - Private Methods

fileprivate extension ViewController {
    func configureModels() {
        nfcManager = NFCReaderManager()
    }
}

