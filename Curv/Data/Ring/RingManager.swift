//
//  RingManager.swift
//  Curv
//
//  Created by Euxcet on 2024/12/9.
//

import CoreBluetooth

class RingManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager!
    var ring: CBPeripheral?
    var writeCharacteristic: CBCharacteristic?
    var counter: Int = 0
    var timestamp: Int = 0
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("Bluetooth is powered on")
            let connectedRings = centralManager.retrieveConnectedPeripherals(withServices: [CBUUID(string: "BAE80001-4F05-4503-8E65-3AF1F7329D1F")])
            if let ring = connectedRings.first {
                self.ring = ring
                self.ring?.delegate = self
                centralManager.connect(ring, options: nil)
            } else {
                centralManager.scanForPeripherals(withServices: nil)
            }
        } else {
            print("Bluetooth is powered off")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered \(peripheral.name ?? "Unknown device")")
        if (peripheral.name == "BCL603FB05") {
            ring = peripheral
            ring?.delegate = self
            centralManager.stopScan()
            centralManager.connect(peripheral, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "Unknown device")")
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            print("Error discovering services: \(error.localizedDescription)")
            return
        }

        if let services = peripheral.services {
            for service in services {
                print("Discovered service: \(service.uuid)")
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let error = error {
            print("Error discovering characteristics: \(error.localizedDescription)")
            return
        }

        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if (characteristic.uuid.uuidString.starts(with: "BAE80010")) {
                    writeCharacteristic = characteristic
                } else if (characteristic.uuid.uuidString.starts(with: "BAE80011")) {
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let gap: Int = 40
        if let data = characteristic.value {
            if (data[2] == 0x40 && data[3] == 0x06) {
                if (counter % gap == 0) {
                    let currentTimestamp = Int(Date().timeIntervalSince1970 * 1000)
                    if (timestamp > 0) {
                        print((Double)(gap) / (Double)(currentTimestamp - timestamp) * 10000.0)
                    }
                    timestamp = currentTimestamp
                }
                counter += 1
//                print("Received data: \(data)")
            }
        }
    }
    
    public func sendData() {
//        let data = Data([0x00, 0x00, 0x11, 0x00])
        let data = Data([0x00, 0x00, 0x40, 0x06])
        if let characteristic = writeCharacteristic {
            ring?.writeValue(data, for: characteristic, type: .withoutResponse)
        }
    }
}
