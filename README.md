# Web App Seed
It is a basic folder structure with for developing simple web-apps with use of:
[Grunt](http://gruntjs.com/), [CoffeeScript](http://coffeescript.org/), [Less](http://lesscss.org/) and [Bootstrap](http://getbootstrap.com/).

### Requirements
- [GIT](https://git-scm.com/)
- [Node.js](https://nodejs.org/en/) (with [NPM](https://www.npmjs.com/))
- LiveReload for Chrome [here](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei) or for Firefox [here](https://addons.mozilla.org/pl/firefox/addon/livereload/)

### Instalation
    $ cd path/where/you/want/playground/to/be/
    $ git clone https://github.com/katalysteducation/web-app-seed.git
    $ npm install

### Development
You should edit only files under `src` directory. The default Grunt task will watch for changes in `src` directory, compile in to `dist` directory and reflect all changes in your browser with livereload functionality.

##### Livereload
To enable livereload in your browser:
 1. Install extension for your borwser (links under requirements section)
 2. Run your local webserver
 3. Go to your web-app-seed location on your hard drive
 4. Type in your terminal command: `grunt`
 5. Open browser and navigate to url: `http://localhost/url/to/web-app-seed/dist`
 6. Whenever you make changes in coffeescript or less files it will reload your browser and show you updated version.

##### Building
To get minified version type in your terminal the command: `grunt build`. This task will concatenate and minify all JS and CSS files. Also it will remove dependencies from your `index.html` file.
