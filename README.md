## Playground Feature

Playground Feature class for testing purposes.

### Dependencies

* [`gi-js-base`](https://github.com/Goldinteractive/js-base)

### Installation

Install this package with sackmesser:

    make feature-install playground

or when sackmesser is not used:

    yarn install gi-feature-playground

After the installation has completed, you can import the module files:

#### JS (if any):

```javascript
// import complete library with all modules
import Playground from 'gi-feature-playground'
// ...
base.features.add('playground', Playground)
```

#### Styles (if any):

```sass
@import 'gi-feature-playground/src/style';
```

#### Assets (if any, but not necessary if installed with sackmesser `feature-install` command):

Move the `assets` folder contents inside your project's asset folder.

### Browser compatibility

* Newest two browser versions of Chrome, Firefox, Safari and Edge
* IE 9 and above

### Development

* `make build` or `npm run build` - Build production version of the feature.
* `make dev` or `npm run dev` - Build demo of the feature, run a watcher and start browser-sync.
* `make test` or `npm run test` - Test the feature.
* `make jsdoc` - Update documentation inside the `docs` folder.
* `make publish` - Publish npm package.
