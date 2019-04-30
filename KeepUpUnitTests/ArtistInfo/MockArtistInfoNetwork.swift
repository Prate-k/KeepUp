//
//  MockArtistInfoNetwork.swift
//  KeepUpUnitTests
//
//  Created by Prateek Kambadkone on 2019/04/30.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
@testable import KeepUp

class MockArtistInfoNetwork: ArtistInfoNetworkProtocol {
    var testFailure = false
    weak var repositoryDelegate: ArtistInfoRepositoryProtocol?
    
    func getDataFromNetwork() {
        var result: Result<[String]>
        if !testFailure {
            let info = ["| background      = group_or_band\n", "| origin          = [[Agoura Hills, California]], U.S.\n", "", "| genre           = {{flatlist|\n* [[Alternative rock]]\n* [[nu metal]]\n* {{nowrap|[[alternative metal]]}}\n* [[rap rock]]\n* {{nowrap|[[electronic rock]]}}\n}}\n", "| current_members = <!-- Do not change the order of the members per Template:Infobox musical artist. -->\n* [[Rob Bourdon]]\n* [[Brad Delson]]\n* [[Mike Shinoda]]\n* [[Dave Farrell]]\n* [[Joe Hahn]]\n"]
            result = Result.success(info)
        } else {
            result = Result.failure(Errors.NetworkError)
        }
        repositoryDelegate?.dataReady(result: result)
    }
}
