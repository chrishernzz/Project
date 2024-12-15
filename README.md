Yesenia Designs iOS App
- Isaiah Vogt
- Christian Hernandez

Goals
The aim of Yesenia Designs iOS is to construct a functioning e-commerce iOS application that mimics the functionality of the Yesenia Designs shop website. The iOS implementation intends to allow users to browse the same 
products that are visible on the website shop and to make purchases. The iOS application must maintain the appealing UI/UX design that was established with the initial website and provide a user-friendly interface for 
interacting with products. For the sake of security the application must carry out user transactions using StoreKit, a Swift API that is usable by members of the Apple Developer Program.

Functionalities
1. User Download
A user must be able to download the iOS application from the iOS App Store. The current iteration of the application is not yet reviewed and approved by Yesenia Hernandez, and thus it is not yet ready for deployment.
Additionally, the developer team must be approved for the Apple Developer Program before the application is ready for deployment. The application is estimated to be near completion and will be reviewed by Yesenia Hernandez
 by the end of 2024.
User Signup, Login, Logout
A user must be able to create an account within the iOS application. The user must enter a unique username and password on a sign up page and will be granted a JSON web token that validates their registration. The
application database must persist the user’s sign up information to create a user data entry. This will allow the user to leave the application, login, and logout from the application and still persist their account.
Accordingly, there will be a login page where the user will enter their username and password to gain access to their account and a logout page to relinquish access to their account. User’s will maintain their login
credentials using a JSON web token that has a specified expiration date and will be persisted using Swift’s UserDefaults class. Upon successful logout, the JSON web token will be removed from the UserDefaults class.
User’s will be unable to populate their shopping cart, carry out transactions, or view orders while they are not logged in.
3. Shop
A user may browse the Yesenia Designs products in the shop page. The displayed products must be the same as those that are displayed on the Yesenia Designs shop website: https://yeseniadesignsshop.com/shop. The
product name, image, price, and description must be visible on the shop page. User’s may select a product type and the corresponding products of this type will be displayed. Each of the products will be contained
 within the application databases shop relation. The iOS application will fetch all of the products from the application database. The product type loading feature will only fetch products corresponding to the
selected product type.
5. Shopping Cart
A user that is signed in may view a button titled, ‘Add to Cart,’ that will be visible under each product. Upon selection of the button, the user’s shopping cart will be populated with this product. Each user
 will be granted a single shopping cart. This shopping cart will be linked using a foreign key, one to one relationship to the user’s database relation and will be maintained as a shopping cart relation. This
 shopping cart will maintain the subtotal of the products that have been selected, the username of the user that it belongs to, the status, and a list of product database instances that have been added by the
 user. The status will be of an Enum type that is either ‘precheckout’ or ‘postcheckout.’ By default, the cart will be assigned a status of ‘precheckout.’ The user may view the list of products maintained within
 their shopping cart by clicking a shopping cart icon that is at the top left corner of the screen. Under each displayed product will be a button title, ‘Remove,’ that will allow the user to remove the product
 from their shopping cart. A button at the top left corner titled, ‘Checkout,’ will create an Order relation using the Shopping Cart. This button will assign the shopping cart status to ‘postcheckout’ which will
 trigger the creation of the order relation and the termination of the current shopping cart. Once the shopping cart is deleted a new, empty shopping cart will be assigned to the user.
7. Transactions
The developers have yet to be approved by the Apple Developer Program and, thus, do not have access to the StoreKit library. Once the developers are approved for this program, transactions will be implemented
 after the user selects the ‘Checkout’ button.
9. Orders
A user that is signed in and has selected the ‘Checkout’ button in the shopping cart view will be assigned an order. Each order is maintained in the application database as an order relation. This relation is
 linked to each user using a foreign key, one to many relationship. An order entity will maintain the following attributes: placement date, total, a list of products ordered, the order status, and the unique
 username of the user that the order belongs to. The placement date will be recorded as a Date type when the Order object is created. The total will be the subtotal that was maintained by its corresponding
 shopping cart with the addition of the tax and shipping price. The order status will be set by default to ‘processing.’ This status will be dynamically updated when the order is processed, shipped by the
 seller, and is delivered. The status will be set to ‘processed,’ ‘shipped,’ and ‘delivered’ accordingly. Once the order has been placed by the user, the order will appear on the user’s orders page. Each
 past order’s placement date, status, and total will be displayed on this page. The website owner will view each order entity within the database and will be capable of changing the status.
