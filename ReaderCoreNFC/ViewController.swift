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
    var nfcSession: NFCNDEFReaderSession?

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func scanPressed(_ sender: Any) {
        // this is our newly created IBAction
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.begin()
    }

}

extension ViewController: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Parse the card's information
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)! // 1
        }
        
        DispatchQueue.main.async {
            self.messageLabel.text = result
        }
    }
}

