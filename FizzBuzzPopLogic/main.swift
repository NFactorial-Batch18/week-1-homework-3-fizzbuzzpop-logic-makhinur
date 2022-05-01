//
//  main.swift
//  FizzBuzzPopLogic
//
//  Created by Makhinur Talgatova on 01.05.2022.
//

import Foundation

protocol Drawable {
    func draw() -> String
}

struct Line: Drawable {
    var elements: [Drawable]
    func draw() -> String {
        return elements.map { $0.draw() }.joined(separator: "")
    }
}

struct Skip: Drawable {
    func draw() -> String { return "" }
}

struct Fizz: Drawable {
    func draw() -> String { return "fizz " }
}

struct Buzz: Drawable {
    func draw() -> String { return "buzz " }
}

struct Pop: Drawable {
    func draw() -> String { return "pop " }
}

struct AllCaps: Drawable {
    var content: Drawable
    func draw() -> String { return content.draw().uppercased() }
}

@resultBuilder
struct DrawingBuilder {
    static func buildOptional(_ component: Drawable?) -> Drawable {
        return component ?? Skip()
    }
    static func buildBlock(_ components: Drawable...) -> Drawable {
        return Line(elements: components)
    }
}

func draw(@DrawingBuilder content: () -> Drawable) -> Drawable {
    return content()
}
func caps(@DrawingBuilder content: () -> Drawable) -> Drawable {
    return AllCaps(content: content())
}

func isDivisable(number: Int, divisor: Int) -> Bool {
    number%divisor == 0
}

func implyLogic(for number: Int!) -> Drawable {
    let greeting = draw {
        caps {
            if isDivisable(number: number, divisor: 3) {
                Fizz()
            }
            if isDivisable(number: number, divisor: 5){
                Buzz()
            }
            if isDivisable(number: number, divisor: 7) {
                Pop()
            }
        }
    }
    return greeting
}

print("Insert number")

if let insertedNumber = Int (readLine() ?? "") {
    print(implyLogic(for: insertedNumber).draw())
} else {
    print("You need to insert value in order to proceed. Restart to try again.")
}
