//
//  F1HubUITests.swift
//  F1HubUITests
//
//  Created by Marcos Morales on 30/10/2025.
//

import XCTest

final class F1HubUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        // Launch with useMockAPI argument to use mock data
        app.launchArguments += ["-useMockAPI"]
        // Launch the app
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testDriverListView_LoadsAndDisplaysDrivers() throws {
        // Navigate to Drivers tab
        let driversTab = app.tabBars.buttons["Drivers"]
        if driversTab.waitForExistence(timeout: 2) {
            driversTab.tap()
        }

        // Wait for loading to complete (no progress view)
        let progressView = app.activityIndicators.firstMatch
        XCTAssertTrue(progressView.waitForExistence(timeout: 2) == false, "Loading should complete")

        // Assert navigation title
        let navBar = app.navigationBars.firstMatch
        XCTAssertTrue(navBar.staticTexts["Drivers"].exists)

        // Assert drivers
        XCTAssertTrue(app.cells.staticTexts["Max Verstappen"].exists)
        XCTAssertTrue(app.cells.staticTexts["Lando Norris"].exists)
        XCTAssertTrue(app.cells.staticTexts["Charles Leclerc"].exists)

        // Assert no error alert
        let errorAlert = app.alerts["Error"]
        XCTAssertFalse(errorAlert.waitForExistence(timeout: 1))
    }

    func testDriverListView_NavigatesToDriverDetail() throws {
        // Navigate to Drivers
        let driversTab = app.tabBars.buttons["Drivers"]
        if driversTab.waitForExistence(timeout: 2) {
            driversTab.tap()
        }

        // Tap first driver row (Max Verstappen)
        let firstRow = app.cells.staticTexts["Max Verstappen"]
        firstRow.tap()

        // Wait for detail view load
        let progressView = app.activityIndicators.firstMatch
        XCTAssertTrue(progressView.waitForExistence(timeout: 2) == false)

        // Assert toolbar item (info.circle exists)
        XCTAssertTrue(app.navigationBars.buttons["info.circle"].exists)

        // Assert header info (number, name)
        XCTAssertTrue(app.staticTexts["33"].exists)
        XCTAssertTrue(app.staticTexts["Max Verstappen"].exists)

        // Assert body info
        XCTAssertTrue(app.staticTexts["Nationality"].exists)
        XCTAssertTrue(app.staticTexts["Netherlands"].exists)
        XCTAssertTrue(app.staticTexts["Date of Birth"].exists)
        XCTAssertTrue(app.staticTexts["Sep 30, 1997"].exists)
        XCTAssertTrue(app.staticTexts["Team"].exists)
        XCTAssertTrue(app.staticTexts["Red Bull Racing"].exists)
        XCTAssertTrue(app.staticTexts["Short Name"].exists)
        XCTAssertTrue(app.staticTexts["VER"].exists)

        // Assert biography section
        XCTAssertTrue(app.staticTexts["Biography"].exists)
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'Dutch and Belgian racing driver'")).firstMatch.exists)

        // Test navigation back
        app.navigationBars.buttons["BackButton"].tap() // Back button
        let navBar = app.navigationBars.firstMatch
        XCTAssertTrue(navBar.staticTexts["Drivers"].exists)
    }

    func testRaceListView_LoadsAndDisplaysRaces() throws {
        // Navigate to Races tab
        let racesTab = app.tabBars.buttons["Races"]
        if racesTab.waitForExistence(timeout: 2) {
            racesTab.tap()
        }

        // Wait for loading
        let progressView = app.activityIndicators.firstMatch
        XCTAssertTrue(progressView.waitForExistence(timeout: 2) == false)

        // Assert navigation title
        let navBar = app.navigationBars.firstMatch
        XCTAssertTrue(navBar.staticTexts["Races"].exists)

        // Assert segments
        let upcomingSegment = app.buttons["SegmentedView[0]"]
        XCTAssertEqual(upcomingSegment.label, "Upcoming")
        let pastSegment = app.buttons["SegmentedView[1]"]
        XCTAssertEqual(pastSegment.label, "Past")

        // Assert upcoming races
        upcomingSegment.tap()
        XCTAssertTrue(app.cells.staticTexts["ROUND 09"].exists)
        XCTAssertTrue(app.cells.staticTexts["Barcelona"].exists)

        // Assert past races
        pastSegment.tap()
        XCTAssertTrue(app.cells.staticTexts["ROUND 01"].exists)
        XCTAssertTrue(app.cells.staticTexts["Melbourne"].exists)

        // Assert no error
        let errorAlert = app.alerts["Error"]
        XCTAssertFalse(errorAlert.waitForExistence(timeout: 1))
    }

    func testStandingsView_LoadsAndDisplaysStandings() throws {
        // Navigate to Standings tab
        let standingsTab = app.tabBars.buttons["Standings"]
        if standingsTab.waitForExistence(timeout: 2) {
            standingsTab.tap()
        }

        // Wait for loading (both fetches)
        let progressView = app.activityIndicators.firstMatch
        XCTAssertTrue(progressView.waitForExistence(timeout: 4) == false) // Longer for two fetches

        // Assert navigation title
        let navBar = app.navigationBars.firstMatch
        XCTAssertTrue(navBar.staticTexts["Standings"].exists)

        // Assert segments
        let driversSegment = app.buttons["SegmentedView[0]"]
        XCTAssertEqual(driversSegment.label, "Drivers")
        let teamsSegment = app.buttons["SegmentedView[1]"]
        XCTAssertEqual(teamsSegment.label, "Teams")

        // Assert drivers standings
        driversSegment.tap()
        XCTAssertTrue(app.cells.staticTexts["1"].exists) // Position
        XCTAssertTrue(app.cells.staticTexts["Max Verstappen"].exists)
        XCTAssertTrue(app.cells.staticTexts["100 PTS"].exists) // Points
        XCTAssertTrue(app.cells.staticTexts["2"].exists)
        XCTAssertTrue(app.cells.staticTexts["Lando Norris"].exists)
        XCTAssertTrue(app.cells.staticTexts["50 PTS"].exists)
        XCTAssertTrue(app.cells.staticTexts["3"].exists)
        XCTAssertTrue(app.cells.staticTexts["Charles Leclerc"].exists)
        XCTAssertTrue(app.cells.staticTexts["25 PTS"].exists)

        // Assert teams standings
        teamsSegment.tap()
        XCTAssertTrue(app.cells.staticTexts["Red Bull Racing"].exists)
        XCTAssertTrue(app.cells.staticTexts["125 PTS"].exists)
        XCTAssertTrue(app.cells.staticTexts["McLaren"].exists)
        XCTAssertTrue(app.cells.staticTexts["75 PTS"].exists)
        XCTAssertTrue(app.cells.staticTexts["Ferrari"].exists)
        XCTAssertTrue(app.cells.staticTexts["25 PTS"].exists)

        // No error
        let errorAlert = app.alerts["Error"]
        XCTAssertFalse(errorAlert.waitForExistence(timeout: 1))
    }

    func testStandingsView_NavigatesToDriverDetailFromStandings() throws {
        // Navigate to Standings tab
        let standingsTab = app.tabBars.buttons["Standings"]
        if standingsTab.waitForExistence(timeout: 2) {
            standingsTab.tap()
        }

        let progressView = app.activityIndicators.firstMatch
        XCTAssertTrue(progressView.waitForExistence(timeout: 2) == false)

        let driversSegment = app.buttons["SegmentedView[0]"]
        XCTAssertEqual(driversSegment.label, "Drivers")
        driversSegment.tap()

        // Tap first drivers standings row (Max Verstappen)
        let firstRow = app.cells.staticTexts["Max Verstappen"]
        firstRow.tap()

        // Wait for detail view load
        let progressDetailView = app.activityIndicators.firstMatch
        XCTAssertTrue(progressDetailView.waitForExistence(timeout: 2) == false)

        // Assert detail view
        XCTAssertTrue(app.staticTexts["33"].exists)
        XCTAssertTrue(app.staticTexts["Netherlands"].exists)
    }

    func testStandingsView_NavigatesToTeamDetailFromStandings() throws {
        // Navigate to Standings tab
        let standingsTab = app.tabBars.buttons["Standings"]
        if standingsTab.waitForExistence(timeout: 2) {
            standingsTab.tap()
        }

        let progressView = app.activityIndicators.firstMatch
        XCTAssertTrue(progressView.waitForExistence(timeout: 2) == false)

        let teamsSegment = app.buttons["SegmentedView[1]"]
        XCTAssertEqual(teamsSegment.label, "Teams")
        teamsSegment.tap()

        // Tap first teams standings row (Read Bull Racing)
        let firstRow = app.cells.staticTexts["Red Bull Racing"]
        firstRow.tap()

        // Assert toolbar item (info.circle exists)
        XCTAssertTrue(app.navigationBars.buttons["info.circle"].exists)

        // Assert header
        XCTAssertTrue(app.staticTexts["Red Bull Racing"].exists)

        // Assert body
        XCTAssertTrue(app.staticTexts["Team Nationality"].exists)
        XCTAssertTrue(app.staticTexts["Austria"].exists)
        XCTAssertTrue(app.staticTexts["First Appeareance"].exists)
        XCTAssertTrue(app.staticTexts["2005"].exists)
        XCTAssertTrue(app.staticTexts["Constructors Championships"].exists)
        XCTAssertTrue(app.staticTexts["6"].exists)
        XCTAssertTrue(app.staticTexts["Drivers Championships"].exists)
        XCTAssertTrue(app.staticTexts["8"].exists)

        // Biography
        XCTAssertTrue(app.staticTexts["Biography"].exists)
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'Formula One racing team'")).firstMatch.exists)

        // Test navigation back
        app.navigationBars.buttons["BackButton"].tap() // Back button
        let navBar = app.navigationBars.firstMatch
        XCTAssertTrue(navBar.staticTexts["Standings"].exists)
    }
}
