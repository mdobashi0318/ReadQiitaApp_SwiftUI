//
//  ReadQiitaApp_SwiftUI_TestsLaunchTests.swift
//  ReadQiitaApp_SwiftUI_Tests
//
//  Created by 土橋正晴 on 2024/03/14.
//

import XCTest

final class ReadQiitaApp_SwiftUI_TestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
