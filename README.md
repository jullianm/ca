## Architecture
The application uses two local packages: Core and App to isolate both networking layer (services, decodable models, endpoints..) and UI layer (view controllers, view models, coordinators)<br>
App package uses MVVM-C to bind business logic from view models to their respective controllers (e.g `MyAccountsViewController`  and `MyAccountsViewModel` ). <br>
View models interact with their controllers using the delegate pattern<br>

App package depends on Core package. (Core cannot import App)

## UI
App package uses only xib files (no storyboard).

## Controllers
Controllers conform to a protocol (e.g `MyAccountsViewPresentable`) which is used by the view model to pass the data back to its dedicated controller<br>

## View models
View models conform to a protocol (e.g `MyAccountsViewModelable`) which is used by the view controller to communicate with the view model<br>
⚠️ All business logic must go in view models.

## Navigation
The navigation stack is managed by coordinators to isolate each module navigation logic. (e.g `MyAccountsCoordinator`)

## Dependencies
The app has a third-party library `Charts`. 

## Unit tests
Core package covers API unit testing.<br>
App package covers view models (business logic) unit testing.
