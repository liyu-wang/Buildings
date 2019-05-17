# liyu_mobile

0. Architecture and Design
The demo app uses the MVVM architectural pattern with the RxSwift framework to do the binding between views and and the corresponding view models. View models have their dependent services (DAO or webService) injected to them. So for the Unit tests, the dependencies could be easily swaped with the Mock implementations.


1. Libs used in the demo

- for reactive programming
RxSwift
RxCocoa

- for downloading images asynchronously
Kingfisher

2. Installation guide.

To run the app, you need to use the Cocoapods to install all the dependencies. $ sudo gem install cocoapods

then go to the app folder, run $ pod install

After all the dependencies have been install, open the Buildings.xcworkspace and you are ready to go.
