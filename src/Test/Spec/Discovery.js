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

export function getSpecs(pattern) {
  return (onError, onSuccess) => {
    const regex = new RegExp(pattern)
    const modulePromises = fs
      .readdirSync(path.join(__dirname, '..'))
      .filter(directory => regex.test(directory))
      .map(name => {
        const fullPath = __onWindows
          ? path.join('file://', __dirname, '..', name, 'index.js')
          : path.join(__dirname, '..', name, 'index.js')
        return import(fullPath).then(module =>
          module && typeof module.spec !== 'undefined' ? { name, spec: module.spec } : null
        )
      })

    Promise.all(modulePromises)
      .then(specs => onSuccess(specs.filter(x => x)))
      .catch(onError)

    return () => {}
  }
}
