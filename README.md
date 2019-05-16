# liyu_mobile

0. Architecture and Design
The demo app uses the MVVM architectural pattern with the RxSwift framework to do the binding between views and and the corresponding view models. View models have their dependent services (DAO or webService) injected to them. So for the Unit tests, the dependencies could be easily swaped with the Mock implementations.


1. Libs used in the demo

- for reactive programming
pod 'RxSwift', '~> 5'
pod 'RxCocoa', '~> 5'

- for downloading images asynchronously
pod 'Kingfisher'

2. Installation guide.

To run the app, you need to use the Cocoapods to install all the dependencies. $ sudo gem install cocoapods

then go to the app folder, run $ pod install

After all the dependencies have been install, open the Buildings.xcworkspace and you are ready to go.

3. assumptions and improvements
- the demo use in memory mock db to store the fitler tag, would be even better to use mobile DB such as realm or corecore with the rx support.
- pull down to refresh buildings is good for the user experience, due to the time constraint the demo app doesn't have it. but it is definitely worth doing it. 

