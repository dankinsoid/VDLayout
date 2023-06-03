# Reloadable Views

This extension provides reloadable functionality for `UITableView`, `UIStackView`, and `UICollectionView`. 

It introduces several structures and an enum to assist with the management of cells within these views:

- `CellsSection`: An identifiable struct to represent a section of cells.
- `CellsSectionsBuilder`: An enum to aid in building sections of cells.
- `ViewCellsReloadable`: A protocol to mark a view as having reloadable cells.
- `ViewCell`: An identifiable struct to represent a cell within a view.
- `ViewCellsBuilder`: An enum to assist in building cells.

These elements come together to provide powerful reloading capabilities to your views. These capabilities are provided through several `reload` functions which take in a closure to generate cells, along with optional parameters to define cell creation, reloading, sizing and identification.

Here are some of the functionalities provided:

- `reload(_:)`: Reloads the cells in a reloadable view using a closure that creates an array of `ViewCell`s.
- `reload(data:create:reload:size:)`: Reloads the cells in a reloadable view using data, a closure for creating cells, a closure for reloading cells, and a closure for sizing cells.
- `reload(data:size:create:)`: Reloads the cells in a reloadable view using data, a closure for sizing cells, and a closure for creating cells.
- `reload(data:id:create:reload:size:)`: Reloads the cells in a reloadable view using data, a function to generate unique identifiers, closures for creating and reloading cells, and a closure for sizing cells.
- `reload(data:id:size:create:)`: Reloads the cells in a reloadable view using data, a function to generate unique identifiers, a closure for sizing cells, and a closure for creating cells.

These `reload` functions use a variety of parameters to control the reloading of the cells in the view. By utilizing these functions, you can easily manage the cells within your views and ensure they are always up-to-date.