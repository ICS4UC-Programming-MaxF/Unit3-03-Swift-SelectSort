//
//  main.swift
//  SelectSort
//
//  Created by MFROB on 2026-11-23.
//  Copyright (c) 2026 MFROB. All rights reserved.
//
//  This program reads lines of unsorted integers from input.txt,
//  sorts each line using the selection sort algorithm, and writes
//  the sorted lines to output.txt.
//

import Foundation

/// Sorts an array of integers in place using selection sort.
///
/// - Parameter numbers: the array to be sorted
func selectionSort(_ numbers: inout [Int]) {
    // An array of 0 or 1 items is already sorted
    guard numbers.count > 1 else { return }

    // Move the boundary of the sorted section one step right per pass
    for i in 0..<(numbers.count - 1) {
        // Assume the current item is the smallest so far
        var minIndex = i

        // Scan the unsorted section for anything smaller
        for j in (i + 1)..<numbers.count where numbers[j] < numbers[minIndex] {
            // Remember where the new minimum is
            minIndex = j
        }

        // Swap the minimum into the first unsorted position
        numbers.swapAt(i, minIndex)
    }
}

// Read the whole input file as one string
guard let contents = try? String(contentsOfFile: "input.txt",
                                 encoding: .utf8) else {
    print("Could not read input.txt")
    exit(1)
}

// Holds each sorted line before it is written out
var results: [String] = []

// Process the file one line at a time
for line in contents.split(separator: "\n") {
    // Split the line on spaces and convert each piece to an Int
    var numbers = line.split(separator: " ").compactMap { Int($0) }

    // Sort the numbers for this line
    selectionSort(&numbers)

    // Turn the sorted numbers back into space-separated text
    results.append(numbers.map(String.init).joined(separator: " "))
}

// Write all sorted lines to output.txt, one per line
let output = results.joined(separator: "\n") + "\n"
try? output.write(toFile: "output.txt", atomically: true, encoding: .utf8)