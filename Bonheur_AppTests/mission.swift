//
//  mission.swift
//  Bonheur_App
//
//  Created by cyrilH on 03/11/2025.
//
import XCTest
@testable import Bonheur_App

final class MissionTests : XCTestCase {
    var missions : ChallengeViewModel!
    
    override func setUpWithError() throws {
        missions = ChallengeViewModel()
        missions.challenges = [
            MissionDTO(id: UUID(), nom:"et de un"),
            MissionDTO(id: UUID(), nom:"et de deux"),
            MissionDTO(id: UUID(), nom: "et de trois")
        ]

            missions.currentIndex = 1
    }
    
    
    override func tearDownWithError() throws {
        missions = nil
    }
    
    func testcurrentMision_verifieSiLeTableauNestPasViDe_doitRetournerLaMissionCourante() throws {
        
        let doitRetourner = "et de deux"
        
        let missionCourante = missions.currentMision
        
        XCTAssertNotNil(missionCourante, "missionCourante ne doit pas être nil lorsque la liste n’est pas vide.")
        XCTAssertEqual(missionCourante?.nom, doitRetourner, "La mission retournée ne correspond pas à celle de l’index courant.")
        
    }
    
    func testCurrentMission_SiLeTableauEstVide_retourneNil() throws{
        missions.challenges = []
        let missionCourante = missions.currentMision
        
        XCTAssertNil(missionCourante, "currentMision doit être nil lorsque la liste est vide.")
    }
}
    



//var currentMision: MissionDTO? {
//    guard !challenges.isEmpty else { return nil }
//    return challenges[currentIndex]
//}

