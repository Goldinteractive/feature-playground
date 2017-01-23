import gi from 'gi-js-base'

/**
 * Playground feature child class for testing purposes.
 */
class Playground extends gi.features.Feature {

  init() {
    console.log('Hello World!')
  }

  destroy() {}

}

export default Playground
