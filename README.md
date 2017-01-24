## Playground Feature

Playground Feature class for testing purposes.

### Dependencies

* [`gi-js-base`](https://github.com/Goldinteractive/js-base)

### Installation

Install this package with yarn:

    yarn install gi-feature-playground
  
  or with npm:
    
    npm install gi-feature-playground

After the installation has completed, you can import the module:

```javascript
// import complete library with all modules
import Playground from 'gi-feature-playground'

base.features.add('playground', Playground)
```

```sass
@import 'gi-feature-playground/src/style';
```

To take over the assets, move the `assets` folder contents inside your project asset folder.

### Browser compatibility

* Newest two browser versions of Chrome, Firefox, Safari and Edge
* IE 9 and above

### Development

* `npm run build` or `make build` - Build production version of the feature.
* `npm run dev` or `make dev` - Build demo of the feature, run a watcher and start browser-sync.
* `npm run test` or `make test` - Test the feature.
* `make jsdoc` - Update documentation inside the `docs` folder.
