//
//  LoginDemoTests.swift
//  LoginDemoTests
//
//  Created by Tien Le on 7/20/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import XCTest
@testable import LoginDemo

class LoginDemoTests: XCTestCase {
    
    var vc : ViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let sb = UIStoryboard(name: "Main", bundle: nil)
        vc = sb.instantiateInitialViewController() as! ViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testLogin(){
        let email: String = "manhtien.ptit@gmail.com"
        let pass: String = "123456"
        var status = 0
        vc.DoLogin(email: email, pass: pass, complete:{
            stt in
            status = stt
        })
        if status == 1 {
            print("Thanh cong")
        }
        else{
            print("Khong thanh cong")
        }
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
