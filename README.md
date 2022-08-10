# iosDemo
1.  Main screen
- LaunchScreen view controller to show launch screen. It will also check user state (logedin or not) then go to Login screen or User list screen
- Login view controller handle login with github account to get token for call User related APIs
- Users view controller handle get user list and display in a collection view
- UserDetail view controller to show more detail about a selected user

2. There some third party library:
- SDWebImage: To load image from network
- Moya: To do network request
- ObjectMapper: Map network response to internal data model 

3. How to build/install
- Clone source code
- Run command 'pod install' at root directory of project
- Build and Run project

4. How to use App
- Need github account
- When app is open for first time, login is required and after login App will go to main screen (Users view controller). At start if this screen, call API to get user list (paging with page size = 10). This screen will use a collection view to display user list and We can scroll down to load more data
- Select a user (Tap corresponding row) in the list to show more detail information about selected and the UserDetail view controller will be shown. To get user detail information we call API get detail for selected username (refer: https://docs.github.com/en/rest/users/users#get-a-user)
