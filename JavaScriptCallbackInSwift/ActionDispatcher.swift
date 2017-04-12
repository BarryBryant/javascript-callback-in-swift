//
// Created by Barry Bryant on 4/12/17.
// Copyright (c) 2017 BarryBryant. All rights reserved.
//

import Foundation
import TVMLKit

enum Action: String {
    case increment
    case invalidAction

    init(actionName: String) {
        if let action = Action(rawValue: actionName) {
            self = action
        } else {
            self = .invalidAction
        }
    }
}

func dispatchAction() -> @convention(block) (String, String, JSValue) -> () {
    return { (actionName, data, function) in
        let action = Action(actionName: actionName)
        var result: String
        switch action {
        case .increment:
            result = ActionWizard.increment(value: data)
        case .invalidAction:
            result = "Invalid action dispatched"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            function.call(withArguments: [result])
        }
    }
}

enum ActionWizard {

    static func increment(value: String) -> String {
        return "\(value) ++"
    }
}
