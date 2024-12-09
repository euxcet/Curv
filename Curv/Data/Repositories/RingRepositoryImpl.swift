//
//  RingRepositoryImpl.swift
//  Curv
//
//  Created by Euxcet on 2024/12/8.
//

import CoreBluetooth

public class RingRepositoryImpl: RingRepository {
    let ringManager: RingManager = RingManager()
    
    public func scan() {
        ringManager.sendData()
//        self.connect(uuid: "14A9E637-4AEF-7CDD-B21C-8E433BB77656")
        /*
        RingManager.shared.startScan { devices in
            for device in devices! {
                if (device.uuidString.starts(with: "14A9")) {
                    self.connect(uuid: device.uuidString)
                }
            }
        }
         */
    }
    
    public func connect(uuid: String) {
        /*
        RingManager.shared.startConnect(deviceUUID: uuid, resultBlock:  { res in switch res {
        case .success(let deviceInfo):
            print("Connected")
            let timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) {_ in
                self.getMessage()
            }
        case .failure(let error):
            print("Error ", error)
        }
        })
         */
    }
    
    public func getMessage() {
        /*
        RingManager.shared.readAppVersion { res in
            switch res {
            case .success(let version):
                print(version)
            case .failure(let failure):
                print("Failed")
            }
        }
         */
    }
}
