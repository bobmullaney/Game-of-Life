//-- Import Libraries -------------------------------------------------------------------------------------------------//

import UIKit



//-- Initialize Variables -------------------------------------------------------------------------------------------------//

// Grid size
let gridSizeX: Int = 4               // Columns or width of grid (Left column is 0, next column is 1, third is 2, etc., from Left to Right.)
let gridSizeY: Int = gridSizeX       // Rows or height of grid (Top row is 0, second row is 1, third row is 2, etc., from Top to Bottom.)

// Initialize cell arrays
var cellCoord: Array = [String]()      // Store coordinates for cell in x,y notation.
var cellCurrentState: Array = [Int]()  // Store the current state of the cell. 0 = Dead, 1 = Alive
var cellNextState: Array = [Int]()     // Store the next state of the cell.



//-- Define Functions -------------------------------------------------------------------------------------------------//

// Convert coordinates to array index value
func coordToIndex(indexX: Int, _ indexY: Int) -> Int {
    return (cellCoord.indexOf("\(indexX),\(indexY)"))!
}

// Function: Count number of valid neighbors
func countNeighbor(countX: Int, _ countY: Int) -> Int {
    // TODO:    Probably change logic to simply iterate through each of the eight neighbor values.
    //          Where neighbor coordinates are outside grid, i.e. invalid, skip and continue
    //          through remaining neighbors.
    let minCoordX:Int = 0
    let maxCoordX:Int = gridSizeX - 1
    let minCoordY:Int = 0
    let maxCoordY:Int = gridSizeY - 1
    var count:Int = 0
    // Is tile located in a corner? Set count to 3.
    if (countX == minCoordX || countX == maxCoordX) && (countY == minCoordY || countY == maxCoordY) {
        count = 3
    }
    // Is tile located on an edge but is not a corner? Set count to 5.
    else if (countX == minCoordX || countX == maxCoordX) && (countY > minCoordY && countY < maxCoordY) {
        count = 5
    }
    else if (countX > minCoordX && countX < maxCoordX) && (countY == minCoordY || countY == maxCoordY) {
        count = 5
    }
    // Tile must be neither a corner nor an edge. Set count to 8
    else if (countX > minCoordX  && countX < maxCoordX) && (countY > minCoordY && countY < maxCoordY)
        {
        count = 8
    }
    // Value(s) out of bounds.
    else { count = -1 }
    return count
}

// Calculate neighbor values when passed x,y coordinates
func valueNeighbor(coordX: Int, _ coordY: Int) -> Int {
    var value:Int = 0
    let cx:Int = coordX
    let cy:Int = coordY
    // Find state of TL
    if (cy > 0 && cy < gridSizeY) && (cx > 0 && cx < gridSizeX) {
        value += cellCurrentState[coordToIndex(cx - 1, cy - 1)]
    }
    // Find state of TC
    if (cy > 0 && cy < gridSizeY) {
        value += cellCurrentState[coordToIndex(cx,     cy - 1)]
    }
    // Find state of TR
    if (cy > 0 && cy < gridSizeY) && (cx > 0 && cx < gridSizeX) {
        value += cellCurrentState[coordToIndex(cx + 1, cy - 1)]
    }
    // Find state of ML
    if (cx > 0 && cx <= gridSizeX) {
        value += cellCurrentState[coordToIndex(cx - 1, cy)]
    }
    // Find state of MR
    if (cx >= 0 && cx < gridSizeX) {
        value += cellCurrentState[coordToIndex(cx + 1, cy)]
    }
    // Find state of BL
    if (cx > 0 && cx <= gridSizeX) && (cy >= 0 && cy < gridSizeY) {
        value += cellCurrentState[coordToIndex(cx - 1, cy + 1)]
    }
    // Find state of BC
    if (cy >= 0 && cy < gridSizeY) {
        value += cellCurrentState[coordToIndex(cx,     cy + 1)]
    }
    // Find state of BR
    if (cx >= 0 && cx < gridSizeX) && (cy >= 0 && cy < gridSizeY) {
        value += cellCurrentState[coordToIndex(cx + 1, cy + 1)]
    }
    return value
}

// Determine the index number of the grid location to be used in the cell state arrays.
//func findIndex(coordX: Int, coordY: Int) -> Int {
//    let index = Int( 3 * coordX + coordY)
//    return index
//}