Contact Form
A user that is either not signed in or is signed will be able to submit a contact form to the website owner. This contact form will allow the user to enter their first and last name, email address, subject,
 and a message. A button titled, ‘Send Message,’ will subsequently create a Contact entity within the application database. The website owner will view each contact entity within the database and will be
 capable of responding by using the user’s email address.
11. Website Features
The iOS application will maintain similar features to the website. In addition to the listed functionality above, the user will be able to navigate through the application using a popout navigation bar.
 The navigation bar will contain the following links: Home, Blog, Watch Videos, Shop, Orders, Tools and Supplies, Newsletter, Contact, Login/Register, Logout. The home page will link to tutorial videos
 that have been uploaded to YouTube by the website owner. The videos will be playable within the application. The home page will display the website owner’s instagram account. The blog page is currently
 statically populated and maintains the past blog uploads by the website owner. In the future, this page will also be maintained by the application database and users will be able to like and comment
 each post. Each post on the blog maintains a title, date, video/media link, and description. The videos page will display a list of uploaded videos based on product type. The tools and supplies page
 will display a list of supplementary tools that aid the user when putting together each craft product. The newsletter page will have a form that allows users to input their name and email address and
 click a button titled, ‘Subscribe.’ This form will update each user entity which contains a boolean attribute called ‘subscribed.’ If subscribed is set to True, then the user will receive email updates
 from the website owner. On each page, a footer that contains the website owner’s social media links and email will be visible.

Architecture and Design
Programming Languages and Frameworks
The Swift Programming language will be used for front-end and back-end design. The Vapor framework will be used for the back-end design. Vapor is primarily used for making database requests. The IDE
used will be Xcode. The version control system will be GitHub. The jwt-kit and jwt-decode libraries will be used for creating authenticating JSON web tokens and decoding back-end responses, respectively.
Database Design
MongoDB will be used for the cloud database cluster. The Fluent ORM framework will be used by the Vapor back-end to format database requests and responses. Fluent-mongo-driver is a library used by
Fluent to communicate and format requests and responses with the MongoDB cluster. The MongoDB cluster’s product entities were manually populated using the Yesenia Designs website’s shop page as a reference.
Architecture
The application front-end and back-end consist of two separate Xcode projects that must be built and run simultaneously. Upon deployment, the back-end will run on a server and will listen for
requests from the front-end on a determined port. The front-end makes requests to the server using the URLSession function that is defined in Swift’s Foundation library. The URLSession receives a
formatted request from the front end and constructs a url string and payload that is sent to port 8080. The server will listen for traffic on port 8080 and will route requests to its defined controllers
based on the url string of the request. Each controller is delimited by the database relation with which it is concerned with. For example, a controller used for creating and returning users entities
is defined as the UserController and a controller used for creating and returning orders is defined as the OrderController. Each controller makes API requests to the application’s MongoDB cluster.
The back-end will establish a connection with the MongoDB cluster, upon being started, using a URI connection string located in the configure.swift file.

Github
	A separate front-end and back-end github repository are maintained to ease the process of development. To access these repositories, a user must request access from the developers.
Front-end repository: https://github.com/chrishernzz/Yesenia-Designs-App
Back-end repository: https://github.com/ivogt12/Yesenia-Designs-Server

Deployment and Running the Application
	To download the application, a user must clone both the front-end and back-end repository. The user must navigate to either the front-end or back-end directory that they would like to run the
 application within and run the command: git clone <github-repository-link>.
To install all of the necessary packages the user must run the command: swift package resolve. This command must be run in both the front-end and back-end directories.
To run the application, the user must have Xcode installed. The user must open both the front-end and back-end code bases using Xcode and wait for the application to be properly indexed and built
by Xcode. When this process is complete, the user must click the play icon button to run the application.
