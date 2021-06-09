//
//  Storage.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/8/21.
//

import Foundation

class Storage {

    private enum Constants {
        static let offerStamp = "offerStamp"
    }

    static let shared = Storage()
    private init(){}

    var offerStamp: OfferStamp? {
        set {
            let encoder = JSONEncoder()
            guard let data = try? encoder.encode(newValue) else {return}
            UserDefaults.standard.setValue(data, forKey: Constants.offerStamp)
        }
        get {
            guard let data = UserDefaults.standard.data(forKey: Constants.offerStamp) else {return nil}
            let decoder = JSONDecoder()
            return try? decoder.decode(OfferStamp.self, from: data)
        }
    }
}