// Function: Toggle cellState
//func toggleState(cellState: Int) -> Int {
//    if cellState == 0 { return 1 }
//    else if cellState == 1 { return 0 }
//    else { return -1 } // Failure case
//}


//-- Main Code -------------------------------------------------------------------------------------------------//

// Initialize and build cell arrays (i.e.: cellCoord, cellCurrentState and cellNextState) to size specified by gridSizeX and gridSizeY values

for y in 0..<gridSizeX {
    for x in 0..<gridSizeY {
        cellCoord.append(String(x) + "," + String(y))   // Create coordinates "x,y" and add to array
        cellCurrentState.append(-1)                     // Initilize array with a constant value
        cellNextState.append(-1)                        // Initilize array with a constant value
    }
}

// Simulate user selecting cells to toggle              ***// Temporary Code //***
for i in 0..<cellCurrentState.count {
    cellNextState[i] = Int(arc4random_uniform(2))
}

// Copy cellNextState to cellCurrentState
cellCurrentState = cellNextState

// Function to read array and print results to screen
print("Current state value of each cell.")
for i in 0..<cellCurrentState.count {
print (cellCurrentState[i], " ", terminator:"")
    if ((i + 1) % gridSizeX == 0) {
        print()
    }
}
print()

// Print neighbor value for each cell
print("Value of neighbors")
for i in 0..<cellCurrentState.count {
    // Split the coord value and return x and y as integers to pass to the function.
    var xc:Int = cellCoord[i].componentsSeparatedByString(",")[0]!
    var yc:Int = cellCoord[i].componentsSeparatedByString(",")[1]!
    var val:Int = valueNeighbor(xc, yc)
    print (val, " ", terminator:"")
    if ((i + 1) % gridSizeX == 0) {
        print()
    }
}
print()

// Print value of each cell's neighbors.
print("Value of neighbors:", valueNeighbor(0, 0))
//print(cellCurrentState[coordToIndex(1, coordY: 1)])
//print(coordToIndex(1, coordY: 1))

// Update cellNextState array

//-- Debugging Code -------------------------------------------------------------------------------------------------//

/*
// Debugging

print("Debugging...")

// Test: success in any coordinate in grid

print(findIndex(2, coordY: 2))
print(countNeighbor(0,coordY: 0))
print(countNeighbor(0,coordY: 1))
print(countNeighbor(0,coordY: 2))
print(countNeighbor(1,coordY: 0))
print(countNeighbor(1,coordY: 1))
print(countNeighbor(1,coordY: 2))
print(countNeighbor(2,coordY: 0))
print(countNeighbor(2,coordY: 1))
print(countNeighbor(2,coordY: 2))
print(countNeighbor(3,coordY: 2))
print(countNeighbor(2,coordY: 3))

// Test: failure outside of grid
print(countNeighbor(-1,coordY: 2))
print(countNeighbor(2,coordY: -1))


// Print values of arrays
print("Printing contents of cellCoord array.")
for item in cellCoord {
    print(item)
}

print("Printing contents of cellNextState array.")
for item in cellNextState {
    print(item)
}

print("Printing contents of cellCurrentState array.")
for item in cellCurrentState {
    print(item)
}

 
 // Print each cell number as a grid
 //print("Index value of each cell in grid.")
 //for i in 0..<cellCurrentState.count {
 //    print (i, " ", terminator:"")
 //    if ((i + 1) % gridSizeX == 0) {
 //        print()
 //    }
 //}
 //print()
 
 // Current coord list
 //print("Current coordinates list")
 //print(cellCoord)
 //print()
 
 // Print number of neighbors
 //print("Number of neighbors")
 //for i in 0..<cellCurrentState.count {
 //    // Split the coord value and return x and y as integers to pass to the function.
 //    var xc = Int(cellCoord[i].componentsSeparatedByString(",")[0])
 //    var yc = Int(cellCoord[i].componentsSeparatedByString(",")[1])
 //    print (countNeighbor(xc!, coordY: yc!), " ", terminator:"")
 //    if ((i + 1) % gridSizeX == 0) {
 //        print()
 //    }
 //}
 //print()
 
 print("Index is: ", coordToIndex(1,1))
 
 
 
 */

