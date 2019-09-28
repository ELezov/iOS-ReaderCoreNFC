//
//  NFCReaderManager.swift
//  ReaderCoreNFC
//
//  Created by EugenKGD on 28/09/2019.
//  Copyright © 2019 EugenKGD. All rights reserved.
//

import CoreNFC

protocol NFCReaderManagerAbstract {
    
    typealias OnDidDetectMessageIntent = (String) -> Void
    var onDidDetectMessageIntent: OnDidDetectMessageIntent? { get set }
    
    func start()
}

class NFCReaderManager: NSObject, NFCReaderManagerAbstract {
    
    // MARK: - NFCReaderManagerAbstract
    
    var onDidDetectMessageIntent: OnDidDetectMessageIntent?
    
    // MARK: - Private Variable
    
    fileprivate var nfcSession: NFCNDEFReaderSession?
    
    override init() {
        super.init()
        nfcSession = NFCNDEFReaderSession.init(delegate: self,
                                               queue: nil,
                                               invalidateAfterFirstRead: true)
    }
    
    func start() {
        nfcSession?.begin()
    }
    
}

extension NFCReaderManager: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession,
                       didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Parse the card's information
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)! // 1
        }
        DispatchQueue.main.async { [weak self] in
            self?.onDidDetectMessageIntent?(result)
        }
    }
}
