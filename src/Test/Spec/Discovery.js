import path from 'path'
import fs from 'fs'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const __onWindows = process.platform === 'win32' || process.platform === 'win64'

if (import.meta.url === `file://${process.argv[1]}`) {
  throw new Error(
    'Sorry, purescript-spec-discovery only supports NodeJS environments!'
  )
}

function getMatchingModules (pattern) {
  var directories = fs.readdirSync(path.join(__dirname, '..'))
  const modulePromises = directories
    .filter(function (directory) {
      return new RegExp(pattern).test(directory)
    })
    .map(function (name) {
      const fullPath = __onWindows
        ? path.join('file://', __dirname, '..', name, 'index.js')
        : path.join(__dirname, '..', name, 'index.js')
      var modulePromise = import(fullPath)
      return modulePromise.then(module => {
        return module && typeof module.spec !== 'undefined' ? module.spec : null
      })
    })
  const modules = Promise.all(modulePromises)
  return modules.then(ms =>
    ms.filter(function (x) {
      return x
    })
  )
}

export function getSpecs (pattern) {
  return function () {
    return getMatchingModules(pattern)
  }
}
