# Explain It Like I'm a Back-Ender: React & Redux
By [Daniel Frampton](https://github.com/DanielEFrampton)

I'm a back-end engineering student at the Turing School of Software & Design, and I recently took on a brownfield project which has given me the opportunity to dive into React and Redux. I have no idea what I'm doing. Come along with me while I try to articulate React and Redux concepts and relate them to analagous concepts in Ruby on Rails.

## React

React is a client-side JavaScript (i.e., in the browser, not on the server) development framework. In a similar way to how Rails provides conventions and convenient structures for how to design and configure models, views, and controllers, React provides conventions and structures for creating UI *components* in order to render HTML pages in a dynamic and more object-oriented fashion.

### Components

So where Rails apps are made up of Models, Views, and Controllers, React is made up primarily of Components. Unlike Rails, where logic and presentation are kept as separate as possible, [Components can have both](https://reactjs.org/docs/introducing-jsx.html#why-jsx). In the project I'm working on, for example, each component class has a number of functions/methods which handle the logic related to a particular chunk of UI as well as a `render()` function which contains the HTML itself.

Components come in two varieties: *function components* and *class components*, which are pretty much what they sound like: the first is defined as a function (like a Ruby method) and the second is defined as a class which extends (i.e., inherits from) the React.Component class. The latter are typically broken into separate directories and files, so that a common file structure for a React app would look like this:
```
app
  - src
    - components
      - ExampleComponent
        - index.js        # This is where the ExampleComponent class component lives
        - index.test.js   # Test/spec file for this class component
      - OtherComponent
        - index.js        # Here's another class component
        - index.test.js
    index.js              # This is the central JavaScript file which manages the React app
```

Components have properties, referred to as *props*, which function similarly to instance variables and instance methods in a Ruby class. Where they get those props from brings us to Redux.

## Redux

Because it is client-side and has no database backing it up like a Rails View would, React cannot keep track of state (i.e., persistent data) on a global level across multiple pages of the app. Redux provides this functionality, allowing React to save data to the "store" so that it can be accessed and modified from any page of the app. This is similar to how you might use sessions in Rails to have session-specific data persist across multiple views without storing it to the DB.

### Containers

When React and Redux are combined, Components are [sometimes broken into two categories](https://stackoverflow.com/questions/43414254/difference-between-component-and-container-in-react-redux): components which interact with the Redux store via [the Redux `connect()` function](https://github.com/reduxjs/react-redux/blob/master/docs/api/connect.md#connect), sometimes called "Containers," and components which do not. In our project they are divided into "Containers" and "Components." An example of a component would be the `HamburgerMenu` component, which handles a very small element of the UI which doesn't need to interact with the global Redux store; an example of a container would be the `SignIn` container which handles the sign-in page and interacts with the Redux store by adding data to it about the currently signed-in user. This is similar to how in Rails a sign-in page might create a User object and store it in the session, accessible later via a `current_user` helper method in `application_controller.rb`.

Containers' properties (or _props_) are defined using two unique functions: `mapStateToProps`, which reads data from the store and "maps" it to the component's props, and `mapDispatchToProps`, which maps Actions or Thunks (described below) to props so they can be dispatched by the component. If that doesn't make any sense, and you want it to, read on.

### Actions

Redux comes with a few more layers which define _how_ components access the store: *actions* and *reducers*. [Actions](https://redux.js.org/basics/actions) are functions/methods used to send data to the Redux store from the React application. When an action (or _action creator_) is used, it creates a JavaScript object from the arguments provided to it which is sent to the store via the *dispatch* method; in pseudo-code, "_dispatch_ the object created by this _action_ to the _store_." Back-enders might think of this as data being sent from a View to a particular Controller via `params` and a form element.

### Reducers

[Reducers](https://redux.js.org/basics/reducers) are functions/methods which define _how_ the store changes in response to an action/dispatch, which is analogous to a create, modify, or update Controller action in Rails taking data from `params` and using Model methods to make changes in the DB. They take in the _current state_ and the new information dispatched to the action and return a new state, which is then saved to the Redux store. See [this description of the Redux data flow](https://redux.js.org/basics/data-flow) for more details.

There can be multiple Reducers, each in their own file, which are bundle together in a RootReducer function which  combines the output of multiple reducers to update the store. Typically that resides in the `src/reducers/index.js` file.

If we incorporate Redux containers, actions, and reducers, here's how the file structure might look:
```
app
  - src
    - actions
      - index.js            # In our app, all the actions live in one file
    - components
      - ExampleComponent
        - index.js        
        - index.test.js   
      - OtherComponent
        - index.js        
        - index.test.js
    - containers
      - ExampleContainer
        - index.js        
        - index.test.js   
      - OtherContainer
        - index.js        
        - index.test.js
    - reducers
      - anotherReducer.js
      - index.js          # the RootReducer function lives here, imports other reducers
      - otherReducer.js   # individual reducers can have their own files
    index.js
```
This summary (taken from [this tutorial](https://medium.com/fullstack-academy/thunks-in-redux-the-basics-85e538a3fe60)) excellently summarizes the data flow:

>  Action creators create objects → objects are dispatched to the store → the store invokes reducers → reducers generate new state → listeners are notified of state updates.

### Thunks

In our project, in addition to these React and Redux layers there's a piece of middleware called [Thunk](https://daveceddia.com/what-is-a-thunk/) which lets you create--wait for it--*thunks*. Thunks improve upon actions. Instead of actions being pure objects (like Ruby hashes) with no functionality, Thunks are actions that include functions which are resolved before passing the resolved action on to the reducers and store; functions such as API calls.

This is similar to how a View in Rails can contain ERB tags which execute and then replace themselves with their return values in the HTML files before being sent to the client. It's also similar to a Rails Facade, a PORO which does some work and perhaps integrates other POROs (such as API-related Service POROs) between the Controller and the View.

Thunks are situated in the data flow after the components and before the reducers and store. It can be dispatched, like an action, and can either pass its return values along to the store or to another action. See "Middleware" in this excellent illustration from [this excellent tutorial](https://medium.com/fullstack-academy/thunks-in-redux-the-basics-85e538a3fe60).

![Image source: http://slides.com/jenyaterpil/redux-from-twitter-hype-to-production](https://miro.medium.com/max/2880/1*QERgzuzphdQz4e0fNs1CFQ.gif)

For example, in our app we're making some changes to the creation and updating of user profiles. As it stands, the `Profile` Container (not component, because it will interact with the Redux store) dispatches the `createUser` Thunk along with the user's input as an argument. Inside that Thunk, a POST request is made to our GraphQL "createUser" mutation endpoint (like an API that performs CRUD actions in our back-end database) with the user input, which in turn returns a User JSON object (i.e, hash). It then provides that User object to the `setUser` Action, which in turn is dispatched to the Store.

## An Example: Building a New Container

In our app, we want to add a page to display statistics for the signed in user. I'll describe the steps I went through to add that new page by building a new container and connecting it to all these React and Redux pieces.

### Creating a Route

In the `src/containers` folder there is a sub-folder for the App container which uses the `react-router-dom` package to control navigation with `<Route>` and `<Link>` tags (JSX tags, to be exact, which are like ERB tags in Rails). A `<Link>` (or functionally equivalent `<NavLink>`) tag will correspond to a `<Route>` and render the path and component specified by that `<Route>`. For example, in our app we have this `HamburgerMenu` component which renders this HTML/JSX:
```javascript
<ul className='HamburgerMenu--ul'>
  <li className='HamburgerMenu--li'>
    <NavLink
      to='/schedule'
      className='Header--link'
      onClick={this.handleClick}
    >
      View Schedule
    </NavLink>
  </li>
  <li className='HamburgerMenu--li'>
    <NavLink
      to='/book-pairing'
      className='Header--link'
      onClick={this.handleClick}
    >
      Book a Pairing
    </NavLink>
  </li>
  <li className='HamburgerMenu--li'>
    <NavLink
      to='/edit-profile'
      className='Header--link'
      onClick={this.handleClick}
    >
      Edit Profile
    </NavLink>
  </li>
  <li className='HamburgerMenu--li'>
    <button
      className='Header--button--signout'
      onClick={handleSignOut}
    >
      Sign Out
    </button>
  </li>
</ul>
```
The `onClick={this.handleClick}` lines connect to the behavior described earlier in the file of expanding or minimizing the menu when it is clicked anywhere, and the `className` and `<li>` elements are related to styling the list of links. The important part for our purposes is the code inside the `<NavLink>` elements, because we want to add a new one to our stats page.
```javascript
<NavLink
  to='/edit-profile'
  // ...
>
  Edit Profile
</NavLink>
```
The `to=` line will look for a `<Route>` element with a matching `path=` property and render the component it indicates. So, if we want to create a Stats component, we could add a `<Route>` element in the core App container like this:
```js
<Route path='/stats-profile' component={Stats} />
```
And add a `<NavLink>` element to the HamburgerMenu component like this:
```js
<li className='HamburgerMenu--li'>
  <NavLink
    to='/stats-profile'
    className='Header--link'
    onClick={this.handleClick}
  >
    View Stats
  </NavLink>
</li>
```
At this point, I notice that the Jest test suite which I left open (`npm run test:dev`) has been automatically running every time I save a change to a file, and it is severely unhappy about a reference to a `Stats` class component that doesn't exist. Let's ease its misery.

### Creating a Container

I need to let you, the internet (pop. 7 billion), in on a secret. I know I can trust you to keep it amongst yourselves. When making changes to an existing app in a framework you're unfamiliar with, pattern matching is a life-saver. It means I don't necessarily have to understand everything I see at a deep level in order to make changes in it; if I have a general understanding of what a piece of code is doing, and I can copy the patterns I see to make it do a new, similar thing.

So I'm going to pattern match the heck of out some other containers.

Taking the existing "Profile" container as my blueprint, because it's the one I've already made some changes to and most familiar with, the first thing I see is a chunk of `import` lines:
```js
import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';
import { Dropdown } from '../../components/Dropdown';
import { createUser } from '../../thunks/createUser';
import { updateUser } from '../../thunks/updateUser';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
```
Importing is similar to `require` in a Ruby file, and a little bit like `include`; it makes the specified class (or in this case, "module") and its functions `from` a target package or file available to reference in another file. In the case of React/Redux, which classes are available to import is determined what what is _exported_ from a file with the `export` keyword. We'll see that momentarily. See [this tutorial](https://www.geeksforgeeks.org/reactjs-importing-exporting/) for more on import/export.

The very next line introduces the bulk of this file:
```
export class Profile extends Component {
```
From this line to line 233 is the Profile class which this file exports, and which extends (think Rails inheritance, like a controller inheriting from ApplicationController) Component. We'll spend a lot more time in its innards later. The rest of the file contains [`const` variables](https://dev.to/sarah_chima/var-let-and-const--whats-the-difference-69e) (similar to [Ruby constants](https://www.rubyguides.com/2017/07/ruby-constants/))pointing to the `mapStateToProps` and `mapDispatchToProps` functions described above in the Containers section:
```js
export const mapStateToProps = state => ({
  user: state.user
});

export const mapDispatchToProps = dispatch => ({
  createUser: (user, availabilities) =>
    dispatch(createUser(user, availabilities)),
  updateUser: user => dispatch(updateUser(user))
});
```
The former pulls in the initial state of the component from the global Redux store (think of a Ruby initialize block, `def initialize(user); @user = user; end`). The latter prepares two Thunk actions (`createUser` and `updateUser`) for the class to be able to use later to dispatch actions to the Redux Store and, with Thunks, make API calls. In this case, both of these are Thunks and will both update the Redux store and make calls to our GraphQL API endpoint and, through that, update our back-end database.

The next block contains the "export default" which each component has and defines what will be imported when another file simply has `import ClassName from '../filepath'`. At its most basic it looks this:
```
export default ClassName;
```
Here, it appears to be used to ensure that when the Profile container is imported it takes its connections to the Redux store (which make it a "container" and not just a "component") along with it.
```js
export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Profile);
```
The final block defines [PropTypes](https://reactjs.org/docs/typechecking-with-proptypes.html) to validate data types on information flowing through the container:
```js
Profile.propTypes = {
  createUser: PropTypes.func,
  email: PropTypes.string,
  phoneNumber: PropTypes.string,
  firebaseID: PropTypes.string,
  image: PropTypes.string,
  name: PropTypes.string,
  user: PropTypes.object,
  updateUser: PropTypes.func
};
```

(As an aside, that linked tutorial led me to learn that React apps do have a [development mode](https://overreacted.io/how-does-the-development-mode-work/) distinct from production mode, which work like the Rails "development" and "production" environments. PropTypes are only checked in development mode.)

Now, back inside the Profile class, there's a bunch of stuff. Like a Rails controller there is a mix of conventional functions which appear in all components, and helper functions which facilitate the work of the primary ones:
```js
  constructor(props) {
  // ...
  checkDropdowns = () => {
  // ...
  componentDidMount() {
  // ...
  formatUserData = () => {
  // ...
  handleChange = event => {
  // ...
  handleSubmit = async event => {
  // ...
  removeMessage = () => {
  // ...
  render() {
```

The [only required function](https://reactjs.org/docs/react-component.html) is `render()`, mentioned above, which is responsible for rendering the component's HTML and contains JSX tags, like a Rails ERB-format View. Many of the other methods in Profile are part of the standard component lifecycle, [helpfully depicted here](http://projects.wojtekmaj.pl/react-lifecycle-methods-diagram/), which are broken into "Mounting, "Updating," and "Unmounting" phases.

## To be continued...
