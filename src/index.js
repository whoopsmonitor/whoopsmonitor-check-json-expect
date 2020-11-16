require('dotenv').config()
const axios = require('axios')
const objectPath = require('object-path')
const packageJson = require('../package.json')
const validator = require('validator')

const WM_API_ENDPOINT = process.env.WM_API_ENDPOINT
const WM_EXPECT = process.env.WM_EXPECT

// validate the rule first
const expectedLength = WM_EXPECT.split('/').length

// length
if (expectedLength !== 4) {
  console.error(`WM_EXPECT variable expect 4 arguments, got ${expectedLength}.`)
  process.exit(2)
}

;(async function main() {
  try {
    // get the result
    const result = await axios.get(WM_API_ENDPOINT, {
      headers: {
        'user-agent': `${packageJson.name} ${packageJson.author}`
      }
    }).then(response => response.data)

    let [ key, type, operator, value ]= WM_EXPECT.split('/')
    const requiredFields = [key, type, operator, value]

    for (const requiredFieldKey in requiredFields) {
      const requiredField = requiredFields[requiredFieldKey]
      if (typeof requiredField === 'undefined') {
        throw Error(`Key ${requiredFieldKey} required. Currently undefined.`)
      }
    }

    // get the expected key value
    const foundedInResponse = objectPath.get(result, key)

    if (typeof foundedInResponse === 'undefined') {
      throw Error(`Cannot find "${key} in the API response."`)
    }

    switch (type) {
      case 'boolean':
        // we can ignore operator because it is always "="
        if (foundedInResponse.toString() !== value.toString()) {
          throw Error(`Output is not valid, expected: ${operator} ${value}, got: ${foundedInResponse}.`)
        }
      break

      case 'string':
        // exact match
        if (operator === '=' || operator === 'eq') {
          // we can ignore operator because it is always "="
          if (!validator.equals(foundedInResponse.toString(), value.toString())) {
            throw Error(`Output is not valid, expected: ${operator} ${value}, got: ${foundedInResponse}.`)
          }
        }

        // partial match
        if (operator === '*=') {
          if (!validator.contains(foundedInResponse, value)) {
            throw Error(`Output is not valid, expected: ${operator} ${value}, got: ${foundedInResponse}.`)
          }
        }
      break

      case 'number':
      case 'integer':
        value = validator.toInt(value)

        const options = {}

        if (operator === 'lt' || operator === '<') {
          options.lt = value
        }

        if (operator === 'gt' || operator === '>') {
          options.gt = value
        }

        // check for integer larger/great than
        if (Object.keys(options).length) {
          if (!validator.isInt(foundedInResponse.toString(), options)) {
            throw Error(`Output is not valid, expected: ${operator} ${value}, got: ${foundedInResponse}.`)
          }
        } else {
          // just compar both numbers
          if (!validator.equals(foundedInResponse.toString(), value.toString())) {
            throw Error(`Output is not valid, expected: ${operator} ${value}, got: ${foundedInResponse}.`)
          }
        }
      break

      default:
        throw Error(`Unrecognized validation type: "${type}"`)
        break
    }

    console.log(`Output is valid.`)
    process.exit(0)
  } catch (error) {
    console.error(`${error.message}`)
    process.exit(2)
  }
})()
